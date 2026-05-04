//
//  HomeView.swift
//  expense_tracker_ios
//
//  Created by Touch and Solve on 30/4/26.
//
import SwiftUI

struct HomeView: View, HomeViewProtocol {
    @ObservedObject var presenter: HomePresenter

    var body: some View {
        ZStack {
            // Background Color
            Color(red: 248/255, green: 250/255, blue: 252/255)
                .ignoresSafeArea()
            
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    headerSection
                    
                    summaryGrid
                    
                    recentHistoryHeader
                    
                    contentStack
                }
                .padding(.bottom, 100)
            }
            .refreshable {
                presenter.refreshData()
            }
        }
        .onAppear { presenter.viewDidLoad() }
        .overlay(alignment: .bottomTrailing) { addButton }
        .alert("Error", isPresented: $presenter.showAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(presenter.errorMessage ?? "Unknown Error")
        }
    }

    // MARK: - View Components

    private var headerSection: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text("Dashboard")
                    .font(.system(size: 32, weight: .bold))
                Text(Date().formatted(date: .abbreviated, time: .omitted))
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            Spacer()
            Button(action: { presenter.didTapProfile() }) {
                Image(systemName: "person.crop.circle.fill")
                    .font(.system(size: 34))
                    .symbolRenderingMode(.hierarchical)
                    .foregroundColor(.indigo)
            }
        }
        .padding(.horizontal)
        .padding(.top, 10)
    }

    private var summaryGrid: some View {
        let totalSpent = presenter.expenses.reduce(0) { $0 + $1.amount }
        let formattedTotal = String(format: "$%.2f", totalSpent)
        
        return LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
            BentoCard(title: "Total Spent", value: formattedTotal, color: .purple, icon: "arrow.up.right")
            BentoCard(title: "Monthly Budget", value: "$2,000", color: .blue, icon: "chart.pie")
            BentoCard(title: "Top Category", value: presenter.topCategory ?? "N/A", color: .orange, icon: "fork.knife")
            BentoCard(title: "Transactions", value: "\(presenter.expenses.count)", color: .green, icon: "clock.arrow.circlepath")
        }
        .padding(.horizontal)
    }

    private var recentHistoryHeader: some View {
        Text("Recent History")
            .font(.title2)
            .bold()
            .padding(.horizontal)
    }

    @ViewBuilder
    private var contentStack: some View {
        if presenter.isLoading {
            loadingView
        } else if presenter.expenses.isEmpty {
            emptyStateView
        } else {
            expenseListView
        }
    }

    private var loadingView: some View {
        VStack(spacing: 12) {
            ProgressView()
                .scaleEffect(1.2)
                .tint(.indigo)
            Text("Loading data...")
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.top, 50)
    }

    private var emptyStateView: some View {
        VStack(spacing: 16) {
            Image(systemName: "tray.and.arrow.down")
                .font(.system(size: 50))
                .foregroundColor(.gray.opacity(0.5))
            Text("No expenses recorded yet.")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.top, 50)
    }

    private var expenseListView: some View {
        VStack(spacing: 0) {
            ForEach(presenter.expenses.prefix(5)) { expense in
                ExpenseRow(expense: expense)
                    .padding(.horizontal)
                    .transition(.asymmetric(insertion: .opacity, removal: .identity))
            }
            
            Button(action: { presenter.didTapHistory() }) {
                Text("View All Transactions")
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundColor(.indigo)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(12)
                    .shadow(color: .black.opacity(0.02), radius: 5)
            }
            .padding(.horizontal)
            .padding(.top, 8)
        }
    }

    private var addButton: some View {
        Button(action: { presenter.didTapAddExpense() }) {
            Label("Add Expense", systemImage: "plus")
                .font(.headline)
                .padding(.horizontal, 24)
                .padding(.vertical, 14)
                .background(Color.indigo)
                .foregroundColor(.white)
                .clipShape(Capsule())
                .shadow(color: .indigo.opacity(0.3), radius: 10, x: 0, y: 5)
        }
        .padding(.trailing, 20)
        .padding(.bottom, 20)
    }

    // Required by Protocol
    func showExpenses(_ expenses: [ExpenseEntity]) {}
    func showError(_ message: String) {}
}

// MARK: - Subviews

struct BentoCard: View {
    let title: String
    let value: String
    let color: Color
    let icon: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Circle()
                .fill(color.opacity(0.2))
                .frame(width: 36, height: 36)
                .overlay(
                    Image(systemName: icon)
                        .foregroundColor(color)
                        .font(.system(size: 14, weight: .bold))
                )
            
            VStack(alignment: .leading, spacing: 2) {
                Text(value)
                    .font(.title3)
                    .fontWeight(.bold)
                Text(title)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .padding()
        .frame(height: 130)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.white)
        .cornerRadius(24)
        .shadow(color: .black.opacity(0.03), radius: 10, x: 0, y: 5)
    }
}

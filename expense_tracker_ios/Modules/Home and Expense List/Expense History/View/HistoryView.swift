//
//  HistoryView.swift
//  expense_tracker_ios
//
//  Created by Touch and Solve on 30/4/26.
//
import SwiftUI

struct HistoryView: View, HistoryViewProtocol {
    @StateObject var presenter: HistoryPresenter
    
    // For Modal Selection
    @State private var selectedExpense: ExpenseEntity?

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Custom Navigation Bar
            HStack {
                Button(action: {
                    withAnimation { AppStateManager.shared.currentRoute = .home }
                }) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 18, weight: .bold))
                        .padding(12)
                        .background(Color.white)
                        .clipShape(Circle())
                        .shadow(color: Color.black.opacity(0.05), radius: 5)
                }
                .foregroundColor(.black)
                
                Spacer()
                Text("Transaction History").font(.headline)
                Spacer()
                Spacer().frame(width: 44)
            }
            .padding(.horizontal)
            .padding(.top, 20)
            .padding(.bottom, 10)
            
            if presenter.expenses.isEmpty {
                emptyStateView
            } else {
                // Using ScrollView + LazyVStack for tighter spacing control
                ScrollView {
                    LazyVStack(spacing: 10) { // Tight spacing between cards
                        ForEach(presenter.expenses) { expense in
                            ExpenseRow(expense: expense)
                                .onTapGesture {
                                    selectedExpense = expense
                                }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 10)
                }
            }
        }
        .background(Color(red: 248/255, green: 250/255, blue: 252/255).ignoresSafeArea())
        .onAppear { presenter.viewDidLoad() }
        // Modal for Expense Details
        .sheet(item: $selectedExpense) { expense in
            ExpenseDetailView(expense: expense)
                .presentationDetents([.medium, .large]) // Modern half-sheet
                .presentationDragIndicator(.visible)
        }
    }
    
    private var emptyStateView: some View {
        VStack(spacing: 20) {
            Spacer()
            Image(systemName: "doc.text.magnifyingglass")
                .font(.system(size: 50))
                .foregroundColor(.gray)
            Text("No transactions found")
                .foregroundColor(.secondary)
            Spacer()
        }.frame(maxWidth: .infinity)
    }

    func showHistory(_ expenses: [ExpenseEntity]) { }
}

// MARK: - Row View
struct ExpenseRow: View {
    let expense: ExpenseEntity
    
    private var categoryConfig: (icon: String, color: Color) {
        switch expense.category.lowercased() {
            case "food": return ("fork.knife", .orange)
            case "transport": return ("car.fill", .blue)
            case "shopping": return ("bag.fill", .pink)
            case "bills": return ("doc.plaintext.fill", .red)
            case "entertainment": return ("tv.fill", .purple)
            default: return ("cart.fill", .indigo)
        }
    }

    var body: some View {
        HStack(spacing: 12) {
            // Compact Icon
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(categoryConfig.color.opacity(0.12))
                    .frame(width: 40, height: 40)
                
                Image(systemName: categoryConfig.icon)
                    .foregroundColor(categoryConfig.color)
                    .font(.system(size: 16))
            }
            
            VStack(alignment: .leading, spacing: 2) {
                Text(expense.category)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                Text(expense.note)
                    .font(.caption2)
                    .foregroundColor(.secondary)
                    .lineLimit(1)
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 2) {
                Text("-$\(String(format: "%.2f", expense.amount))")
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                Text(expense.date.formatted(date: .abbreviated, time: .omitted))
                    .font(.system(size: 10))
                    .foregroundColor(.gray)
            }
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 10) // Reduced vertical padding for less space
        .background(Color.white)
        .cornerRadius(12)
    }
}

// MARK: - Detail View (Modal)
struct ExpenseDetailView: View {
    let expense: ExpenseEntity
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationView { // Added NavigationView for a cleaner title bar if needed
            ScrollView {
                VStack(spacing: 24) {
                    // Big Amount Header
                    VStack(spacing: 8) {
                        ZStack {
                            Circle()
                                .fill(categoryColor.opacity(0.1))
                                .frame(width: 80, height: 80)
                            Image(systemName: categoryIcon)
                                .font(.system(size: 30, weight: .bold))
                                .foregroundColor(categoryColor)
                        }
                        
                        Text("-$\(String(format: "%.2f", expense.amount))")
                            .font(.system(size: 44, weight: .bold))
                            .minimumScaleFactor(0.5) // Shrinks text if amount is huge
                        
                        Text(expense.category)
                            .font(.headline)
                            .foregroundColor(.secondary)
                    }
                    .padding(.top, 20)

                    // Information Cards
                    VStack(spacing: 1) {
                        detailRow(label: "Date", value: expense.date.formatted(date: .long, time: .shortened))
                        Divider().padding(.leading)
                        
                        // Flexible Note Row
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Note")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            Text(expense.note.isEmpty ? "No description provided." : expense.note)
                                .font(.body)
                                .fixedSize(horizontal: false, vertical: true) // Prevents clipping
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        
                        Divider().padding(.leading)
                        detailRow(label: "Transaction ID", value: String(expense.id.prefix(12)).uppercased())
                    }
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(16)
                    .padding(.horizontal)

                    // Close Button
                    Button(action: { dismiss() }) {
                        Text("Done")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.indigo)
                            .cornerRadius(16)
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 20)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") { dismiss() }
                        .fontWeight(.semibold)
                }
            }
        }
    }

    // Helper to get category-specific styling inside the modal too
    private var categoryColor: Color {
        switch expense.category.lowercased() {
            case "food": return .orange
            case "transport": return .blue
            case "shopping": return .pink
            case "bills": return .red
            case "entertainment": return .purple
            default: return .indigo
        }
    }
    
    private var categoryIcon: String {
        switch expense.category.lowercased() {
            case "food": return "fork.knife"
            case "transport": return "car.fill"
            case "shopping": return "bag.fill"
            case "bills": return "doc.plaintext.fill"
            case "entertainment": return "tv.fill"
            default: return "receipt"
        }
    }

    private func detailRow(label: String, value: String) -> some View {
        HStack {
            Text(label)
                .font(.caption)
                .foregroundColor(.secondary)
            Spacer()
            Text(value)
                .font(.subheadline)
                .fontWeight(.medium)
        }
        .padding()
    }
}

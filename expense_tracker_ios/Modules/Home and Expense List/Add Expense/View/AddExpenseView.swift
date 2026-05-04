//
//  AddExpenseView.swift
//  expense_tracker_ios
//
//  Created by Touch and Solve on 30/4/26.
//

import SwiftUI

struct AddExpenseView: View, AddExpenseViewProtocol {
    var presenter: AddExpensePresenterProtocol?
    @State private var amount = ""
    @State private var selectedCategory: String? = nil
    @State private var note = ""
    @State private var isLoading = false
    
    @State private var errorMessage: String?
    @State private var showAlert = false

    let categories = ["Food", "Transport", "Shopping", "Bills", "Entertainment"]

    var body: some View {
        VStack(spacing: 25) {
            // Header
            headerView
            
            // Amount Input
            VStack(spacing: 8) {
                Text("Amount").font(.caption).foregroundColor(.gray)
                HStack(alignment: .center, spacing: 4) { // Center alignment for vertical balance
                    Text("$")
                        .font(.system(size: 40, weight: .bold))
                    
                    ZStack(alignment: .leading) {
                        // Ghost Layer
                        if !amount.contains(".") {
                            HStack(spacing: 0) {
                                if amount.isEmpty {
                                    Text("00.00").foregroundColor(.gray.opacity(0.3))
                                } else {
                                    Text(amount).foregroundColor(.clear)
                                    Text(".00").foregroundColor(.gray.opacity(0.3))
                                }
                            }
                            .font(.system(size: 50, weight: .bold))
                        }
                        
                        TextField("", text: $amount)
                            .font(.system(size: 50, weight: .bold))
                            .keyboardType(.decimalPad)
                            .tint(.indigo)
                    }
                }
                .padding(.vertical, 15)
                .padding(.horizontal, 20)
                .background(Color.indigo.opacity(0.05))
                .cornerRadius(20)
            }

            // Category Picker
            VStack(alignment: .leading, spacing: 10) {
                Text("Category").font(.subheadline).bold()
                    .padding(.horizontal) // Match padding with other elements
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        ForEach(categories, id: \.self) { cat in
                            CategoryButton(
                                title: cat,
                                isSelected: selectedCategory == cat,
                                action: {
                                    withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                                        selectedCategory = cat
                                    }
                                }
                            )
                        }
                    }
                    .padding(.vertical, 8)
                    .padding(.horizontal, 20) // Important: Padding inside the ScrollView prevents clipping
                }
            }

            // Note Input
            VStack(alignment: .leading, spacing: 10) {
                Text("Note").font(.subheadline).bold()
                TextField("What was this for?", text: $note)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(15)
                    .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color.gray.opacity(0.2), lineWidth: 1))
            }
            .padding(.horizontal)

            Spacer()

            // Save Button
            saveButton
                .padding(.horizontal)
        }
        .background(Color(red: 248/255, green: 250/255, blue: 252/255).ignoresSafeArea())
        .alert("Error", isPresented: $showAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(errorMessage ?? "Unknown Error")
        }
    }

    // MARK: - Subviews

    private var headerView: some View {
        HStack {
            Button(action: { AppStateManager.shared.currentRoute = .home }) {
                Image(systemName: "chevron.left")
                    .font(.system(size: 18, weight: .bold))
                    .padding(12)
                    .background(Color.white)
                    .clipShape(Circle())
                    .shadow(radius: 2)
            }
            .foregroundColor(.black)
            Spacer()
            Text("Add Expense").font(.headline)
            Spacer()
            Spacer().frame(width: 40)
        }
        .padding(.horizontal)
        .padding(.top, 10)
    }

    private var saveButton: some View {
        Button(action: {
            let finalAmount = Double(amount) ?? 0.0
            presenter?.didTapSave(amount: finalAmount, category: selectedCategory ?? "General", note: note)
        }) {
            if isLoading {
                ProgressView().tint(.white)
            } else {
                Text("Save Expense").font(.headline).foregroundColor(.white)
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 60)
        .background((amount.isEmpty || selectedCategory == nil) ? Color.gray : Color.indigo)
        .cornerRadius(18)
        .disabled(isLoading || amount.isEmpty || selectedCategory == nil)
    }

    func showLoading() { isLoading = true }
    func hideLoading() { isLoading = false }
    func didComplete() {
        withAnimation { AppStateManager.shared.currentRoute = .home }
    }
    func showError(_ message: String) {
        self.errorMessage = message
        self.showAlert = true
    }
}

// MARK: - Category Button Helper
struct CategoryButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    private var config: (icon: String, color: Color) {
        switch title.lowercased() {
            case "food": return ("fork.knife", .orange)
            case "transport": return ("car.fill", .blue)
            case "shopping": return ("bag.fill", .pink)
            case "bills": return ("doc.plaintext.fill", .red)
            case "entertainment": return ("tv.fill", .purple)
            default: return ("cart.fill", .indigo)
        }
    }

    var body: some View {
        Button(action: action) {
            HStack(spacing: isSelected ? 8 : 0) {
                if isSelected {
                    Image(systemName: config.icon)
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(config.color)
                        .transition(.scale.combined(with: .opacity))
                }
                
                Text(title)
                    .font(.subheadline)
                    .fontWeight(isSelected ? .bold : .medium)
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 12)
            .background(isSelected ? config.color.opacity(0.15) : Color.white)
            .foregroundColor(isSelected ? config.color : .black)
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(isSelected ? config.color.opacity(0.5) : Color.gray.opacity(0.2), lineWidth: 1)
            )
        }
        .scaleEffect(isSelected ? 1.05 : 1.0)
    }
}

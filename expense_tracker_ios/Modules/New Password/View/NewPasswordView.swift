//
//  NewPasswordView.swift
//  expense_tracker_ios
//
//  Created by Touch and Solve on 30/4/26.
//
import SwiftUI

// 1. Create a ViewModel to hold the UI state
class NewPasswordViewModel: ObservableObject {
    @Published var password = ""
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var showAlert = false
}

struct NewPasswordView: View, NewPasswordViewProtocol {
    var presenter: NewPasswordPresenterProtocol?
    
    // 2. Observe the state
    @ObservedObject var viewModel: NewPasswordViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Color.clear.frame(height: 80)

            Image(systemName: "shield.checkerboard")
                .font(.system(size: 60))
                .foregroundColor(.indigo)

            Text("Set New Password")
                .font(.system(size: 28, weight: .bold))
                .foregroundColor(Color(red: 30/255, green: 41/255, blue: 59/255))
                .padding(.top, 24)

            Text("Create a strong password to protect your account.")
                .font(.system(size: 16))
                .foregroundColor(Color(red: 100/255, green: 116/255, blue: 139/255))
                .padding(.top, 12)

            CustomTextField(text: $viewModel.password, hint: "New Password", icon: "lock.rotation", isSecure: true)
                .padding(.top, 32)
            
            if let error = viewModel.errorMessage {
                Text(error)
                    .font(.system(size: 14))
                    .foregroundColor(.red)
                    .padding(.top, 8)
            }

            Color.clear.frame(height: 32)

            if viewModel.isLoading {
                ProgressView().frame(maxWidth: .infinity)
            } else {
                Button(action: {
                    print("DEBUG UI: Button tapped. Sending to presenter.")
                    viewModel.errorMessage = nil
                    presenter?.didTapUpdate(password: viewModel.password)
                }) {
                    Text("Update Password")
                        .font(.system(size: 16, weight: .bold))
                        .frame(maxWidth: .infinity)
                        .frame(height: 60)
                        .background(Color.indigo)
                        .foregroundColor(.white)
                        .cornerRadius(16)
                }
            }
            Spacer()
        }
        .padding(.horizontal, 24)
        .background(Color(red: 248/255, green: 250/255, blue: 252/255).ignoresSafeArea())
        // 3. Bind alert to the ViewModel
        .alert("Error", isPresented: $viewModel.showAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(viewModel.errorMessage ?? "An unknown error occurred")
        }
    }

    // 4. Implement protocol methods by updating the ViewModel
    func showLoading() { viewModel.isLoading = true }
    func hideLoading() { viewModel.isLoading = false }
    
    func showError(_ message: String) {
        print("DEBUG UI: showError called with: \(message)")
        viewModel.errorMessage = message
        viewModel.showAlert = true
    }
}

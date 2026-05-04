//
//  LoginView.swift
//  expense_tracker_ios
//
//  Created by Touch and Solve on 29/4/26.
//
import SwiftUI

// ViewModel to hold the UI state and handle reactive updates
class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var showAlert = false
}

struct LoginView: View, LoginViewProtocol {
    var presenter: LoginPresenterProtocol?
    @ObservedObject var viewModel: LoginViewModel

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                Spacer().frame(height: 100)
                
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.indigo.opacity(0.1))
                        .frame(width: 72, height: 72)
                    Image(systemName: "chart.line.uptrend.xyaxis")
                        .font(.system(size: 40))
                        .foregroundColor(.indigo)
                }
                .padding(.bottom, 32)

                Text("Welcome back")
                    .font(.system(size: 32, weight: .bold))
                    .foregroundColor(Color(red: 30/255, green: 41/255, blue: 91/255))
                
                Text("Log in to keep your spending in check.")
                    .font(.system(size: 16))
                    .foregroundColor(Color(red: 100/255, green: 116/255, blue: 139/255))
                    .padding(.bottom, 48)

                VStack(spacing: 16) {
                    CustomTextField(text: $viewModel.email, hint: "Email", icon: "envelope", keyboardType: .emailAddress)
                    CustomTextField(text: $viewModel.password, hint: "Password", icon: "lock", isSecure: true)
                }

                HStack {
                    Spacer()
                    Button("Forgot Password?") {
                        presenter?.didTapForgotPassword()
                    }
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.indigo)
                }
                .padding(.top, 8)
                .padding(.bottom, 24)

                if viewModel.isLoading {
                    HStack {
                        Spacer()
                        ProgressView().progressViewStyle(CircularProgressViewStyle(tint: .indigo))
                        Spacer()
                    }
                } else {
                    Button(action: {
                        print("DEBUG UI: Login Button Tapped for \(viewModel.email)")
                        presenter?.didTapLogin(email: viewModel.email, pass: viewModel.password)
                    }) {
                        Text("Continue")
                            .font(.system(size: 18, weight: .bold))
                            .frame(maxWidth: .infinity)
                            .frame(height: 60)
                            .background(Color.indigo)
                            .foregroundColor(.white)
                            .cornerRadius(16)
                    }
                }

                Spacer().frame(height: 40)

                HStack {
                    Spacer()
                    Text("Don't have an account? ")
                        .foregroundColor(Color(red: 100/255, green: 116/255, blue: 139/255))
                    Button("Sign Up") {
                        presenter?.didTapSignUp()
                    }
                    .fontWeight(.bold)
                    .foregroundColor(.indigo)
                    Spacer()
                }
            }
            .padding(.horizontal, 24)
        }
        .background(Color(red: 248/255, green: 250/255, blue: 252/255).ignoresSafeArea())
        // Actual Alert UI
        .alert("Login Failed", isPresented: $viewModel.showAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(viewModel.errorMessage ?? "Unknown Error")
        }
    }

    func showLoading() { viewModel.isLoading = true }
    func hideLoading() { viewModel.isLoading = false }
    func showError(_ msg: String) {
        print("DEBUG UI: showError triggered with: \(msg)")
        viewModel.errorMessage = msg
        viewModel.showAlert = true
    }
}

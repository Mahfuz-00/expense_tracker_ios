//
//  ForgotPasswordView.swift
//  expense_tracker_ios
//
//  Created by Touch and Solve on 30/4/26.
//
import SwiftUI

struct ForgotPasswordView: View, ForgotPasswordViewProtocol {
    var presenter: ForgotPasswordPresenterProtocol?
    @State private var email = ""
    @State private var isLoading = false
    @State private var errorMessage: String?

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Button(action: { presenter?.didTapBack() }) {
                Image(systemName: "chevron.left")
                    .font(.system(size: 18, weight: .bold))
                    .padding(12)
                    .background(Color.white)
                    .clipShape(Circle())
                    .shadow(color: .black.opacity(0.05), radius: 5)
            }
            .foregroundColor(.black)
            .padding(.top, 20)

            Image(systemName: "lock.rectangle.stack.fill")
                .font(.system(size: 60))
                .foregroundColor(.indigo)
                .padding(.top, 40)

            Text("Forgot Password?")
                .font(.system(size: 28, weight: .bold))
                .foregroundColor(Color(red: 30/255, green: 41/255, blue: 59/255))
                .padding(.top, 24)

            Text("Enter your email address and we'll send you a link to reset your password.")
                .font(.system(size: 16))
                .foregroundColor(Color(red: 100/255, green: 116/255, blue: 139/255))
                .padding(.top, 12)

            CustomTextField(text: $email, hint: "Email Address", icon: "envelope", keyboardType: .emailAddress)
                .padding(.top, 32)

            Spacer().frame(height: 32)

            if isLoading {
                ProgressView().frame(maxWidth: .infinity)
            } else {
                Button(
                    action: {
                        print("UI DEBUG: Button actually tapped for \(email)")
                        presenter?.didTapSendCode(email: email) }) {
                    Text("Send Code")
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
    }

    func showLoading() { isLoading = true }
    func hideLoading() { isLoading = false }
    func showError(_ message: String) { errorMessage = message }
}

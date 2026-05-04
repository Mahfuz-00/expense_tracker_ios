//
//  RegisterView.swift
//  expense_tracker_ios
//
//  Created by Touch and Solve on 29/4/26.
//
import SwiftUI

struct RegisterView: View, RegisterViewProtocol {
    var presenter: RegisterPresenterProtocol?
    
    @State private var name = ""
    @State private var email = ""
    @State private var password = ""
    @State private var isLoading = false
    @State private var errorMessage: String?
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 20) {
                
                Button(action: {
                                    AppStateManager.shared.currentRoute = .login
                                }) {
                                    Image(systemName: "chevron.left")
                                        .font(.system(size: 18, weight: .bold))
                                        .padding(12)
                                        .background(Color.white)
                                        .clipShape(Circle())
                                        .shadow(color: Color.black.opacity(0.05), radius: 5)
                                }
                                .foregroundColor(.black)
                                .padding(.top, 20)
                                .padding(.bottom, 32)
                
                
                Text("Create Account")
                    .font(.system(size: 32, weight: .heavy))
                    .foregroundColor(Color(red: 30/255, green: 41/255, blue: 59/255))
                
                Text("Fill in your details to start tracking expenses.")
                    .foregroundColor(.secondary)
                
                VStack(spacing: 16) {
                    CustomTextField(text: $name, hint: "Full Name", icon: "person")
                        CustomTextField(text: $email, hint: "Email", icon: "envelope", keyboardType: .emailAddress)
                        CustomTextField(text: $password, hint: "Password", icon: "lock", isSecure: true)
                }
                .padding(.top, 20)
                
                if isLoading {
                    ProgressView().frame(maxWidth: .infinity)
                } else {
                    Button(action: {
                        presenter?.didTapSignUp(name: name, email: email, pass: password)
                    }) {
                        Text("Sign Up")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .frame(height: 60)
                            .background(Color.indigo)
                            .foregroundColor(.white)
                            .cornerRadius(16)
                    }
                }
                
                Spacer()
            }
            .padding(24)
            .background(Color(red: 248/255, green: 250/255, blue: 252/255).ignoresSafeArea())
            .alert(item: $errorMessage) { msg in
                Alert(title: Text("Error"), message: Text(msg), dismissButton: .default(Text("OK")))
            }
        }
    }
    
    func showLoading() { isLoading = true }
    func hideLoading() { isLoading = false }
    func showError(_ message: String) { errorMessage = message }
}

// Needed for the alert item binding
extension String: Identifiable {
    public var id: String { self }
}

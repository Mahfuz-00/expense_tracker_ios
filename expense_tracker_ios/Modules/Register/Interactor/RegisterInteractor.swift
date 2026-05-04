//
//  RegisterInteractor.swift
//  expense_tracker_ios
//
//  Created by Touch and Solve on 29/4/26.
//
import Foundation
import Supabase

class RegisterInteractor: RegisterInteractorInputProtocol {
    weak var presenter: RegisterInteractorOutputProtocol?
    
    func registerUser(name: String, email: String, pass: String) {
        Task {
            do {
                // Supabase Native Signup
                try await SupabaseManager.shared.client.auth.signUp(
                    email: email,
                    password: pass,
                    data: ["full_name": .string(name)]
                )
                
                await MainActor.run {
                    presenter?.didRegisterSuccessfully(email: email)
                }
            } catch {
                await MainActor.run {
                    presenter?.didFailRegistration(error: error.localizedDescription)
                }
            }
        }
    }
}

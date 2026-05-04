//
//  ForgotPasswordInteractor.swift
//  expense_tracker_ios
//
//  Created by Touch and Solve on 30/4/26.
//
import Foundation
import Supabase

class ForgotPasswordInteractor: ForgotPasswordInteractorInputProtocol {
    weak var presenter: ForgotPasswordInteractorOutputProtocol?
    
    func sendResetCode(to email: String) {
        print("DEBUG: Attempting to send reset code to: \(email)")
        
        Task {
            do {
                // Try without redirectTo first to match your Flutter logic
                // If this fails, Supabase will tell us why in the catch block
                try await SupabaseManager.shared.client.auth.resetPasswordForEmail(email)
                
                print("DEBUG: Supabase accepted the request. Check Resend dashboard now.")
                
                await MainActor.run {
                    presenter?.didSendCodeSuccessfully(email: email)
                }
            } catch {
                // THIS IS THE MOST IMPORTANT PART
                print("--- SUPABASE ERROR DETAILS ---")
                print("Type: \(type(of: error))")
                print("Description: \(error.localizedDescription)")
                print("Full Error: \(error)")
                print("------------------------------")
                
                await MainActor.run {
                    presenter?.didFailToSendCode(error: error.localizedDescription)
                }
            }
        }
    }
}

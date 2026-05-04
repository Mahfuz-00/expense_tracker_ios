//
//  OTPInteractor.swift
//  expense_tracker_ios
//
//  Created by Touch and Solve on 29/4/26.
//
import Foundation
import Supabase

class OTPInteractor {
    func verify(email: String, code: String, isSignUp: Bool) {
        Task {
            do {
                try await SupabaseManager.shared.client.auth.verifyOTP(
                    email: email,
                    token: code,
                    type: isSignUp ? .signup : .recovery
                )
                
                await MainActor.run {
                    if isSignUp {
                        // Register Flow -> Go to Success
                        AppStateManager.shared.currentRoute = .success(
                            title: "Verified!",
                            message: "Welcome aboard."
                        )
                    } else {
                        // Forgot Password Flow -> Go to New Password
                        // Make sure your AppRoute enum supports .newPassword
                        AppStateManager.shared.currentRoute = .newPassword(email: email)
                    }
                }
            } catch {
                print("OTP Error: \(error.localizedDescription)")
                // You might want to pass this error back to the presenter/view
            }
        }
    }
}

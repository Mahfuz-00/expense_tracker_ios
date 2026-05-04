//
//  NewPasswordInteractor.swift
//  expense_tracker_ios
//
//  Created by Touch and Solve on 30/4/26.
//
import Foundation
import Supabase

class NewPasswordInteractor: NewPasswordInteractorInputProtocol {
    weak var presenter: NewPasswordInteractorOutputProtocol?

    func updatePassword(email: String, newPassword: String) {
        print("DEBUG INTERACTOR: Starting updatePassword task...")
        Task {
            do {
                let auth = SupabaseManager.shared.client.auth
                let session = auth.currentSession
                
                print("DEBUG INTERACTOR: Current Session is \(session == nil ? "MISSING" : "ACTIVE")")
                
                guard session != nil else {
                    print("DEBUG INTERACTOR: Error - No active session found to authorize update")
                    await MainActor.run {
                        presenter?.didFailToUpdate(error: "No active session. Please use the link sent to your email.")
                    }
                    return
                }

                let attributes = UserAttributes(password: newPassword)
                print("DEBUG INTERACTOR: Sending update request to Supabase...")
                try await auth.update(user: attributes)
                
                print("DEBUG INTERACTOR: Update done. Signing out...")
                try await auth.signOut()
                
                await MainActor.run {
                    print("DEBUG INTERACTOR: Success! Notifying presenter.")
                    presenter?.didUpdateSuccessfully()
                }
            } catch {
                print("DEBUG INTERACTOR: Caught exception: \(error.localizedDescription)")
                await MainActor.run {
                    presenter?.didFailToUpdate(error: error.localizedDescription)
                }
            }
        }
    }
}

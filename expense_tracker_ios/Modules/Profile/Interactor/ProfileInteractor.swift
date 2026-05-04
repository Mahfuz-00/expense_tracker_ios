//
//  ProfileInteractor.swift
//  expense_tracker_ios
//
//  Created by Touch and Solve on 3/5/26.
//
import Foundation

class ProfileInteractor: ProfileInteractorInputProtocol {
    weak var presenter: ProfileInteractorOutputProtocol?
    
    func fetchUserProfile() {
        print("DEBUG INTERACTOR: Fetching user profile...")
        
        // Simulate a slight delay to test the loading state
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.5) { [weak self] in
            guard let self = self else { return }
            
            if let user = SupabaseManager.shared.client.auth.currentUser {
                print("DEBUG INTERACTOR: User found: \(user.id)")
                let fullName = user.userMetadata["full_name"]?.value as? String ?? "User"
                let email = user.email ?? "No email linked"
                
                DispatchQueue.main.async {
                    self.presenter?.didFetchUser(name: fullName, email: email)
                }
            } else {
                print("DEBUG INTERACTOR: No active session found")
                DispatchQueue.main.async {
                    self.presenter?.didFailWithError("Failed to retrieve profile: No active user session.")
                }
            }
        }
    }

    func logout() {
        print("DEBUG INTERACTOR: Logout initiated...")
        Task {
            do {
                try await SupabaseManager.shared.client.auth.signOut()
                print("DEBUG INTERACTOR: Logout success")
                await MainActor.run {
                    self.presenter?.didLogoutSuccess()
                }
            } catch {
                print("DEBUG INTERACTOR: Logout failed - \(error.localizedDescription)")
                await MainActor.run {
                    self.presenter?.didFailWithError("Logout failed: \(error.localizedDescription)")
                }
            }
        }
    }
}

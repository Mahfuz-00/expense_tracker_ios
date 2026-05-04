//
//  LoginInteractor.swift
//  expense_tracker_ios
//
//  Created by Touch and Solve on 29/4/26.
//
import Foundation
import Supabase

class LoginInteractor: LoginInteractorInputProtocol {
    var presenter: LoginInteractorOutputProtocol?
    
    func login(email: String, pass: String) {
        print("DEBUG INTERACTOR: Starting login task...")
        Task {
            do {
                // 1. Perform Sign In
                try await SupabaseManager.shared.client.auth.signIn(email: email, password: pass)
                
                // 2. Check if session was actually created
                let session = SupabaseManager.shared.client.auth.currentSession
                if let user = session?.user {
                    print("DEBUG INTERACTOR: Login Success! User ID: \(user.id)")
                    print("DEBUG INTERACTOR: Session is ACTIVE: \(session != nil)")
                } else {
                    print("DEBUG INTERACTOR: Login seemed to work, but session is missing!")
                }
                
                await MainActor.run { presenter?.didLoginSuccessfully() }
            } catch {
                print("DEBUG INTERACTOR: Login failed with Supabase Error: \(error)")
                await MainActor.run { presenter?.didFailLogin(error: error.localizedDescription) }
            }
        }
    }
}

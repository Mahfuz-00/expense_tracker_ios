//
//  SplashInteractor.swift
//  expense_tracker_ios
//
//  Created by Touch and Solve on 28/4/26.
//
import Foundation
import Supabase

class SplashInteractor: SplashInteractorInputProtocol {
    weak var presenter: SplashInteractorOutputProtocol?
    
    func checkAuthenticationStatus() {
        let session = SupabaseManager.shared.client.auth.currentSession
        presenter?.didFinishedAuthCheck(isLoggedIn: session != nil)
    }
}

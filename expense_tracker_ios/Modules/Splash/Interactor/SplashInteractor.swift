//
//  SplashInteractor.swift
//  expense_tracker_ios
//
//  Created by Touch and Solve on 28/4/26.
//
import Foundation
import Supabase

protocol SplashInteractorInputProtocol {
    func checkAuthenticationStatus()
}

protocol SplashInteractorOutputProtocol: AnyObject {
    func didFinishedAuthCheck(isLoggedIn: Bool)
}

class SplashInteractor: SplashInteractorInputProtocol {
    weak var presenter: SplashInteractorOutputProtocol?
    
    func checkAuthenticationStatus() {
        // Accessing the singleton we made in Core/Networking
        let session = SupabaseManager.shared.client.auth.currentSession
        let isLoggedIn = session != null
        
        // Notify the presenter
        presenter?.didFinishedAuthCheck(isLoggedIn: isLoggedIn)
    }
}

//
//  SplashPresenter.swift
//  expense_tracker_ios
//
//  Created by Touch and Solve on 28/4/26.
//
import Foundation

class SplashPresenter: SplashPresenterProtocol, SplashInteractorOutputProtocol {
    var view: SplashViewProtocol?
    var interactor: SplashInteractorInputProtocol?
    var router: SplashRouterProtocol?
    
    func viewDidAppear() {
        // 1:1 Flutter timing
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.interactor?.checkAuthenticationStatus()
        }
    }
    
    func didFinishedAuthCheck(isLoggedIn: Bool) {
        DispatchQueue.main.async {
            if isLoggedIn {
                // User has a session -> Home
                AppStateManager.shared.currentRoute = .home
            } else {
                // No session -> Login Screen
                AppStateManager.shared.currentRoute = .login
            }
        }
    }
}

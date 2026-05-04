//
//  SplashProtocols.swift
//  expense_tracker_ios
//
//  Created by Touch and Solve on 29/4/26.
//
import SwiftUI

protocol SplashViewProtocol { }

protocol SplashPresenterProtocol {
    func viewDidAppear()
}

protocol SplashInteractorInputProtocol {
    func checkAuthenticationStatus()
}

protocol SplashInteractorOutputProtocol: AnyObject {
    func didFinishedAuthCheck(isLoggedIn: Bool)
}

// Remove assembleModule from here; we define it in the Router class instead
protocol SplashRouterProtocol {
    func navigateToLogin()
    func navigateToHome()
}

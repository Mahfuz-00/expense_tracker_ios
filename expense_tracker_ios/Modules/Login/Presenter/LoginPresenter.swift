//
//  LoginPresenter.swift
//  expense_tracker_ios
//
//  Created by Touch and Solve on 29/4/26.
//
import Foundation

class LoginPresenter: LoginPresenterProtocol, LoginInteractorOutputProtocol {
    var view: LoginViewProtocol?
    var interactor: LoginInteractorInputProtocol?
    
    func didTapLogin(email: String, pass: String) {
        print("DEBUG PRESENTER: didTapLogin received email: \(email)")
        view?.showLoading()
        interactor?.login(email: email, pass: pass)
    }
    
    func didTapSignUp() {
        AppStateManager.shared.currentRoute = .register
    }
    
    @MainActor
    func didLoginSuccessfully() {
        print("DEBUG PRESENTER: didLoginSuccessfully - Navigating to Home")
        view?.hideLoading()
        AppStateManager.shared.currentRoute = .home
    }
    
    @MainActor
    func didFailLogin(error: String) {
        print("DEBUG PRESENTER: didFailLogin - Error: \(error)")
        view?.hideLoading()
        view?.showError(error)
    }
    
    func didTapForgotPassword(){
        AppStateManager.shared.currentRoute = .forgotPassword
    }
}

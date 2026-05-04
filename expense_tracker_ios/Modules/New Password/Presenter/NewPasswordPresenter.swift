//
//  NewPasswordPresenter.swift
//  expense_tracker_ios
//
//  Created by Touch and Solve on 30/4/26.
//
import Foundation

class NewPasswordPresenter: NewPasswordPresenterProtocol, NewPasswordInteractorOutputProtocol {
    var view: NewPasswordViewProtocol?
    var interactor: NewPasswordInteractorInputProtocol?
    var router: NewPasswordRouterProtocol?
    
    let email: String

    init(email: String) {
        self.email = email
        print("DEBUG PRESENTER: Initialized for email: \(email)")
    }

    func didTapUpdate(password: String) {
        print("DEBUG PRESENTER: didTapUpdate called with password length: \(password.count)")
        
        if password.isEmpty {
            view?.showError("Please enter a new password")
            return
        }
        
        if password.count < 6 {
            view?.showError("Password must be at least 6 characters")
            return
        }
        
        view?.showLoading()
        print("DEBUG PRESENTER: Telling Interactor to update password...")
        interactor?.updatePassword(email: email, newPassword: password)
    }

    func didUpdateSuccessfully() {
        print("DEBUG PRESENTER: Update successful. Navigating to success screen.")
        view?.hideLoading()
        router?.navigateToSuccess()
    }

    func didFailToUpdate(error: String) {
        print("DEBUG PRESENTER: Update failed with error: \(error)")
        view?.hideLoading()
        view?.showError(error)
    }
}

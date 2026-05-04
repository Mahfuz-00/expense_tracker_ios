//
//  ForgotPasswordPresenter.swift
//  expense_tracker_ios
//
//  Created by Touch and Solve on 30/4/26.
//
import Foundation

class ForgotPasswordPresenter: ForgotPasswordPresenterProtocol, ForgotPasswordInteractorOutputProtocol {
    var view: ForgotPasswordViewProtocol?
    var interactor: ForgotPasswordInteractorInputProtocol?
    var router: ForgotPasswordRouterProtocol?
    
    init() {
            print("DEBUG: ForgotPasswordPresenter Initialized")
        }

    func didTapSendCode(email: String) {
        guard email.contains("@") else {
            view?.showError("Please enter a valid email address")
            return
        }
        
        view?.showLoading()
        interactor?.sendResetCode(to: email)
    }

    func didTapBack() {
        router?.navigateBack()
    }

    func didSendCodeSuccessfully(email: String) {
        view?.hideLoading()
        // Router will handle the transition via AppStateManager
        router?.navigateToOTP(with: email)
    }

    func didFailToSendCode(error: String) {
        view?.hideLoading()
        view?.showError(error)
    }
}

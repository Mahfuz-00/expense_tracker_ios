//
//  RegisterPresenter.swift
//  expense_tracker_ios
//
//  Created by Touch and Solve on 29/4/26.
//
import Foundation

class RegisterPresenter: RegisterPresenterProtocol, RegisterInteractorOutputProtocol {
    var view: RegisterViewProtocol?
    var interactor: RegisterInteractorInputProtocol?
    var router: RegisterRouterProtocol?
    
    func didTapSignUp(name: String, email: String, pass: String) {
        if name.isEmpty || email.isEmpty || pass.isEmpty {
            view?.showError("Please fill in all fields")
            return
        }
        view?.showLoading()
        interactor?.registerUser(name: name, email: email, pass: pass)
    }
    
    func didRegisterSuccessfully(email: String) {
        view?.hideLoading()
        router?.navigateToOTP(email: email)
    }
    
    func didFailRegistration(error: String) {
        view?.hideLoading()
        view?.showError(error)
    }
}

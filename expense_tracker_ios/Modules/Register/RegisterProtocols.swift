//
//  RegisterProtocols.swift
//  expense_tracker_ios
//
//  Created by Touch and Solve on 29/4/26.
//
import SwiftUI

protocol RegisterViewProtocol{
    func showLoading()
    func hideLoading()
    func showError(_ message: String)
}

protocol RegisterPresenterProtocol: AnyObject {
    func didTapSignUp(name: String, email: String, pass: String)
}

protocol RegisterInteractorInputProtocol: AnyObject {
    func registerUser(name: String, email: String, pass: String)
}

protocol RegisterInteractorOutputProtocol: AnyObject {
    func didRegisterSuccessfully(email: String)
    func didFailRegistration(error: String)
}

protocol RegisterRouterProtocol: AnyObject {
    func navigateToOTP(email: String)
}

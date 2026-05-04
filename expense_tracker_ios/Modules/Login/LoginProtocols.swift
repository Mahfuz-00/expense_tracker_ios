//
//  LoginProtocols.swift
//  expense_tracker_ios
//
//  Created by Touch and Solve on 29/4/26.
//
import SwiftUI
import SwiftUI

protocol LoginViewProtocol{
    func showLoading()
    func hideLoading()
    func showError(_ msg: String)
}

protocol LoginPresenterProtocol: AnyObject {
    var view: LoginViewProtocol? { get set }
    func didTapLogin(email: String, pass: String)
    func didTapSignUp()
    func didTapForgotPassword()
}

protocol LoginInteractorInputProtocol: AnyObject {
    func login(email: String, pass: String)
}

protocol LoginInteractorOutputProtocol: AnyObject {
    func didLoginSuccessfully()
    func didFailLogin(error: String)
}

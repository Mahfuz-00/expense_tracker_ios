//
//  ForgotPasswordProtocols.swift
//  expense_tracker_ios
//
//  Created by Touch and Solve on 30/4/26.
//
import SwiftUI

// 1. Remove AnyObject so the Struct View can conform
protocol ForgotPasswordViewProtocol {
    func showLoading()
    func hideLoading()
    func showError(_ message: String)
}

protocol ForgotPasswordPresenterProtocol: AnyObject {
    func didTapSendCode(email: String)
    func didTapBack()
}

protocol ForgotPasswordInteractorInputProtocol: AnyObject {
    func sendResetCode(to email: String)
}

protocol ForgotPasswordInteractorOutputProtocol: AnyObject {
    func didSendCodeSuccessfully(email: String)
    func didFailToSendCode(error: String)
}

protocol ForgotPasswordRouterProtocol: AnyObject {
    // 2. Change 'some View' to 'AnyView' to satisfy the compiler
    static func assembleModule() -> AnyView
    func navigateToOTP(with email: String)
    func navigateBack()
}

//
//  NewPasswordProtocols.swift
//  expense_tracker_ios
//
//  Created by Touch and Solve on 30/4/26.
//
import SwiftUI

protocol NewPasswordViewProtocol {
    func showLoading()
    func hideLoading()
    func showError(_ message: String)
}

protocol NewPasswordPresenterProtocol: AnyObject {
    func didTapUpdate(password: String)
}

protocol NewPasswordInteractorInputProtocol: AnyObject {
    func updatePassword(email: String, newPassword: String)
}

protocol NewPasswordInteractorOutputProtocol: AnyObject {
    func didUpdateSuccessfully()
    func didFailToUpdate(error: String)
}

protocol NewPasswordRouterProtocol: AnyObject {
    static func assembleModule(email: String) -> AnyView
    func navigateToSuccess()
}

//
//  AddExpenseProtocols.swift
//  expense_tracker_ios
//
//  Created by Touch and Solve on 30/4/26.
//
import SwiftUI

protocol AddExpenseViewProtocol {
    func showLoading()
    func hideLoading()
    func didComplete()
    func showError(_ message: String)
}

protocol AddExpensePresenterProtocol: AnyObject {
    func didTapSave(amount: Double, category: String, note: String)
}

protocol AddExpenseInteractorInputProtocol: AnyObject {
    func saveExpense(amount: Double, category: String, note: String)
}

protocol AddExpenseInteractorOutputProtocol: AnyObject {
    func didSaveSuccessfully()
    func didFailToSave(error: String)
}

protocol AddExpenseRouterProtocol: AnyObject {
    static func assembleModule() -> AnyView
}

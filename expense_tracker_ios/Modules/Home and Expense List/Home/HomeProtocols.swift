//
//  HomeProtocols.swift
//  expense_tracker_ios
//
//  Created by Touch and Solve on 30/4/26.
//
import SwiftUI

protocol HomeViewProtocol {
    func showExpenses(_ expenses: [ExpenseEntity])
    func showError(_ message: String)
}

protocol HomePresenterProtocol: AnyObject {
    func viewDidLoad()
    func didTapAddExpense()
    func didTapHistory()
    func didTapProfile()
}

protocol HomeInteractorInputProtocol: AnyObject {
    func startWatchingExpenses()
}

protocol HomeInteractorOutputProtocol: AnyObject {
    func didFetchExpenses(_ expenses: [ExpenseEntity])
    func didFailToFetch(error: String)
}

protocol HomeRouterProtocol: AnyObject {
    static func assembleModule() -> AnyView
    func navigateToAddExpense()
    func navigateToHistory()
    func navigateToProfile()
}

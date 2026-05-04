//
//  HistoryProtocols.swift
//  expense_tracker_ios
//
//  Created by Touch and Solve on 30/4/26.
//
import SwiftUI

protocol HistoryViewProtocol {
    func showHistory(_ expenses: [ExpenseEntity])
}

protocol HistoryPresenterProtocol: AnyObject {
    func viewDidLoad()
}

protocol HistoryInteractorInputProtocol: AnyObject {
    func fetchAllExpenses()
}

protocol HistoryInteractorOutputProtocol: AnyObject {
    func didFetchHistory(_ expenses: [ExpenseEntity])
}

protocol HistoryRouterProtocol: AnyObject {
    static func assembleModule() -> AnyView
}

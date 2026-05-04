//
//  HistoryPresenter.swift
//  expense_tracker_ios
//
//  Created by Touch and Solve on 30/4/26.
//
import SwiftUI

class HistoryPresenter: ObservableObject, HistoryPresenterProtocol, HistoryInteractorOutputProtocol {
    var view: HistoryViewProtocol?
    var interactor: HistoryInteractorInputProtocol?
    var router: HistoryRouterProtocol?

    @Published var expenses: [ExpenseEntity] = []

    func viewDidLoad() {
        print("DEBUG HISTORY PRESENTER: View Loaded, calling Interactor")
        interactor?.fetchAllExpenses()
    }

    @MainActor
    func didFetchHistory(_ expenses: [ExpenseEntity]) {
        print("DEBUG HISTORY PRESENTER: Publishing \(expenses.count) items to UI")
        withAnimation(.spring()) {
            self.expenses = expenses
        }
        // Sync with legacy view protocol if needed, though @Published is better
        view?.showHistory(expenses)
    }
}

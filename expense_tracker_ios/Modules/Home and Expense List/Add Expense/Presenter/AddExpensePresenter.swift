//
//  AddExpensePresenter.swift
//  expense_tracker_ios
//
//  Created by Touch and Solve on 30/4/26.
//
import Foundation

class AddExpensePresenter: AddExpensePresenterProtocol, AddExpenseInteractorOutputProtocol {
    var view: AddExpenseViewProtocol?
    var interactor: AddExpenseInteractorInputProtocol?
    var router: AddExpenseRouterProtocol?

    func didTapSave(amount: Double, category: String, note: String) {
        print("DEBUG PRESENTER: didTapSave received. Validating fields...")
        
        // 1. Mandatory Field Validation
        if amount <= 0 {
            print("DEBUG PRESENTER: Validation Failed - Amount is 0 or negative")
            view?.showError("Please enter an amount greater than 0")
            return
        }
        
        if category.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            print("DEBUG PRESENTER: Validation Failed - Category empty")
            view?.showError("Please select or enter a category")
            return
        }

        view?.showLoading()
        interactor?.saveExpense(amount: amount, category: category, note: note)
    }

    func didSaveSuccessfully() {
        view?.hideLoading()
        view?.didComplete()
    }

    func didFailToSave(error: String) {
        view?.hideLoading()
        view?.showError(error)
    }
}

//
//  AddExpenseRouter.swift
//  expense_tracker_ios
//
//  Created by Touch and Solve on 30/4/26.
//
import SwiftUI

class AddExpenseRouter: AddExpenseRouterProtocol {
    static func assembleModule() -> AnyView {
        let presenter = AddExpensePresenter()
        let interactor = AddExpenseInteractor()
        let router = AddExpenseRouter()
        
        let view = AddExpenseView(presenter: presenter)
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        
        return AnyView(view)
    }
}

//
//  HomeRouter.swift
//  expense_tracker_ios
//
//  Created by Touch and Solve on 30/4/26.
//
import SwiftUI

class HomeRouter: HomeRouterProtocol {
    private static var sharedPresenter: HomePresenter?
    
    static func assembleModule() -> AnyView {
        if sharedPresenter == nil {
                    sharedPresenter = HomePresenter()
                }
                
        let presenter = sharedPresenter!
        let interactor = HomeInteractor()
        let router = HomeRouter()
        let view = HomeView(presenter: presenter)
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        
        return AnyView(view)
    }

    func navigateToAddExpense() {
        AppStateManager.shared.currentRoute = .addExpense
    }

    func navigateToHistory() {
        AppStateManager.shared.currentRoute = .history
    }

    func navigateToProfile() {
         AppStateManager.shared.currentRoute = .profile
    }
}

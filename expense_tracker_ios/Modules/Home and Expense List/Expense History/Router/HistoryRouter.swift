//
//  HistoryRouter.swift
//  expense_tracker_ios
//
//  Created by Touch and Solve on 30/4/26.
//
import SwiftUI

class HistoryRouter: HistoryRouterProtocol {
    static func assembleModule() -> AnyView {
        let presenter = HistoryPresenter()
        let interactor = HistoryInteractor()
        let router = HistoryRouter()
        
        let view = HistoryView(presenter: presenter)
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        
        return AnyView(view)
    }
}

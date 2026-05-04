//
//  ProfileRouter.swift
//  expense_tracker_ios
//
//  Created by Touch and Solve on 3/5/26.
//
import SwiftUI
import UIKit

class ProfileRouter: ProfileRouterProtocol {
    static func assembleModule() -> AnyView {
        let view = ProfileView()
        let presenter = ProfilePresenter()
        let interactor = ProfileInteractor()
        let router = ProfileRouter()

        var viewWithPresenter = view
        viewWithPresenter.presenter = presenter
        
        presenter.view = viewWithPresenter
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter

        return AnyView(viewWithPresenter)
    }

    func navigateToLogin() {
        AppStateManager.shared.currentRoute = .login
    }
}

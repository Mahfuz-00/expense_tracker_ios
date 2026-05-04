//
//  NewPasswordRouter.swift
//  expense_tracker_ios
//
//  Created by Touch and Solve on 30/4/26.
//
import SwiftUI

class NewPasswordRouter: NewPasswordRouterProtocol {
    static func assembleModule(email: String) -> AnyView {
        print("DEBUG ROUTER: Assembling NewPassword Module for \(email)")
        let viewModel = NewPasswordViewModel()
        let presenter = NewPasswordPresenter(email: email)
        let interactor = NewPasswordInteractor()
        let router = NewPasswordRouter()

        // Pass the presenter directly to the view
        let view = NewPasswordView(presenter: presenter, viewModel: viewModel)

        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter

        return AnyView(view)
    }

    func navigateToSuccess() {
        print("DEBUG ROUTER: Changing route to .success")
        AppStateManager.shared.currentRoute = .success(
            title: "Security Updated",
            message: "Your new password has been set. You can now log in securely."
        )
    }
}

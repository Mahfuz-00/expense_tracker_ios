//
//  ForgotPasswordRouter.swift
//  expense_tracker_ios
//
//  Created by Touch and Solve on 30/4/26.
//
import SwiftUI

class ForgotPasswordRouter: ForgotPasswordRouterProtocol {
    static func assembleModule() -> AnyView {
        let presenter = ForgotPasswordPresenter()
        let interactor = ForgotPasswordInteractor()
        let router = ForgotPasswordRouter()
        
        // Inject presenter into View
        let view = ForgotPasswordView(presenter: presenter)

        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter

        // Wrap the view in AnyView
        return AnyView(view)
    }

    func navigateToOTP(with email: String) {
        // Match your AppRoute enum: .otp(email: String, isSignUp: Bool)
        AppStateManager.shared.currentRoute = .otp(email: email, isSignUp: false)
    }

    func navigateBack() {
        AppStateManager.shared.currentRoute = .login
    }
}

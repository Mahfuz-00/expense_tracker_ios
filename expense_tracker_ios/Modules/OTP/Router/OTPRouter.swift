//
//  OTPRouter.swift
//  expense_tracker_ios
//
//  Created by Touch and Solve on 29/4/26.
//
import SwiftUI

class OTPRouter {
    static func assembleModule(email: String, isSignUp: Bool) -> some View {
        let presenter = OTPPresenter(email: email, isSignUp: isSignUp)
        let interactor = OTPInteractor()
        let view = OTPView(presenter: presenter)
        presenter.view = view
        presenter.interactor = interactor
        return view
    }
}

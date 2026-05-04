//
//  LoginRouter.swift
//  expense_tracker_ios
//
//  Created by Touch and Solve on 29/4/26.
//
import SwiftUI

class LoginRouter {
    static func assembleModule() -> AnyView { 
        let viewModel = LoginViewModel()
        let presenter = LoginPresenter()
        let interactor = LoginInteractor()
        
        // Pass viewModel to view
        let view = LoginView(presenter: presenter, viewModel: viewModel)
        
        presenter.view = view
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return AnyView(view)
    }
}

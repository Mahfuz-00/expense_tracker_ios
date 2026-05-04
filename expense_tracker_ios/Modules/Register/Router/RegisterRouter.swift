//
//  RegisterRouter.swift
//  expense_tracker_ios
//
//  Created by Touch and Solve on 29/4/26.
//
import SwiftUI

class RegisterRouter: RegisterRouterProtocol {
    
    // This is the "Glue" that connects the layers
    static func assembleModule() -> some View {
        let view = RegisterView()
        let presenter = RegisterPresenter()
        let interactor = RegisterInteractor()
        let router = RegisterRouter()
        
        // Connect View to Presenter
        var viewWithPresenter = view
        viewWithPresenter.presenter = presenter
        
        // Connect Presenter to others
        presenter.view = viewWithPresenter
        presenter.interactor = interactor
        presenter.router = router
        
        // Connect Interactor to Presenter
        interactor.presenter = presenter
        
        return viewWithPresenter
    }
    
    func navigateToOTP(email: String) {
        // In SwiftUI VIPER, we will handle this via a Root State or NavigationPath.
        // For now, we print to confirm the logic reaches the Router.
        print("Router: Navigating to OTP for \(email)")
        
        // Implementation note: Later we will use a @Published property
        // in an AppState to swap the root view to OTP.
    }
}

//
//  SplashRouter.swift
//  expense_tracker_ios
//
//  Created by Touch and Solve on 28/4/26.
//
import SwiftUI

class SplashRouter: SplashRouterProtocol {
    func navigateToLogin() {}
    func navigateToHome() {}
    
    // This is where the magic happens. We return 'some View' here, NOT in the protocol.
    static func assembleModule() -> some View {
        let presenter = SplashPresenter()
        let interactor = SplashInteractor()
        let router = SplashRouter()
        
        let view = SplashView(presenter: presenter)
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        
        return view
    }
}

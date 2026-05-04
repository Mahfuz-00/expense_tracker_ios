//
//  expense_tracker_iosApp.swift
//  expense_tracker_ios
//
//  Created by Touch and Solve on 28/4/26.
//

import SwiftUI

@main
struct expense_tracker_iosApp: App {
    @StateObject var stateManager = AppStateManager.shared
    
    var body: some Scene {
        WindowGroup {
            switch stateManager.currentRoute {
            case .splash: SplashRouter.assembleModule()
            case .login: LoginRouter.assembleModule()
            case .register: RegisterRouter.assembleModule()
            case .forgotPassword: ForgotPasswordRouter.assembleModule()
            case .otp(let email, let isSignUp): OTPRouter.assembleModule(email: email, isSignUp: isSignUp)
            case .newPassword(let email): NewPasswordRouter.assembleModule(email: email)
            case .success(let title, let message): SuccessModuleBuilder.build(title: title, message: message)
            case .home: HomeRouter.assembleModule()
            case .addExpense: AddExpenseRouter.assembleModule()
            case .history: HistoryRouter.assembleModule()
            case .profile: ProfileRouter.assembleModule()
            }
        }
    }
}

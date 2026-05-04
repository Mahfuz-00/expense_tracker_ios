//
//  AppStateManager.swift
//  expense_tracker_ios
//
//  Created by Touch and Solve on 29/4/26.
//
import SwiftUI

enum AppRoute {
    case splash
    case login
    case register
    case forgotPassword
    case otp(email: String, isSignUp: Bool)
    case newPassword(email: String)
    case success(title: String, message: String)
    case home
    case addExpense
    case history
    case profile
}

class AppStateManager: ObservableObject {
    static let shared = AppStateManager()
    @Published var currentRoute: AppRoute = .splash
    
    private init() {}
}

extension Notification.Name {
    static let expenseDidSave = Notification.Name("expenseDidSave")
}

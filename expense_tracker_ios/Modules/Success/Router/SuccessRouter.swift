//
//  SuccessRouter.swift
//  expense_tracker_ios
//
//  Created by Touch and Solve on 29/4/26.
//
import SwiftUI

class SuccessRouter {
    static func assembleModule(title: String, message: String) -> some View {
        // Just return the view directly.
        // Logic for the button is handled via AppStateManager inside the View.
        return SuccessView(title: title, message: message)
    }
}

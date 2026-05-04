//
//  OTPPresenter.swift
//  expense_tracker_ios
//
//  Created by Touch and Solve on 29/4/26.
//
import Foundation

class OTPPresenter {
    var view: OTPView?
    var interactor: OTPInteractor?
    let email: String
    let isSignUp: Bool
    
    init(email: String, isSignUp: Bool) {
        self.email = email
        self.isSignUp = isSignUp
    }
    
    func didTapVerify(code: String) {
        interactor?.verify(email: email, code: code, isSignUp: isSignUp)
    }
}

//
//  ProfileProtocols.swift
//  expense_tracker_ios
//
//  Created by Touch and Solve on 3/5/26.
//
import Foundation
import SwiftUI

protocol ProfileViewProtocol {
    var presenter: ProfilePresenterProtocol? { get set }
    func showProfile(name: String, email: String)
    func showError(_ message: String)
}

protocol ProfilePresenterProtocol: AnyObject {
    var view: ProfileViewProtocol? { get set }
    var interactor: ProfileInteractorInputProtocol? { get set }
    var router: ProfileRouterProtocol? { get set }
    
    func viewDidLoad()
    func didTapLogout()
}

protocol ProfileInteractorInputProtocol: AnyObject {
    var presenter: ProfileInteractorOutputProtocol? { get set }
    func fetchUserProfile()
    func logout()
}

protocol ProfileInteractorOutputProtocol: AnyObject {
    func didFetchUser(name: String, email: String)
    func didLogoutSuccess()
    func didFailWithError(_ message: String)
}

protocol ProfileRouterProtocol {
    static func assembleModule() -> AnyView
    func navigateToLogin()
}

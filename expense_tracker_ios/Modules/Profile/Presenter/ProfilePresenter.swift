//
//  ProfilePresenter.swift
//  expense_tracker_ios
//
//  Created by Touch and Solve on 3/5/26.
//

import Foundation
import SwiftUI

class ProfilePresenter: ObservableObject, ProfilePresenterProtocol, ProfileInteractorOutputProtocol {
    // This allows the data to persist even if the View is recreated
    static let shared = ProfilePresenter()
    
    var view: ProfileViewProtocol?
    var interactor: ProfileInteractorInputProtocol?
    var router: ProfileRouterProtocol?

    @Published var name: String = ""
    @Published var email: String = ""
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var showErrorAlert: Bool = false
    
    // Static ensures this survives view re-initialization
    private static var isDataLoaded: Bool = false

    // Private init to enforce singleton pattern for state persistence
    init() {}

    func viewDidLoad() {
        // Check the static flag
        guard !Self.isDataLoaded else {
            print("DEBUG PRESENTER: Data already exists, blocking loading overlay.")
            return
        }
        fetchData()
    }
    
    func refreshData() {
        fetchData(force: true)
    }
    
    private func fetchData(force: Bool = false) {
        // Prevent loading spinner if we already have data (unless forced)
        if Self.isDataLoaded && !force { return }
        
        isLoading = true
        interactor?.fetchUserProfile()
    }

    func didTapLogout() {
        isLoading = true
        interactor?.logout()
    }

    // MARK: - Interactor Output
    @MainActor
    func didFetchUser(name: String, email: String) {
        self.name = name
        self.email = email
        self.isLoading = false
        Self.isDataLoaded = true
    }

    @MainActor
    func didLogoutSuccess() {
        self.isLoading = false
        Self.isDataLoaded = false
        // Clear data on logout
        self.name = ""
        self.email = ""
        router?.navigateToLogin()
    }

    @MainActor
    func didFailWithError(_ message: String) {
        self.isLoading = false
        self.errorMessage = message
        self.showErrorAlert = true
    }
}

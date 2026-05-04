//
//  HomePresenter.swift
//  expense_tracker_ios
//
//  Created by Touch and Solve on 30/4/26.
//

import Foundation
import SwiftUI
import Combine

class HomePresenter: ObservableObject, HomePresenterProtocol, HomeInteractorOutputProtocol {
    var view: HomeViewProtocol?
    var interactor: HomeInteractorInputProtocol?
    var router: HomeRouterProtocol?

    @Published var expenses: [ExpenseEntity] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var showAlert = false
    
    // TRACKER: specifically tracks if the background listener is active
    private var isDataLoaded = false
    private var cancellables = Set<AnyCancellable>()
    
    var topCategory: String {
            guard !expenses.isEmpty else { return "N/A" }
            
            // Dictionary to store total for each category: [CategoryName: TotalAmount]
            let categoryTotals = Dictionary(grouping: expenses) { $0.category }
                .mapValues { $0.reduce(0) { $0 + $1.amount } }
            
            // Find the category with the maximum value
            return categoryTotals.max(by: { $0.value < $1.value })?.key ?? "N/A"
        }
    
    init() {
            setupObservers()
        }
    
    private func setupObservers() {
            NotificationCenter.default.publisher(for: .expenseDidSave)
                .sink { [weak self] _ in
                    print("DEBUG PRESENTER: Notification received! Refreshing data...")
                    self?.refreshData()
                }
                .store(in: &cancellables)
        }

    func viewDidLoad() {
            guard !isDataLoaded || expenses.isEmpty else { return }
            refreshData()
        }
        
        func refreshData() {
            isLoading = (expenses.isEmpty) // Only show spinner if list is empty
            interactor?.startWatchingExpenses()
            isDataLoaded = true
        }
    
    func didTapAddExpense() { router?.navigateToAddExpense() }
    func didTapHistory() { router?.navigateToHistory() }
    func didTapProfile() { router?.navigateToProfile() }

    @MainActor
    func didFetchExpenses(_ expenses: [ExpenseEntity]) {
        print("DEBUG PRESENTER: Received \(expenses.count) items from Interactor")
        self.isLoading = false
        
        // This is the part that handles the refresh when you add a new expense.
        // The Interactor calls this every time the database changes.
        withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
            self.expenses = expenses
        }
    }
    
    @MainActor
    func didFailToFetch(error: String) {
        self.isLoading = false
        self.errorMessage = error
        self.showAlert = true
    }
}

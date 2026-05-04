//
//  AddExpenseInteractor.swift
//  expense_tracker_ios
//
//  Created by Touch and Solve on 30/4/26.
//
import Foundation
import Supabase

class AddExpenseInteractor: AddExpenseInteractorInputProtocol {
    weak var presenter: AddExpenseInteractorOutputProtocol?

    func saveExpense(amount: Double, category: String, note: String) {
        guard let userId = SupabaseManager.shared.client.auth.currentUser?.id else {
            print("DEBUG INTERACTOR: Save failed - No User ID")
            presenter?.didFailToSave(error: "User not authenticated")
            return
        }

        print("DEBUG INTERACTOR: Attempting save for User: \(userId.uuidString)")
        print("DEBUG INTERACTOR: Data -> Cat: \(category), Amt: \(amount), Note: \(note)")

        Task {
            do {
                let expenseData: [String: AnyJSON] = [
                    "category": .string(category),
                    "amount": .double(amount),
                    "note": .string(note),
                    "date": .string(ISO8601DateFormatter().string(from: Date())),
                    "user_id": .string(userId.uuidString)
                ]

                try await SupabaseManager.shared.client
                    .from("expenses")
                    .insert(expenseData)
                    .execute()

                print("DEBUG INTERACTOR: Save Success!")
                await MainActor.run {
                    NotificationCenter.default.post(name: .expenseDidSave, object: nil)
                    presenter?.didSaveSuccessfully()
                }
            } catch {
                print("DEBUG INTERACTOR: Save Error - \(error.localizedDescription)")
                await MainActor.run {
                    presenter?.didFailToSave(error: error.localizedDescription)
                }
            }
        }
    }
}

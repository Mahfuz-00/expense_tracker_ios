//
//  HistoryInteractor.swift
//  expense_tracker_ios
//
//  Created by Touch and Solve on 30/4/26.
//
import Foundation
import Supabase

class HistoryInteractor: HistoryInteractorInputProtocol {
    weak var presenter: HistoryInteractorOutputProtocol?

    func fetchAllExpenses() {
        guard let user = SupabaseManager.shared.client.auth.currentUser else {
            print("DEBUG HISTORY INTERACTOR: No Auth User")
            return
        }

        print("DEBUG HISTORY INTERACTOR: Fetching for user \(user.id.uuidString)")

        Task {
            do {
                let response: [ExpenseResponse] = try await SupabaseManager.shared.client
                    .from("expenses")
                    .select()
                    .eq("user_id", value: user.id.uuidString)
                    .order("date", ascending: false)
                    .execute()
                    .value

                print("DEBUG HISTORY INTERACTOR: Received \(response.count) items from Supabase")

                let entities = response.map { res in
                    ExpenseEntity(
                        id: res.id,
                        category: res.category,
                        amount: res.amount,
                        note: res.note,
                        date: res.date
                    )
                }

                await MainActor.run {
                    presenter?.didFetchHistory(entities)
                }
            } catch {
                print("DEBUG HISTORY INTERACTOR: Error - \(error.localizedDescription)")
            }
        }
    }
}

// Helper struct for Decodable matching your Supabase table
struct ExpenseResponse: Decodable {
    let id: String
    let category: String
    let amount: Double
    let note: String
    let date: Date
}

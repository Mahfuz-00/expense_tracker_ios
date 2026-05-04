//
//  HomeInteractor.swift
//  expense_tracker_ios
//
//  Created by Touch and Solve on 30/4/26.
//
import Foundation
import Supabase
import Realtime

class HomeInteractor: HomeInteractorInputProtocol {
    weak var presenter: HomeInteractorOutputProtocol?
    private var channel: RealtimeChannel?

    func startWatchingExpenses() {
        guard let user = SupabaseManager.shared.client.auth.currentUser else {
            print("DEBUG INTERACTOR: No current user found!")
            return
        }
        
        let userIdString = user.id.uuidString
        print("DEBUG INTERACTOR: Starting watch for User: \(userIdString)")
        
        channel = SupabaseManager.shared.client.realtime.channel("public:expenses")
        
        channel?.on(
            "postgres_changes",
            filter: .init(
                event: "*",
                schema: "public",
                table: "expenses",
                filter: "user_id=eq.\(user.id)" // Use user.id directly for filter compatibility
            )
        ) { [weak self] payload in
            print("DEBUG INTERACTOR: Realtime change detected! Payload: \(payload)")
            Task { await self?.fetchInitialData(userIdString: userIdString) }
        }
        
        Task {
            await fetchInitialData(userIdString: userIdString)
            await channel?.subscribe()
            print("DEBUG INTERACTOR: Realtime Subscribed")
        }
    }

    private func fetchInitialData(userIdString: String) async {
        print("DEBUG INTERACTOR: Fetching data for \(userIdString)...")
        do {
            let response: [ExpenseModel] = try await SupabaseManager.shared.client
                .from("expenses")
                .select()
                .eq("user_id", value: userIdString)
                .order("date", ascending: false)
                .execute()
                .value

            print("DEBUG INTERACTOR: Successfully fetched \(response.count) items")
            
            let entities = response.map { model in
                ExpenseEntity(
                    id: model.id ?? UUID().uuidString,
                    category: model.category,
                    amount: model.amount,
                    note: model.note,
                    date: model.date
                )
            }
            
            await MainActor.run {
                presenter?.didFetchExpenses(entities)
            }
        } catch {
            print("DEBUG INTERACTOR: Fetch Error: \(error.localizedDescription)")
            await MainActor.run {
                presenter?.didFailToFetch(error: error.localizedDescription)
            }
        }
    }
}

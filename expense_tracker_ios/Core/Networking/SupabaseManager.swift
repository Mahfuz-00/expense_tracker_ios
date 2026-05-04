//
//  SupabaseManager.swift
//  expense_tracker_ios
//
//  Created by Touch and Solve on 28/4/26.
//
import Foundation
import Supabase

class SupabaseManager {
    static let shared = SupabaseManager()
    let client: SupabaseClient
    
    private init() {
        let options = SupabaseClientOptions(
                    auth: .init(
                        autoRefreshToken: true,
                        emitLocalSessionAsInitialSession: true
                    )
            )

        self.client = SupabaseClient(
            supabaseURL: URL(string: "https://ingztgndbckkyxvwadhv.supabase.co")!,
            supabaseKey: "sb_publishable_rBedY9lRTJMszqk4dFOHwg_a3spXjFo",
            options: options
        )
    }
}

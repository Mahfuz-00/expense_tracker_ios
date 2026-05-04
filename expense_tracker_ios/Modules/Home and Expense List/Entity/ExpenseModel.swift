//
//  ExpenseModel.swift
//  expense_tracker_ios
//
//  Created by Touch and Solve on 30/4/26.
//
import Foundation

struct ExpenseModel: Codable {
    let id: String?
    let category: String
    let amount: Double
    let note: String
    let date: Date

    func toDictionary(userId: String) -> [String: Any] {
        return [
            "category": category,
            "amount": amount,
            "note": note,
            "date": ISO8601DateFormatter().string(from: date),
            "user_id": userId
        ]
    }
}

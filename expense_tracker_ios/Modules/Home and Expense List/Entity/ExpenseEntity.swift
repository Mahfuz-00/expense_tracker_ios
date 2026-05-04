//
//  ExpenseEntity.swift
//  expense_tracker_ios
//
//  Created by Touch and Solve on 30/4/26.
//
import Foundation

struct ExpenseEntity: Identifiable {
    let id: String
    let category: String
    let amount: Double
    let note: String
    let date: Date
}

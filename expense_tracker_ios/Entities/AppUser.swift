//
//  AppUser.swift
//  expense_tracker_ios
//
//  Created by Touch and Solve on 29/4/26.
//
import Foundation

struct AppUser: Codable {
    let id: UUID
    let email: String
    let name: String
    
    // Maps Supabase Metadata to our Swift property
    enum CodingKeys: String, CodingKey {
        case id, email
        case name = "full_name"
    }
}

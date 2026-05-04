//
//  SuccessView.swift
//  expense_tracker_ios
//
//  Created by Touch and Solve on 29/4/26.
//
import SwiftUI

struct SuccessView: View {
    let title: String
    let message: String
    
    var body: some View {
        VStack(spacing: 32) {
            Spacer()
            
            ZStack {
                Circle()
                    .fill(Color.green.opacity(0.1))
                    .frame(width: 120, height: 120)
                Image(systemName: "checkmark.circle.fill")
                    .font(.system(size: 80))
                    .foregroundColor(.green)
            }
            
            VStack(spacing: 12) {
                Text(title)
                    .font(.system(size: 28, weight: .black))
                    .foregroundColor(Color(red: 30/255, green: 41/255, blue: 59/255))
                
                Text(message)
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.secondary)
                    .padding(.horizontal, 40)
            }
            
            Spacer()
            
            Button(action: {
                // Always take them back to Login to start fresh
                AppStateManager.shared.currentRoute = .login
            }) {
                Text("Continue to Login")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .frame(height: 60)
                    .background(Color(red: 30/255, green: 41/255, blue: 59/255))
                    .foregroundColor(.white)
                    .cornerRadius(18)
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 20)
        }
        .background(Color.white.ignoresSafeArea())
    }
}

// The "Router" part is just a static helper now to avoid naming conflicts
struct SuccessModuleBuilder {
    static func build(title: String, message: String) -> some View {
        return SuccessView(title: title, message: message)
    }
}

//
//  SplashView.swift
//  expense_tracker_ios
//
//  Created by Touch and Solve on 28/4/26.
//
import SwiftUI

struct SplashView: View, SplashViewProtocol {
    var presenter: SplashPresenterProtocol?
    
    var body: some View {
        ZStack {
            Color(red: 49/255, green: 27/255, blue: 146/255) // Colors.deepPurple
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                Image(systemName: "wallet.bifold") // Matching account_balance_wallet feel
                    .font(.system(size: 100))
                    .foregroundColor(.white)
                
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
            }
        }
        .onAppear {
            presenter?.viewDidAppear()
        }
    }
}

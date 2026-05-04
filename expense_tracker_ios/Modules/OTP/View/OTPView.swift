//
//  OTPView.swift
//  expense_tracker_ios
//
//  Created by Touch and Solve on 29/4/26.
//
import SwiftUI

struct OTPView: View {
    var presenter: OTPPresenter?
    @State private var code = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Manual Back Button (Matching your Flutter IconButton style)
            Button(action: { AppStateManager.shared.currentRoute = .login }) {
                Image(systemName: "chevron.left")
                    .font(.system(size: 20, weight: .semibold))
                    .padding(12)
                    .background(Color.white)
                    .clipShape(Circle())
                    .shadow(color: .black.opacity(0.05), radius: 5)
            }
            .foregroundColor(.black)
            .padding(.top, 20)

            Text("Verify Email")
                .font(.system(size: 32, weight: .bold))
                .foregroundColor(Color(red: 30/255, green: 41/255, blue: 59/255))
                .padding(.top, 20)
            
            Text("We've sent a 8-digit code to your inbox")
                .font(.system(size: 16))
                .foregroundColor(Color(red: 100/255, green: 116/255, blue: 139/255))
                .padding(.top, 12)
            
            TextField("00000000", text: $code)
                .font(.system(size: 28, weight: .bold, design: .monospaced))
                .multilineTextAlignment(.center)
                .keyboardType(.numberPad)
                .frame(height: 80)
                .background(Color.white)
                .cornerRadius(20)
                .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.gray.opacity(0.2)))
                .padding(.top, 48)
            
            Button(action: {
                presenter?.didTapVerify(code: code)
            }) {
                Text("Verify & Continue")
                    .font(.system(size: 16, weight: .bold))
                    .frame(maxWidth: .infinity)
                    .frame(height: 60)
                    .background(Color.indigo)
                    .foregroundColor(.white)
                    .cornerRadius(16)
            }
            .padding(.top, 40)
            
            Spacer()
            
            HStack {
                Spacer()
                Button("Resend Code") {
                    // Resend Logic
                }
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(.indigo)
                Spacer()
            }
            .padding(.bottom, 32)
        }
        .padding(.horizontal, 24)
        .background(Color(red: 248/255, green: 250/255, blue: 252/255).ignoresSafeArea())
    }
}

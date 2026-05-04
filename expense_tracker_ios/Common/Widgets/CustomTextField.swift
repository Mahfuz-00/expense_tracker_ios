//
//  CustomTextField.swift
//  expense_tracker_ios
//
//  Created by Touch and Solve on 29/4/26.
//
import SwiftUI

struct CustomTextField: View {
    @Binding var text: String
    var hint: String
    var icon: String
    var isSecure: Bool = false
    var keyboardType: UIKeyboardType = .default 

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .font(.system(size: 20))
                .foregroundColor(Color(red: 100/255, green: 116/255, blue: 139/255))
            
            if isSecure {
                SecureField("", text: $text, prompt: Text(hint).foregroundColor(Color(red: 148/255, green: 163/255, blue: 184/255)))
            } else {
                TextField("", text: $text, prompt: Text(hint).foregroundColor(Color(red: 148/255, green: 163/255, blue: 184/255)))
                    .keyboardType(keyboardType)
                    .autocapitalization(.none)
            }
        }
        .padding(.vertical, 20)
        .padding(.horizontal, 16)
        .background(Color.white)
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color(red: 229/255, green: 231/255, blue: 235/255), lineWidth: 1)
        )
    }
}

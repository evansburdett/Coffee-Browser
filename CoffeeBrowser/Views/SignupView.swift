//
//  SignupView.swift
//  CoffeeBrowser
//
//  Created by Evan Burdett on 7/27/25.
//


import SwiftUI

struct SignupView: View {
  @EnvironmentObject var authVM: AuthViewModel
  @Environment(\.dismiss) var dismiss
  @State private var email = ""
  @State private var password = ""
  
  var body: some View {
    NavigationStack {
      VStack(spacing: 16) {
        TextField("Email", text: $email)
          .keyboardType(.emailAddress)
          .autocapitalization(.none)
          .textFieldStyle(.roundedBorder)
        SecureField("Password", text: $password)
          .textFieldStyle(.roundedBorder)
        Button("Sign Up") {
          Task {
            await authVM.signUp(email: email, password: password)
            if authVM.user != nil { dismiss() }
          }
        }
        .buttonStyle(.borderedProminent)
        Spacer()
      }
      .padding()
      .navigationTitle("Sign Up")
      .toolbar {
        ToolbarItem(placement: .cancellationAction) {
          Button("Cancel") { dismiss() }
        }
      }
    }
  }
}

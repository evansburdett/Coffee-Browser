//
//  LoginView.swift
//  CoffeeBrowser
//
//  Created by Evan Burdett on 7/27/25.
//


import SwiftUI

struct LoginView: View {
  @EnvironmentObject var authVM: AuthViewModel
  @State private var email = ""
  @State private var password = ""
  @State private var showSignup = false
  
  var body: some View {
    VStack(spacing: 16) {
      TextField("Email", text: $email)
        .keyboardType(.emailAddress)
        .autocapitalization(.none)
        .textFieldStyle(.roundedBorder)
      SecureField("Password", text: $password)
        .textFieldStyle(.roundedBorder)
      Button("Log In") {
        Task { await authVM.signIn(email: email, password: password) }
      }
      .buttonStyle(.borderedProminent)
      Spacer()
      Button("Create Account") { showSignup = true }
    }
    .padding()
    .sheet(isPresented: $showSignup) {
      SignupView()
        .environmentObject(authVM)
    }
  }
}

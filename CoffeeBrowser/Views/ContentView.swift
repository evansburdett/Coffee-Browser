//
//  ContentView.swift
//  CoffeeBrowser
//
//  Created by Evan Burdett on 7/27/25.
//


import SwiftUI

struct ContentView: View {
  @EnvironmentObject var authVM: AuthViewModel

  var body: some View {
    Group {
      if authVM.user != nil {
        HomeView()
      } else {
        LoginView()
      }
    }
    .overlay {
      if authVM.isLoading {
        ProgressView().progressViewStyle(.circular)
      }
    }
    .alert(item: Binding(
      get: { authVM.authError.map { AlertError(message: $0) } },
      set: { _ in authVM.authError = nil }
    )) { alert in
      Alert(title: Text("Error"), message: Text(alert.message))
    }
  }
}

struct AlertError: Identifiable {
  let id = UUID()
  let message: String
}

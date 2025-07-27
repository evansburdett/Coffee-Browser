//
//  HomeView.swift
//  CoffeeBrowser
//
//  Created by Evan Burdett on 7/27/25.
//


import SwiftUI

struct HomeView: View {
  @EnvironmentObject var authVM: AuthViewModel

  var body: some View {
    NavigationStack {
      CoffeeListView()   // your existing list
        .navigationTitle("Welcome")
        .toolbar {
          ToolbarItem(placement: .navigationBarTrailing) {
            Button("Log Out") { authVM.signOut() }
          }
        }
    }
  }
}

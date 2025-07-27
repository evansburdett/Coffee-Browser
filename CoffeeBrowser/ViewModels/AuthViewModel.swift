//
//  AuthViewModel.swift
//  CoffeeBrowser
//
//  Created by Evan Burdett on 7/27/25.
//


import SwiftUI
import FirebaseAuth

@MainActor
class AuthViewModel: ObservableObject {
  @Published var user: User? = Auth.auth().currentUser
  @Published var authError: String?
  @Published var isLoading = false

  private var handle: AuthStateDidChangeListenerHandle?

  init() {
    handle = Auth.auth().addStateDidChangeListener { [weak self] _, user in
      self?.user = user
    }
  }

  func signUp(email: String, password: String) async {
    isLoading = true; authError = nil
    do {
      let result = try await Auth.auth().createUser(withEmail: email, password: password)
      user = result.user
    } catch {
      authError = error.localizedDescription
    }
    isLoading = false
  }

  func signIn(email: String, password: String) async {
    isLoading = true; authError = nil
    do {
      let result = try await Auth.auth().signIn(withEmail: email, password: password)
      user = result.user
    } catch {
      authError = error.localizedDescription
    }
    isLoading = false
  }

  func signOut() {
    do {
      try Auth.auth().signOut()
      user = nil
    } catch {
      authError = error.localizedDescription
    }
  }

  deinit {
    if let handle = handle {
      Auth.auth().removeStateDidChangeListener(handle)
    }
  }
}

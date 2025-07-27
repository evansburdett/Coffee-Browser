import SwiftUI
import FirebaseCore

@main
struct CoffeeBrowserApp: App {
  init() {
    FirebaseApp.configure()
  }

  @StateObject private var authVM = AuthViewModel()

  var body: some Scene {
    WindowGroup {
      ContentView()
        .environmentObject(authVM)
    }
  }
}

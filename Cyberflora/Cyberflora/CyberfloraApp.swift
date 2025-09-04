import SwiftUI
import Firebase

@main
struct CyberFlora: App {
    @StateObject private var authViewModel = AuthViewModel() // 👈 Create once here

    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(authViewModel) // 👈 Inject into the environment
        }
    }
}


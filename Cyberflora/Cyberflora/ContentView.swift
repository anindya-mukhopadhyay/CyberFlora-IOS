import SwiftUI

struct ContentView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        if authViewModel.user != nil {
            DashboardView()
        } else {
            LoginView()
        }
    }
}

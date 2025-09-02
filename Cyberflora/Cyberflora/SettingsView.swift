import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        VStack(spacing: 30) {
            Text("Settings ⚙️")
                .font(.largeTitle)
                .padding()
            
            Button(action: {
                authViewModel.logout()
            }) {
                Text("Logout")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.red)
                    .cornerRadius(12)
            }
            .padding(.horizontal)
            
            Spacer()
        }
        .navigationTitle("Settings")
    }
}

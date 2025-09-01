import SwiftUI

struct LoginView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var email = ""
    @State private var password = ""
    @State private var goToSignup = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("CyberFlora Login")
                    .font(.largeTitle).bold()
                
                TextField("Email", text: $email)
                    .autocapitalization(.none)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(10)
                
                SecureField("Password", text: $password)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(10)
                
                if !authViewModel.errorMessage.isEmpty {
                    Text(authViewModel.errorMessage)
                        .foregroundColor(.red)
                }
                
                Button("Login") {
                    authViewModel.login(email: email, password: password)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(10)
                
                NavigationLink("Don’t have an account? Sign Up", destination: SignupView())
                    .padding(.top)
            }
            .padding()
        }
    }
}

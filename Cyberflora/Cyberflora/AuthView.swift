import SwiftUI

struct AuthView: View {
    @EnvironmentObject var authVM: AuthViewModel
    @State private var email = ""
    @State private var password = ""
    @State private var isLogin = true
    
    var body: some View {
        VStack(spacing: 20) {
            Text(isLogin ? "Login" : "Sign Up")
                .font(.largeTitle)
                .bold()
            
            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)
                .padding(.horizontal)
            
            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            
            Button(action: {
                if isLogin {
                    authVM.login(email: email, password: password)
                } else {
                    authVM.signup(email: email, password: password)
                }
            }) {
                Text(isLogin ? "Login" : "Sign Up")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.horizontal)
            }
            
            Button(action: {
                isLogin.toggle()
            }) {
                Text(isLogin ? "Don't have an account? Sign Up" : "Already have an account? Login")
                    .font(.footnote)
                    .foregroundColor(.blue)
            }
        }
    }
}

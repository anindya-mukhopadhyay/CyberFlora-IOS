import Foundation
import FirebaseAuth

class AuthViewModel: ObservableObject {
    @Published var user: FirebaseAuth.User? = nil  // ✅ Explicit type
    @Published var isLoading = false
    @Published var errorMessage = ""
    
    init() {
        self.user = Auth.auth().currentUser
    }
    
    func signup(email: String, password: String) {
        isLoading = true
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            DispatchQueue.main.async {
                self.isLoading = false
                if let error = error {
                    self.errorMessage = error.localizedDescription
                } else {
                    self.user = result?.user
                }
            }
        }
    }
    
    func login(email: String, password: String) {
        isLoading = true
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            DispatchQueue.main.async {
                self.isLoading = false
                if let error = error {
                    self.errorMessage = error.localizedDescription
                } else {
                    self.user = result?.user
                }
            }
        }
    }
    
    func logout() {
        do {
            try Auth.auth().signOut()
            self.user = nil
        } catch {
            self.errorMessage = error.localizedDescription
        }
    }
}

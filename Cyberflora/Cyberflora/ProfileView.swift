//
//  ProfileView.swift
//  Cyberflora
//
//  Created by Anindya Mukhopadhyay on 03/09/25.
//
import SwiftUI
import FirebaseAuth

struct ProfileView: View {
    @State private var email: String = ""
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Profile")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            if !email.isEmpty {
                Text("Email: \(email)")
                    .font(.title3)
                    .foregroundColor(.gray)
            } else {
                Text("No email found")
                    .foregroundColor(.red)
            }
        }
        .padding()
        .onAppear {
            loadUserEmail()
        }
    }
    
    private func loadUserEmail() {
        if let user = Auth.auth().currentUser {
            email = user.email ?? "No email"
        }
    }
}



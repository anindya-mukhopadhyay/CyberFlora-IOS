//
//  ProfileView.swift
//  Cyberflora
//
//  Created by Anindya Mukhopadhyay on 03/09/25.
//
import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct ProfileView: View {
    @State private var name: String = ""
    @State private var phone: String = ""
    @State private var email: String = ""
    @State private var isEditing: Bool = false
    @State private var message: String = ""
    
    private let db = Firestore.firestore()
    
    var body: some View {
        ZStack {
            // 🌿 Background Gradient
            LinearGradient(
                gradient: Gradient(colors: [Color.green.opacity(0.3), Color.teal.opacity(0.4)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 20) {
                    
                    // 🌿 Profile Icon
                    Image(systemName: "leaf.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 120, height: 120)
                        .foregroundStyle(.green, .white)
                        .shadow(radius: 10)
                        .padding(.top, 40)
                    
                    // 🌿 Info Card
                    VStack(spacing: 16) {
                        
                        ProfileRow(title: "Name", text: $name, isEditing: isEditing, icon: "person.fill")
                        ProfileRow(title: "Email", text: $email, isEditing: false, icon: "envelope.fill")
                        ProfileRow(title: "Phone", text: $phone, isEditing: isEditing, icon: "phone.fill")
                        
                        if isEditing {
                            Button(action: saveProfile) {
                                Text("Save Changes")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color.green)
                                    .cornerRadius(12)
                                    .shadow(radius: 5)
                            }
                        }
                    }
                    .padding()
                    .background(.white.opacity(0.8))
                    .cornerRadius(20)
                    .shadow(radius: 8)
                    .padding(.horizontal)
                    
                    // 🌿 Edit / Cancel Button
                    Button(action: {
                        isEditing.toggle()
                    }) {
                        Text(isEditing ? "Cancel" : "Edit Profile")
                            .font(.headline)
                            .foregroundColor(.green)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(.white)
                            .cornerRadius(12)
                            .shadow(radius: 5)
                    }
                    .padding(.horizontal)
                    
                    if !message.isEmpty {
                        Text(message)
                            .foregroundColor(.green)
                            .font(.subheadline)
                            .padding(.top, 10)
                    }
                }
            }
        }
        .onAppear(perform: loadProfile)
        .navigationTitle("My Profile 🌱")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    // 🌿 Load Profile from Firestore
    private func loadProfile() {
        guard let user = Auth.auth().currentUser else { return }
        email = user.email ?? ""
        
        db.collection("users").document(user.uid).getDocument { doc, error in
            if let doc = doc, doc.exists {
                self.name = doc["name"] as? String ?? ""
                self.phone = doc["phone"] as? String ?? ""
            }
        }
    }
    
    // 🌿 Save Profile Updates
    private func saveProfile() {
        guard let user = Auth.auth().currentUser else { return }
        
        db.collection("users").document(user.uid).setData([
            "name": name,
            "phone": phone,
            "email": email
        ], merge: true) { err in
            if let err = err {
                message = "❌ Error: \(err.localizedDescription)"
            } else {
                message = "✅ Profile updated successfully!"
                isEditing = false
            }
        }
    }
}

// 🌿 Reusable Row
struct ProfileRow: View {
    var title: String
    @Binding var text: String
    var isEditing: Bool
    var icon: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.green)
                .frame(width: 30)
            
            if isEditing {
                TextField(title, text: $text)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            } else {
                VStack(alignment: .leading) {
                    Text(title)
                        .font(.caption)
                        .foregroundColor(.gray)
                    Text(text.isEmpty ? "Not set" : text)
                        .font(.body)
                        .foregroundColor(.black)
                }
            }
        }
    }
}

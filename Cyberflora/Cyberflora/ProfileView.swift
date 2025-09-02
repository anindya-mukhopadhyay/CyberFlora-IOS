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
    @State private var age: String = ""
    @State private var email: String = ""
    @State private var isEditing = false
    
    @State private var loading = true
    @State private var message: String?
    
    private let db = Firestore.firestore()
    
    var body: some View {
        VStack(spacing: 20) {
            if loading {
                ProgressView("Loading Profile...")
            } else {
                VStack(spacing: 15) {
                    
                    // Email (read-only)
                    HStack {
                        Text("Email:")
                            .font(.headline)
                        Spacer()
                        Text(email)
                            .foregroundColor(.gray)
                    }
                    
                    // Name
                    HStack {
                        Text("Name:")
                            .font(.headline)
                        Spacer()
                        if isEditing {
                            TextField("Enter name", text: $name)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .frame(width: 200)
                        } else {
                            Text(name.isEmpty ? "Not set" : name)
                        }
                    }
                    
                    // Phone
                    HStack {
                        Text("Phone:")
                            .font(.headline)
                        Spacer()
                        if isEditing {
                            TextField("Enter phone", text: $phone)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .keyboardType(.phonePad)
                                .frame(width: 200)
                        } else {
                            Text(phone.isEmpty ? "Not set" : phone)
                        }
                    }
                    
                    // Age
                    HStack {
                        Text("Age:")
                            .font(.headline)
                        Spacer()
                        if isEditing {
                            TextField("Enter age", text: $age)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .keyboardType(.numberPad)
                                .frame(width: 200)
                        } else {
                            Text(age.isEmpty ? "Not set" : age)
                        }
                    }
                    
                    if let msg = message {
                        Text(msg)
                            .foregroundColor(.blue)
                            .font(.subheadline)
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        if isEditing {
                            saveProfile()
                        }
                        isEditing.toggle()
                    }) {
                        Text(isEditing ? "Save" : "Edit Profile")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(isEditing ? Color.green : Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }
                }
                .padding()
            }
        }
        .onAppear {
            fetchProfile()
        }
        .navigationTitle("Profile")
    }
    
    // Fetch profile data
    private func fetchProfile() {
        guard let user = Auth.auth().currentUser else { return }
        email = user.email ?? ""
        
        let docRef = db.collection("users").document(user.uid)
        docRef.getDocument { document, error in
            loading = false
            if let document = document, document.exists {
                let data = document.data()
                self.name = data?["name"] as? String ?? ""
                self.phone = data?["phone"] as? String ?? ""
                self.age = data?["age"] as? String ?? ""
            } else {
                self.message = "No profile data found."
            }
        }
    }
    
    // Save profile data
    private func saveProfile() {
        guard let user = Auth.auth().currentUser else { return }
        
        let docRef = db.collection("users").document(user.uid)
        docRef.setData([
            "name": name,
            "phone": phone,
            "age": age
        ], merge: true) { error in
            if let error = error {
                self.message = "Error saving: \(error.localizedDescription)"
            } else {
                self.message = "Profile updated successfully!"
            }
        }
    }
}

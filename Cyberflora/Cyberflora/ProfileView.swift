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
    @State private var email: String = ""
    @State private var name: String = ""
    @State private var phone: String = ""
    @State private var dob: Date = Date()
    @State private var age: Int = 0
    @State private var isEditing = false
    
    private let db = Firestore.firestore()
    private let user = Auth.auth().currentUser
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [Color.green.opacity(0.8), Color.teal.opacity(0.6)],
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 25) {
                    // Profile Picture
                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.white)
                        .shadow(radius: 6)
                    
                    // Profile Card
                    VStack(spacing: 18) {
                        profileField(title: "Email", value: email, editable: false)
                        profileField(title: "Name", value: name, editable: isEditing, key: "name")
                        profileField(title: "Phone", value: phone, editable: isEditing, key: "phone")
                        
                        // DOB Picker
                        if isEditing {
                            VStack(alignment: .leading, spacing: 6) {
                                Text("Date of Birth")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                DatePicker("", selection: $dob, displayedComponents: .date)
                                    .datePickerStyle(.compact)
                                    .labelsHidden()
                                    .onChange(of: dob) { _ in
                                        calculateAge()
                                    }
                            }
                        } else {
                            profileField(title: "Date of Birth", value: formattedDOB(), editable: false)
                        }
                        
                        // Age
                        profileField(title: "Age", value: "\(age)", editable: false)
                    }
                    .padding()
                    .background(.white.opacity(0.9))
                    .cornerRadius(20)
                    .shadow(radius: 8)
                    
                    // Edit/Save Button
                    Button(action: {
                        if isEditing {
                            saveProfile()
                        }
                        isEditing.toggle()
                    }) {
                        Text(isEditing ? "Save Profile" : "Edit Profile")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(isEditing ? Color.teal : Color.green)
                            .cornerRadius(15)
                            .shadow(radius: 5)
                    }
                }
                .padding()
            }
        }
        .onAppear {
            loadProfile()
        }
    }
    
    // MARK: - Components
    private func profileField(title: String, value: String, editable: Bool, key: String? = nil) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .font(.caption)
                .foregroundColor(.gray)
            if editable, let key = key {
                TextField(title, text: binding(for: key))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            } else {
                Text(value)
                    .font(.body)
                    .fontWeight(.medium)
            }
        }
    }
    
    private func binding(for key: String) -> Binding<String> {
        switch key {
        case "name":
            return $name
        case "phone":
            return $phone
        default:
            return .constant("")
        }
    }
    
    private func formattedDOB() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: dob)
    }
    
    // MARK: - Firebase Functions
    private func calculateAge() {
        let calendar = Calendar.current
        let now = Date()
        let components = calendar.dateComponents([.year], from: dob, to: now)
        age = components.year ?? 0
    }
    
    private func loadProfile() {
        guard let user = user else { return }
        email = user.email ?? ""
        
        db.collection("users").document(user.uid).getDocument { document, error in
            if let data = document?.data() {
                name = data["name"] as? String ?? ""
                phone = data["phone"] as? String ?? ""
                
                if let timestamp = data["dob"] as? Timestamp {
                    dob = timestamp.dateValue()
                    calculateAge()
                }
                age = data["age"] as? Int ?? age
            }
        }
    }
    
    private func saveProfile() {
        guard let user = user else { return }
        calculateAge()
        
        db.collection("users").document(user.uid).setData([
            "name": name,
            "phone": phone,
            "dob": dob,
            "age": age
        ], merge: true)
    }
}

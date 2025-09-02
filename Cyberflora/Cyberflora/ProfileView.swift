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
    
    @State private var isEditing: Bool = false
    @State private var message: String = ""
    
    private let db = Firestore.firestore()
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 25) {
                    
                    // Profile Header
                    ZStack {
                        Circle()
                            .fill(LinearGradient(gradient: Gradient(colors: [.green.opacity(0.6), .green]), startPoint: .top, endPoint: .bottom))
                            .frame(width: 120, height: 120)
                            .shadow(radius: 8)
                        
                        Image(systemName: "leaf.fill")
                            .font(.system(size: 60))
                            .foregroundColor(.white)
                    }
                    .padding(.top, 30)
                    
                    Text("My Profile")
                        .font(.title2)
                        .bold()
                        .foregroundColor(.green)
                    
                    // Editable Fields
                    VStack(spacing: 20) {
                        profileField(title: "Email", value: $email, editable: false)
                        profileField(title: "Name", value: $name, editable: isEditing)
                        profileField(title: "Phone", value: $phone, editable: isEditing)
                        
                        // DOB + Age
                        if isEditing {
                            DatePicker("Date of Birth", selection: $dob, displayedComponents: .date)
                                .datePickerStyle(.compact)
                                .onChange(of: dob) { _ in calculateAge() }
                                .padding()
                                .background(Color.green.opacity(0.1))
                                .cornerRadius(12)
                        }
                        
                        HStack {
                            Text("Age")
                                .font(.headline)
                                .foregroundColor(.green)
                            Spacer()
                            Text("\(age) years")
                                .foregroundColor(.black)
                        }
                        .padding()
                        .background(Color.green.opacity(0.1))
                        .cornerRadius(12)
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 20).fill(Color.green.opacity(0.05)))
                    .padding(.horizontal)
                    
                    // Buttons
                    Button(action: {
                        if isEditing {
                            saveProfile()
                        }
                        isEditing.toggle()
                    }) {
                        Text(isEditing ? "Save Profile" : "Edit Profile")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(isEditing ? Color.green : Color.blue)
                            .cornerRadius(15)
                    }
                    .padding(.horizontal)
                    
                    if !message.isEmpty {
                        Text(message)
                            .foregroundColor(.gray)
                            .padding(.top, 5)
                    }
                }
                .padding(.bottom, 40)
            }
            .navigationTitle("Profile")
            .onAppear(perform: loadProfile)
        }
    }
    
    // Reusable Profile Field
    func profileField(title: String, value: Binding<String>, editable: Bool) -> some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(title)
                .font(.headline)
                .foregroundColor(.green)
            
            if editable {
                TextField("Enter \(title)", text: value)
                    .padding()
                    .background(Color.green.opacity(0.1))
                    .cornerRadius(12)
            } else {
                Text(value.wrappedValue)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.green.opacity(0.05))
                    .cornerRadius(12)
            }
        }
    }
    
    // Load user data from Firestore
    func loadProfile() {
        guard let user = Auth.auth().currentUser else { return }
        email = user.email ?? ""
        
        db.collection("users").document(user.uid).getDocument { doc, error in
            if let data = doc?.data() {
                name = data["name"] as? String ?? ""
                phone = data["phone"] as? String ?? ""
                if let timestamp = data["dob"] as? Timestamp {
                    dob = timestamp.dateValue()
                    calculateAge()
                }
            }
        }
    }
    
    // Save profile to Firestore
    func saveProfile() {
        guard let user = Auth.auth().currentUser else { return }
        
        let profileData: [String: Any] = [
            "name": name,
            "phone": phone,
            "dob": dob
        ]
        
        db.collection("users").document(user.uid).setData(profileData, merge: true) { err in
            if let err = err {
                message = "Error saving profile: \(err.localizedDescription)"
            } else {
                message = "Profile updated successfully!"
                calculateAge()
            }
        }
    }
    
    // Calculate age from DOB
    func calculateAge() {
        let calendar = Calendar.current
        let now = Date()
        let ageComponents = calendar.dateComponents([.year], from: dob, to: now)
        age = ageComponents.year ?? 0
    }
}

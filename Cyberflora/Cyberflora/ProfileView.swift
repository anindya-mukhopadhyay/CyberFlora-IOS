import SwiftUI
import FirebaseAuth

struct ProfileView: View {
    @State private var showingImagePicker = false
    @State private var selectedImage: UIImage?
    @State private var profileImageURL: URL?
    @State private var isUploading = false
    
    // 🔑 Replace with your Cloudinary details
    private let cloudName = "djoaxuvqs"
    private let uploadPreset = "ml_default"

    var body: some View {
        VStack {
            if let profileImageURL {
                AsyncImage(url: profileImageURL) { image in
                    image.resizable()
                        .scaledToFill()
                        .frame(width: 120, height: 120)
                        .clipShape(Circle())
                } placeholder: {
                    ProgressView()
                }
            } else {
                Circle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 120, height: 120)
                    .overlay(Text("No Image"))
            }

            Button("Change Profile Picture") {
                showingImagePicker = true
            }
            .padding()

            if isUploading {
                ProgressView("Uploading...")
            }
        }
        .onAppear {
            if let url = Auth.auth().currentUser?.photoURL {
                profileImageURL = url
            }
        }
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(image: $selectedImage, onImagePicked: uploadToCloudinary)
        }
    }

    private func uploadToCloudinary(_ image: UIImage) {
        guard let imageData = image.jpegData(compressionQuality: 0.8) else { return }
        isUploading = true
        
        let url = URL(string: "https://api.cloudinary.com/v1_1/\(cloudName)/image/upload")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        let boundary = UUID().uuidString
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

        var body = Data()
        // upload preset
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"upload_preset\"\r\n\r\n".data(using: .utf8)!)
        body.append("\(uploadPreset)\r\n".data(using: .utf8)!)

        // image file
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"file\"; filename=\"profile.jpg\"\r\n".data(using: .utf8)!)
        body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
        body.append(imageData)
        body.append("\r\n".data(using: .utf8)!)
        
        body.append("--\(boundary)--\r\n".data(using: .utf8)!)
        request.httpBody = body

        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                isUploading = false
            }
            if let error = error {
                print("❌ Upload error:", error)
                return
            }
            guard let data = data else { return }
            if let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
               let secureUrl = json["secure_url"] as? String {
                print("✅ Uploaded to Cloudinary:", secureUrl)
                if let url = URL(string: secureUrl) {
                    DispatchQueue.main.async {
                        profileImageURL = url
                    }
                    updateFirebaseProfile(url: url)
                }
            } else {
                print("❌ Failed to parse Cloudinary response:", String(data: data, encoding: .utf8) ?? "nil")
            }
        }.resume()
    }

    private func updateFirebaseProfile(url: URL) {
        if let user = Auth.auth().currentUser {
            let changeRequest = user.createProfileChangeRequest()
            changeRequest.photoURL = url
            changeRequest.commitChanges { error in
                if let error = error {
                    print("❌ Firebase update error:", error.localizedDescription)
                } else {
                    print("✅ Firebase profile updated")
                }
            }
        }
    }
}

// MARK: - Image Picker
struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    var onImagePicked: (UIImage) -> Void

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.allowsEditing = true
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker
        init(_ parent: ImagePicker) { self.parent = parent }
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.editedImage] as? UIImage ?? info[.originalImage] as? UIImage {
                parent.image = uiImage
                parent.onImagePicked(uiImage)
            }
            picker.dismiss(animated: true)
        }
    }
}

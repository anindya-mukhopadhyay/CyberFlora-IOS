import SwiftUI

struct CommunityView: View {
    @State private var posts: [String] = [
        "👨‍🌾 How to treat tomato blight?",
        "🌱 Best fertilizers for paddy?",
        "💧 Irrigation tips during summer?"
    ]
    @State private var newPost: String = ""

    var body: some View {
        VStack {
            Text("👥 Community")
                .font(.largeTitle)
                .padding()

            List(posts, id: \.self) { post in
                Text(post)
            }

            HStack {
                TextField("Write a new post...", text: $newPost)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                Button("Post") {
                    if !newPost.isEmpty {
                        posts.insert("🧑 \(newPost)", at: 0)
                        newPost = ""
                    }
                }
                .padding(.trailing)
            }
        }
        .navigationTitle("Community")
    }
}

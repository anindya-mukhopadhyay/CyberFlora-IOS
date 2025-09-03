
import SwiftUI

struct AyurvedicView: View {
    var body: some View {
        VStack {
            Text("🌿 Ayurvedic Recommendations")
                .font(.largeTitle)
                .padding()

            Text("Discover natural remedies and treatments for common plant diseases.")
                .multilineTextAlignment(.center)
                .padding()

            List {
                Text("🌱 Neem Oil - Natural pesticide")
                Text("🌱 Turmeric - Fungal disease treatment")
                Text("🌱 Garlic Spray - Repels insects")
            }

            Spacer()
        }
        .navigationTitle("Ayurvedic Remedies")
    }
}

import SwiftUI

struct DashboardCard: View {
    var title: String
    var icon: String
    var destination: AnyView

    var body: some View {
        NavigationLink(destination: destination) {
            VStack(spacing: 12) {
                Image(systemName: icon)
                    .font(.system(size: 40))
                    .foregroundColor(.green)
                    .shadow(color: Color.black.opacity(0.6), radius: 5, x: 0, y: 3)

                Text(title)
                    .font(.headline)
                    .foregroundColor(.primary)
            }
            .frame(maxWidth: .infinity, minHeight: 120)
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [Color.green.opacity(0.2), Color.green.opacity(0.05)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .cornerRadius(20)
            .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 4)
            .padding(.horizontal, 8)
        }
    }
}

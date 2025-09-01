import SwiftUI

struct DashboardCard: View {
    var title: String
    var icon: String
    var destination: AnyView

    var body: some View {
        NavigationLink(destination: destination) {
            VStack(spacing: 16) {
                ZStack {
                    Circle()
                        .fill(
                            LinearGradient(
                                gradient: Gradient(colors: [Color.green.opacity(0.6), Color.green.opacity(0.3)]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(width: 70, height: 70)
                        .shadow(color: Color.green.opacity(0.25), radius: 6, x: 0, y: 4)

                    Image(systemName: icon)
                        .font(.system(size: 30, weight: .semibold))
                        .foregroundColor(.white)
                }

                Text(title)
                    .font(.system(size: 18, weight: .semibold, design: .rounded))
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.center)
            }
            .frame(maxWidth: .infinity, minHeight: 150)
            .background(
                RoundedRectangle(cornerRadius: 25, style: .continuous)
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [Color(.systemBackground), Color.green.opacity(0.05)]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
            )
            .overlay(
                RoundedRectangle(cornerRadius: 25)
                    .stroke(Color.green.opacity(0.15), lineWidth: 1)
            )
            .shadow(color: Color.black.opacity(0.08), radius: 10, x: 0, y: 6)
            .padding(.horizontal, 12)
            .scaleEffect(0.98)
            .animation(.spring(response: 0.4, dampingFraction: 0.7), value: UUID())
        }
        .buttonStyle(PlainButtonStyle())
    }
}

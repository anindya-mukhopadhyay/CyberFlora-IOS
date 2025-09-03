import SwiftUI

struct DashboardView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    
                    Text("🌿 CyberFlora Nexus")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.green)
                        .padding(.horizontal)

                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                        
                        DashboardCard(
                            title: "Profile",
                            icon: "person.crop.circle.fill",
                            destination: AnyView(ProfileView())
                        )
                        
                        DashboardCard(
                            title: "Plant Detection",
                            icon: "leaf.fill",
                            destination: AnyView(PlantDetectionView())
                        )
                        
                        DashboardCard(
                            title: "Weather Alerts",
                            icon: "cloud.sun.rain.fill",
                            destination: AnyView(Text("Weather Alerts Screen"))
                        )
                        
                        DashboardCard(
                            title: "Ayurvedic Tips",
                            icon: "cross.fill",
                            destination: AnyView(Text("Ayurvedic Recommendations"))
                        )
                        
                        DashboardCard(
                            title: "3D Garden",
                            icon: "rotate.3d.circle",
                            destination: AnyView(Garden3DView())
                        )
                        
                        DashboardCard(
                            title: "Community",
                            icon: "person.3.fill",
                            destination: AnyView(Text("Community Forum"))
                        )
                        
                        DashboardCard(
                            title: "Recipe Hub",
                            icon: "cooktop.fill",
                            destination: AnyView(Text("Cooking Recipes"))
                        )
                        
                        DashboardCard(
                            title: "Eco Chatbot",
                            icon: "message.fill",
                            destination: AnyView(ChatbotView())
                        )
                        
                        DashboardCard(
                            title: "Saved Plants",
                            icon: "bookmark.fill",
                            destination: AnyView(Text("Saved Plants Screen"))
                        )
                        
                        DashboardCard(
                            title: "Reminders",
                            icon: "bell.fill",
                            destination: AnyView(Text("Reminders & Notifications"))
                        )
                        DashboardCard(
                            title: "Ayurvedic Shops",
                            icon: "cart.circle",
                            destination: AnyView(Text("Ayurvedic Shops"))
                        )
                        
                        // 🌿 New Feature: AR/VR
                        DashboardCard(title: "AR/VR Experience",
                            icon: "arkit",
                            destination: AnyView(ARVRView()))
                                            
                        // 🌿 New Feature: Plant Disease Detection
                        DashboardCard(title: "Disease Detection",
                            icon: "stethoscope",
                            destination: AnyView(PlantDiseaseView()))
                        
                        DashboardCard(
                            title: "Settings",
                            icon: "gearshape.fill",
                            destination: AnyView(SettingsView())
                        )
                    }
                    .padding()
                }
            }
        }
    }
}

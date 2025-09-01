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
                            destination: AnyView(Text("Profile Screen"))
                        )
                        
                        DashboardCard(
                            title: "Plant Detection",
                            icon: "leaf.fill",
                            destination: AnyView(Text("Plant Detection Screen"))
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
                            icon: "cube.fill",
                            destination: AnyView(Text("3D Garden Screen"))
                        )
                        
                        DashboardCard(
                            title: "Community",
                            icon: "person.3.fill",
                            destination: AnyView(Text("Community Forum"))
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
                            destination: AnyView(Text("Settings Screen"))
                        )
                    }
                    .padding()
                }
            }
        }
    }
}

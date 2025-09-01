//
//  WeatherAlertView.swift
//  Cyberflora
//
//  Created by Anindya Mukhopadhyay on 01/09/25.
//

import SwiftUI

struct WeatherAlertView: View {
    var body: some View {
        VStack {
            Text("☁️ Weather Alerts")
                .font(.largeTitle)
                .padding()

            Text("Stay updated with real-time weather alerts for your crops.")
                .multilineTextAlignment(.center)
                .padding()

            Spacer()

            List {
                Text("⚡ Heavy Rainfall Alert - Tomorrow")
                Text("🔥 Heatwave Expected - Next Week")
                Text("💨 Strong Winds - Tonight")
            }

            Spacer()
        }
        .navigationTitle("Weather Alerts")
    }
}

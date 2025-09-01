//
//  PlantDetectionView.swift
//  Cyberflora
//
//  Created by Anindya Mukhopadhyay on 01/09/25.
//

import SwiftUI

struct PlantDetectionView: View {
    var body: some View {
        VStack {
            Text("🌱 Plant Disease Detection")
                .font(.largeTitle)
                .padding()

            Text("Upload or capture a plant image to detect possible diseases.")
                .multilineTextAlignment(.center)
                .padding()

            Spacer()

            Button(action: {
                // Add image picker / ML model call
            }) {
                Text("Upload Plant Image")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(12)
            }
            .padding()

            Spacer()
        }
        .padding()
        .navigationTitle("Plant Detection")
    }
}

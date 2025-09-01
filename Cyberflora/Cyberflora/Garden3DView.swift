//
//  Garden3DView.swift
//  Cyberflora
//
//  Created by Anindya Mukhopadhyay on 01/09/25.
//

import SwiftUI

struct Garden3DView: View {
    var body: some View {
        VStack {
            Text("📚 3D Garden (Education)")
                .font(.largeTitle)
                .padding()

            Text("Interactive 3D garden showcasing plants and their information.")
                .multilineTextAlignment(.center)
                .padding()

            Spacer()

            Text("🌳 3D Garden Placeholder (Integrate 3D SceneKit/RealityKit here)")
                .padding()
                .foregroundColor(.gray)

            Spacer()
        }
        .navigationTitle("3D Garden")
    }
}

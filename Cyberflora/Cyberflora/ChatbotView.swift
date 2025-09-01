//
//  ChatbotView.swift
//  Cyberflora
//
//  Created by Anindya Mukhopadhyay on 01/09/25.
//

import SwiftUI

struct ChatbotView: View {
    @State private var message: String = ""
    @State private var chatHistory: [String] = ["🤖 Hello! How can I help you today?"]

    var body: some View {
        VStack {
            ScrollView {
                ForEach(chatHistory, id: \.self) { msg in
                    Text(msg)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: msg.contains("🤖") ? .leading : .trailing)
                        .background(msg.contains("🤖") ? Color.green.opacity(0.2) : Color.blue.opacity(0.2))
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
            }

            HStack {
                TextField("Type your message...", text: $message)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                Button("Send") {
                    if !message.isEmpty {
                        chatHistory.append("🧑 \(message)")
                        chatHistory.append("🤖 (Bot response placeholder)")
                        message = ""
                    }
                }
                .padding(.trailing)
            }
        }
        .navigationTitle("Chatbot")
    }
}

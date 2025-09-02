import SwiftUI
import WebKit

struct Garden3DView: UIViewRepresentable {
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        if let url = URL(string: "https://d-garden-92743.web.app/") {
            webView.load(URLRequest(url: url))
        }
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {}
}

struct GardenView: View {
    var body: some View {
        Garden3DView()
            .edgesIgnoringSafeArea(.all)
    }
}


import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    let url: URL
    @Binding var showError: Bool // Binding to manage error state

    // Creates and configures the WKWebView
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator // Assigns navigation delegate
        return webView
    }

    // Updates the WKWebView with a new request
    func updateUIView(_ uiView: WKWebView, context: Context) {
        let request = URLRequest(url: url) // Creates URL request
        uiView.load(request) // Loads the request in the WKWebView
    }

    // Creates a coordinator to handle WebView events
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    // Coordinator class to handle WKWebView navigation events
    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: WebView

        init(_ parent: WebView) {
            self.parent = parent
        }

        // Notifies when provisional navigation fails
        func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
            parent.showError = true // Sets showError to true on failure
        }

        // Notifies when navigation fails
        func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
            parent.showError = true // Sets showError to true on failure
        }

        // Notifies when navigation finishes successfully
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            parent.showError = false // Resets showError to false on successful completion
        }
    }
}


import SwiftUI

struct ComicDetailView: View {
    var comic: Comic
    @State private var showError: Bool = false

    private var detailUrl: URL? {
        //$0: This is a shorthand for the first argument passed to the closure. In this case, $0 represents
        //each ComicURL object in the comic.urls array.
        if let detailUrlString = comic.urls.first(where: { $0.type == "detail" })?.url {
            return URL(string: detailUrlString)
        }
        return nil
    }

    var body: some View {
        VStack {
            if showError {
                Text("Failed to load the page. Please check your internet connection and try again.")
                    .padding()
                    .multilineTextAlignment(.center)
            } else if let url = detailUrl {
                WebView(url: url, showError: $showError)
                    .edgesIgnoringSafeArea(.all)
            } else {
                Text("No detailed information available.")
                    .padding()
                    .multilineTextAlignment(.center)
            }
        }
    }
}

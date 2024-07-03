import SwiftUI

struct ContentView: View {
    @State private var characters: [Character] = []
    @State private var offset: Int = 0
    @State private var isLoading: Bool = false
    @State private var hasMoreCharacters: Bool = true
    private let api = MarvelAPI()

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 12) {
                    ForEach(characters) { character in
                        NavigationLink(destination: DetailView(character: character, characters: characters)
                            .transition(.move(edge: .trailing)) // Slide in from the right
                            .onAppear {
                                withAnimation(.easeInOut) { }
                            }
                        ) {
                            AsyncImage(url: URL(string: character.thumbnail.url)) { image in
                                ZStack {
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 170, height: 210)
                                        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 16)
                                                .stroke(Color.clear)
                                                .background(
                                                    LinearGradient(
                                                        gradient: Gradient(colors: [Color.black.opacity(0.0), Color.black]),
                                                        startPoint: .center,
                                                        endPoint: .bottom
                                                    )
                                                    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                                                )
                                        )

                                    Text(character.name)
                                        .font(.caption)
                                        .foregroundColor(.white)
                                        .frame(width: 170)
                                        .padding(.top, 174)
                                        .padding(.horizontal, 10)
                                }
                                .frame(width: 170, height: 210)
                                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                                //he view will fade in when it appears and fade out when it disappears
                                .transition(.opacity)
                                .onAppear {
                                    withAnimation(.easeIn) { }
                                }
                            }
                        }
                    }
                    if isLoading {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                            .scaleEffect(1.5)
                            //rotate 360 degrees cause isLoading is true
                            .rotationEffect(Angle(degrees: isLoading ? 360 : 0))
                            .onAppear {
                                withAnimation(Animation.linear(duration: 1).repeatForever(autoreverses: false)) { }
                            }
                    } else if hasMoreCharacters {
                        //invisible view,  trigger the loading of more characters when the user scrolls to the bottom
                        Color.clear
                            .frame(height: 1)
                            .onAppear {
                                guard !isLoading else { return }
                                self.offset += 20
                                isLoading = true
                                loadMoreCharacters(offset: self.offset)
                            }
                    }
                }
                .padding()
            }
            .navigationTitle("Characters")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                loadMoreCharacters(offset: 0)
            }
        }
        .tint(.white) // Back button white color
    }
    
    private func loadMoreCharacters(offset: Int) {
        //print("Loading more characters with offset: \(offset)")
        api.fetchCharacters(offset: offset) { newCharacters in
            DispatchQueue.main.async {
                let filteredCharacters = newCharacters.filter { !$0.thumbnail.path.contains("image_not_available") }

                if filteredCharacters.isEmpty {
                    print("No new characters found")
                    isLoading = false
                    hasMoreCharacters = false //to stop fetching
                } else {
                    for var newChar in filteredCharacters {
                        //remove the info inside the () if exists
                        if let extras = newChar.name.firstIndex(of: "(") {
                            newChar.name = String(newChar.name.prefix(upTo: extras))
                        }
                        //to not have same characters twice in case same fetching happens
                        if let existingCharacterIndex = self.characters.firstIndex(where: { $0.id == newChar.id }) {
                            self.characters[existingCharacterIndex] = newChar
                        } else {
                            self.characters.append(newChar)
                        }
                    }
                    isLoading = false
                }
            }
        }
    }
}

struct AsyncImage<Content>: View where Content: View {
    @StateObject private var loader: ImageLoader
    var placeholder: Image
    let content: (Image) -> Content

    init(url: URL?, placeholder: Image = Image(systemName: "photo"), @ViewBuilder content: @escaping (Image) -> Content) {
        _loader = StateObject(wrappedValue: ImageLoader(url: url))
        self.placeholder = placeholder
        self.content = content
    }

    var body: some View {
        if let image = loader.image {
            content(Image(uiImage: image))
                .transition(.opacity) // Add a fade-in transition
                .onAppear {
                    withAnimation(.easeIn) {
                        loader.loadImage()
                    }
                }
        } else {
            placeholder
                .onAppear {
                    loader.loadImage()
                }
        }
    }
}

class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    private let url: URL?

    init(url: URL?) {
        self.url = url
    }

    func loadImage() {
        guard let url = url else { return }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error loading image: \(error.localizedDescription)")
                return
            }

            guard let data = data, let image = UIImage(data: data) else {
                print("Invalid image data or unable to create UIImage.")
                return
            }

            DispatchQueue.main.async {
                withAnimation {
                    self.image = image
                }
            }
        }
        task.resume()
    }
}

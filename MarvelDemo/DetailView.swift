import SwiftUI

struct DetailView: View {
    let characters: [Character]
    @State private var currentIndex: Int
    @State private var comics: [Comic] = []
    private let api = MarvelAPI()

    var character: Character {
        characters[currentIndex]
    }

    init(character: Character, characters: [Character]) {
        self.characters = characters
        self._currentIndex = State(initialValue: characters.firstIndex(where: { $0.id == character.id }) ?? 0)
    }

    var body: some View {
        ZStack {
            // Display the main character image
            if let url = URL(string: character.thumbnail.url) {
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 390, height: 844)
                        .edgesIgnoringSafeArea(.all)
                }
                .id(character.id) // force a SwiftUI view to recognize that it needs to be re-rendered when the id changes
            }
            
            //gradient overlay beginning from status bar till center part
            LinearGradient(
                gradient: Gradient(colors: [Color.black, Color.black.opacity(0)]),
                startPoint: .top,
                endPoint: .center
            )
            .edgesIgnoringSafeArea(.all)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment:.bottom, spacing: 16) { // Gap 16px between comics
                    ForEach(comics) { comic in
                        NavigationLink(destination: ComicDetailView(comic: comic)) {
                            AsyncImage(url: URL(string: comic.thumbnail.url)) { image in
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 134, height: 206)
                                    .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                            }
                            .frame(width: 134, height: 206)
                        }
                    }
                }
                .padding(.leading, 16) // Padding for the ScrollView content
             }
             .frame(width: 390) // Fixed width and hug height for the ScrollView
             //Top padding to align comics view higher(should be 606, but it isnt working for me)
             .padding(.top, 540)
                     
            
        }
        .onAppear {
            fetchComicsForCurrentCharacter()
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text(character.name)
                    .font(.custom("Roboto", size: 36).weight(.medium))
                    .frame(width: 294)
                    .lineSpacing(42.19)
                    .kerning(0.1)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                    .padding(.top, 10)
            }
        }
        .gesture(
            DragGesture()
                .onEnded { value in
                    if value.translation.width < -50 { // Swipe left
                        if currentIndex < characters.count - 1 {
                            currentIndex += 1
                            fetchComicsForCurrentCharacter()
                        }
                    } else if value.translation.width > 50 { // Swipe right
                        if currentIndex > 0 {
                            currentIndex -= 1
                            fetchComicsForCurrentCharacter()
                        }
                    }
                }
        )
    }

    private func fetchComicsForCurrentCharacter() {
        api.fetchComics(for: character) { comics in
            self.comics = comics.filter { !$0.thumbnail.path.contains("image_not_available") }
        }
    }
}

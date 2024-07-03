import Foundation

struct CharacterDataWrapper: Decodable {
    let code: Int
    let status: String
    let data: CharacterDataContainer
}

struct CharacterDataContainer: Decodable {
    let offset: Int
    let limit: Int
    let total: Int
    let count: Int
    let results: [Character]
}

struct Character: Decodable, Identifiable {
    let id: Int
    var name: String
    let thumbnail: Thumbnail
}

struct Thumbnail: Decodable {
    let path: String
    let `extension`: String
    
    var url: String {

        let https = "https" + path.dropFirst(4)
        
        return "\(https).\(self.extension)"
    }
}

struct ComicDataWrapper: Decodable {
    let code: Int
    let status: String
    let data: ComicDataContainer
}

struct ComicDataContainer: Decodable {
    let offset: Int
    let limit: Int
    let total: Int
    let count: Int
    let results: [Comic]
}

struct Comic: Decodable, Identifiable {
    let id: Int
    let title: String
    let thumbnail: ComicImage
    let urls: [ComicUrl]
}

struct ComicImage: Decodable {
    let path: String
    let `extension`: String
    
    var url: String {

        let https = "https" + path.dropFirst(4)
        
        return "\(https).\(self.extension)"
    }
}

struct ComicUrl: Decodable {
    let type: String
    let url: String
}


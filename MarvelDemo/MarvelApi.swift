import Foundation
import CryptoKit

class MarvelAPI {
    private let publicKey: String
    private let privateKey: String
    private let baseURL = "https://gateway.marvel.com:443/v1/public/characters"
    
    init() {
        // Initialize the keys when the MarvelAPI instance is created
        self.publicKey = Environment.apiPublicKey
        self.privateKey = Environment.apiPrivateKey
    }
    
    func fetchCharacters(offset: Int, completion: @escaping ([Character]) -> Void) {
        let timestamp = String(Date().timeIntervalSince1970)
        let hash = MD5(data: "\(timestamp)\(privateKey)\(publicKey)")
        
        guard let url = URL(string: "\(baseURL)?offset=\(offset)&ts=\(timestamp)&apikey=\(publicKey)&hash=\(hash)") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Error fetching characters:", error ?? "Unknown error")
                return
            }
            
            do {
                let result = try JSONDecoder().decode(CharacterDataWrapper.self, from: data)
                DispatchQueue.main.async {
                    completion(result.data.results)
                }
            } catch {
                print("Error decoding JSON:", error)
            }
        }
        task.resume()
    }
    
    func fetchComics(for character: Character, completion: @escaping ([Comic]) -> Void) {
        let timestamp = String(Date().timeIntervalSince1970)
        let hash = MD5(data: "\(timestamp)\(privateKey)\(publicKey)")
        
        guard let url = URL(string: "\(baseURL)/\(character.id)/comics?ts=\(timestamp)&apikey=\(publicKey)&hash=\(hash)") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let result = try JSONDecoder().decode(ComicDataWrapper.self, from: data)
                DispatchQueue.main.async {
                    completion(result.data.results)
                }
            } catch {
                print(error)
            }
        }
        task.resume()
    }
        
    private func MD5(data: String) -> String {
        let digest = Insecure.MD5.hash(data: data.data(using: .utf8)!)
        return digest.map { String(format: "%02hhx", $0) }.joined()
    }
}

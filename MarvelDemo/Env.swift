import Foundation

//i tried to do it with the code i have in comments, but it didnt wotk
//i had this error: Raw JSON response: {"code":"InvalidCredentials","message":"The
//passed API key is invalid."} fro my MarvelAPI fetchCharacters()
enum Env {
    static let marvelPublicKey = "6a249a50e44627f9d61fd8a79cb4225a"
    static let marvelPrivateKey = "7565f9615c5e2eb924c30d1304df32214693ddab"
}

//import Foundation
//
//enum Env {
//    static func value(for key: String) -> String? {
//        guard let filePath = Bundle.main.path(forResource: ".env", ofType: nil) else {
//            fatalError("Couldn't find .env file")
//        }
//        
//        print("Found .env file at: \(filePath)")
//        
//        guard let fileContents = try? String(contentsOfFile: filePath) else {
//            fatalError("Couldn't read contents of .env file")
//        }
//        
//        print("Read contents of .env file:")
//        print(fileContents)
//        
//        let lines = fileContents.components(separatedBy: .newlines)
//        for line in lines {
//            let pair = line.components(separatedBy: "=")
//            if pair.count == 2, pair[0] == key {
//                return pair[1]
//            }
//        }
//        
//        return nil
//    }
//
//    static var marvelPublicKey: String {
//        guard let value = value(for: "MARVEL_PUBLIC_KEY") else {
//            fatalError("MARVEL_PUBLIC_KEY not found in .env file")
//        }
//        print("MARVEL_PUBLIC_KEY: \(value)")
//        return value
//    }
//
//    static var marvelPrivateKey: String {
//        guard let value = value(for: "MARVEL_PRIVATE_KEY") else {
//            fatalError("MARVEL_PRIVATE_KEY not found in .env file")
//        }
//        print("MARVEL_PRIVATE_KEY: \(value)")
//        return value
//    }
//}

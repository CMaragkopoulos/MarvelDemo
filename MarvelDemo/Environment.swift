import Foundation

struct Environment {
    static var apiPublicKey: String {
        return Bundle.main.infoDictionary?["API_PUBLIC_KEY"] as? String ?? ""
    }

    static var apiPrivateKey: String {
        return Bundle.main.infoDictionary?["API_PRIVATE_KEY"] as? String ?? ""
    }
}

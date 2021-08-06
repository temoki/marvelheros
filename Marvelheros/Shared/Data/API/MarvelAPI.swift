import Foundation
import Combine
import CryptoSwift

protocol MarvelAPIRequest {
    associatedtype Response: Decodable
    var path: String { get }
    var query: [String: String] { get }
}

enum MarvelAPIError: Error {
    case sessionError(Error)
    case decodeError(Error)
    case unacceptableCode(Int)
}

class MarvelAPIClient {
    static let shared: MarvelAPIClient = {
        guard let plistPath = Bundle.main.path(forResource: "marvelapi", ofType: "plist"),
              let plistDict = NSDictionary(contentsOfFile: plistPath) else {
                  fatalError("marvelapi.plist is not found.")
              }
        
        guard let publicKey = plistDict.value(forKey: "public_key") as? String,
              let privateKey = plistDict.value(forKey: "private_key") as? String else {
                  fatalError("`public_key` or `private_key` is not found in marvelapi.plist")
              }
        
        return .init(publicKey: publicKey, privateKey: privateKey)
    }()
    
    init(publicKey: String, privateKey: String, session: URLSession? = nil) {
        self.publicKey = publicKey
        self.privateKey = privateKey
        self.session = session ?? URLSession(configuration: .default)
    }
    
    func send<Request: MarvelAPIRequest>(_ request: Request) async throws -> Request.Response {
        let timestamp = Date().timeIntervalSince1970
        let hash = "\(timestamp)\(privateKey)\(publicKey)".md5()
        var queryItems: [URLQueryItem] = [
            .init(name: "ts", value: String(timestamp)),
            .init(name: "hash", value: hash),
            .init(name: "api_key", value: publicKey)
        ]
        queryItems.append(contentsOf: request.query.map {
            .init(name: $0, value: $1)
        })
        
        var urlComponents = URLComponents(url: baseURL.appendingPathComponent(request.path), resolvingAgainstBaseURL: false)!
        urlComponents.queryItems = queryItems
        let urlRequest = URLRequest(url: urlComponents.url!)

        let data: Data
        let response: URLResponse
        do {
            (data, response) = try await session.data(for: urlRequest)
        } catch {
            throw MarvelAPIError.sessionError(error)
        }

        let statusCode = (response as! HTTPURLResponse).statusCode
        guard (0..<400).contains(statusCode) else {
            throw MarvelAPIError.unacceptableCode(statusCode)
        }
        
        do {
            return try decoder.decode(Request.Response.self, from: data)
        } catch {
            throw MarvelAPIError.decodeError(error)
        }
    }
    
    // MARK: - Private
    
    private let publicKey: String
    private let privateKey: String
    private let session: URLSession

    private let baseURL = URL(string: "https://gateway.marvel.com:443/v1/public/")!
    private let decoder = JSONDecoder()
}

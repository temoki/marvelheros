import Foundation
import Combine
import CryptoSwift

class APIClient {
    static let shared: APIClient = {
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
    
    func send<Request: APIRequest>(_ request: Request) -> AnyPublisher<Request.Response, APIError> {
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
        
        return session.dataTaskPublisher(for: urlRequest)
            .mapError { APIError.sessionError($0) }
            .tryMap { (data, response) -> Request.Response in
                let statusCode = (response as! HTTPURLResponse).statusCode
                guard (0..<400).contains(statusCode) else {
                    if let responseBody = try? JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary {
                        throw APIError.unacceptableCode(statusCode, responseBody)
                    } else if let responseString = String(data: data, encoding: .utf8) {
                        throw APIError.unacceptableCode(statusCode, ["data": responseString] as NSDictionary)
                    } else {
                        throw APIError.unacceptableCode(statusCode, nil)
                    }
                }

                do {
                    return try JSONDecoder().decode(Request.Response.self, from: data)
                } catch {
                    throw APIError.decodeError(error)
                }
            }
            .mapError { $0 as! APIError }
            .eraseToAnyPublisher()
    }
    
    // MARK: - Private
    
    private let publicKey: String
    private let privateKey: String
    private let session: URLSession

    private let baseURL = URL(string: "https://gateway.marvel.com:443/v1/public/")!
}

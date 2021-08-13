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
    
    func send<Request: APIRequest>(_ request: Request) -> AnyPublisher<(URLRequest, APIResponseBody<Request.Result>), APIError> {
        let urlRequest = urlRequest(for: request)
        return session.dataTaskPublisher(for: urlRequest)
            .mapError { APIError.sessionError($0) }
            .tryMap { (data, response) -> APIResponseBody<Request.Result> in
                try Self.decode(data, response)
            }
            .mapError { $0 as! APIError }
            .map { (urlRequest, $0) }
            .eraseToAnyPublisher()
    }
    
    // MARK: - Private
    
    private let publicKey: String
    private let privateKey: String
    private let session: URLSession

    private let baseURL = URL(string: "https://gateway.marvel.com:443/v1/public/")!
    
    private func urlRequest<Request: APIRequest>(for request: Request) -> URLRequest {
        let timestamp = String(Int(Date().timeIntervalSince1970 * 100))
        let hash = "\(timestamp)\(privateKey)\(publicKey)".md5()
        var queryItems: [URLQueryItem] = [
            .init(name: "ts", value: timestamp),
            .init(name: "hash", value: hash),
            .init(name: "apikey", value: publicKey)
        ]
        queryItems.append(contentsOf: request.query.map {
            .init(name: $0, value: $1)
        })
        
        var urlComponents = URLComponents(url: baseURL.appendingPathComponent(request.path), resolvingAgainstBaseURL: false)!
        urlComponents.queryItems = queryItems
        let urlRequest = URLRequest(url: urlComponents.url!)
        return urlRequest
    }
    
    private static func decode<ResponseBody: Decodable>(_ data: Data, _ response: URLResponse) throws /* APIError */ -> ResponseBody {
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
            return try JSONDecoder().decode(ResponseBody.self, from: data)
        } catch {
            throw APIError.decodeError(error)
        }
    }
}

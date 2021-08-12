import Foundation

protocol APIRequest {
    associatedtype Response: Decodable
    var path: String { get }
    var query: [String: String] { get }
}

import Foundation

protocol APIRequest {
    associatedtype Result: Decodable
    var path: String { get }
    var query: [String: String] { get }
}

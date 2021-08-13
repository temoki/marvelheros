import Foundation

struct APIResponseBody<Result: Decodable>: Decodable {
    var code: Int
    var status: String
    var copyright: String
    var attributionText: String
    var attributionHTML: String
    var etag: String
    var data: Data

    struct Data: Decodable {
        var offset: Int
        var limit: Int
        var total: Int
        var count: Int
        var results: [Result]
    }
}

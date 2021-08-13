import Foundation

struct ThumbnailEntity: Decodable {
    var path: String
    var `extension`: String
}

extension ThumbnailEntity {
    var url: URL? {
        URL(string: "\(path).\(self.extension)")
    }
}

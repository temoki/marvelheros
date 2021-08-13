import Foundation

struct CharacterEntity {
    var id: ID
    var name: String
    var modified: Date
    var thumbnail: ThumbnailEntity
    var resourceURI: String
//    var comics: [ComicEntity]
//    var series: [SeriesEntity]
//    var stories: [StoryEntity]
//    var events: [EventEntity]
}

extension CharacterEntity: Decodable {}

extension CharacterEntity: Identifiable {
    typealias ID = Int
}

extension CharacterEntity: Equatable {
    static func == (lhs: CharacterEntity, rhs: CharacterEntity) -> Bool {
        lhs.id == rhs.id
    }
}

extension CharacterEntity: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

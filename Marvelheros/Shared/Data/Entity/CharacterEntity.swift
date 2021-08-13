import Foundation

struct CharacterEntity {
    var id: ID
    var name: String
    var modified: Date
    var thumbnail: ThumbnailEntity
    var resourceURI: String
    var description: String
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

#if DEBUG
extension CharacterEntity {
    static let cyclops = CharacterEntity(
        id: 1009257,
        name: "Cyclops",
        modified: try! Date("2016-07-05T14:30:06-0400", strategy: .iso8601),
        thumbnail: .init(path: "http://i.annihil.us/u/prod/marvel/i/mg/6/70/526547e2d90ad", extension: "jog"),
        resourceURI: "http://gateway.marvel.com/v1/public/characters/1009257",
        description: ""
    )
    
}
#endif

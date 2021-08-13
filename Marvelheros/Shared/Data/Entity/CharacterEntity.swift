import Foundation

struct CharacterEntity: Decodable, Identifiable {
    var id: Int
    var name: String
    var modified: Date
    var thumbnail: ThumbnailEntity
    var resourceURI: String
//    var comics: [ComicEntity]
//    var series: [SeriesEntity]
//    var stories: [StoryEntity]
//    var events: [EventEntity]
}


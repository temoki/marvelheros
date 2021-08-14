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
        thumbnail: .init(path: "http://i.annihil.us/u/prod/marvel/i/mg/6/70/526547e2d90ad", extension: "jpg"),
        resourceURI: "http://gateway.marvel.com/v1/public/characters/1009257",
        description: ""
    )
    
    static let wolverine = CharacterEntity(
        id: 1009718,
        name: "Wolverine",
        modified: try! Date("2016-05-02T12:21:44-0400", strategy: .iso8601),
        thumbnail: .init(path: "http://i.annihil.us/u/prod/marvel/i/mg/2/60/537bcaef0f6cf", extension: "jpg"),
        resourceURI: "http://gateway.marvel.com/v1/public/characters/1009718",
        description: "Born with super-human senses and the power to heal from almost any wound, Wolverine was captured by a secret Canadian organization and given an unbreakable skeleton and claws. Treated like an animal, it took years for him to control himself. Now, he's a premiere member of both the X-Men and the Avengers."
    )
    
    static let gambit = CharacterEntity(
        id: 1009313,
        name: "Gambit",
        modified: try! Date("2016-03-14T12:47:45-0400", strategy: .iso8601),
        thumbnail: .init(path: "http://i.annihil.us/u/prod/marvel/i/mg/a/40/52696aa8aee99", extension: "jpg"),
        resourceURI: "http://gateway.marvel.com/v1/public/characters/1009313",
        description: ""
    )
    
    static let storm = CharacterEntity(
        id: 1009629,
        name: "Storm",
        modified: try! Date("2016-05-26T11:50:27-0400", strategy: .iso8601),
        thumbnail: .init(path: "http://i.annihil.us/u/prod/marvel/i/mg/6/40/526963dad214d", extension: "jpg"),
        resourceURI: "http://gateway.marvel.com/v1/public/characters/1009629",
        description: "roro Monroe is the descendant of an ancient line of African priestesses, all of whom have white hair, blue eyes, and the potential to wield magic."
    )
    
    static let magneto = CharacterEntity(
        id: 1009417,
        name: "Magneto",
        modified: try! Date("2016-02-10T15:55:02-0500", strategy: .iso8601),
        thumbnail: .init(path: "http://i.annihil.us/u/prod/marvel/i/mg/3/b0/5261a7e53f827", extension: "jpg"),
        resourceURI: "http://gateway.marvel.com/v1/public/characters/1009417",
        description: ""
    )
    
    static let juggernaut = CharacterEntity(
        id: 1009382,
        name: "Juggernaut",
        modified: try! Date("2013-11-20T17:15:17-0500", strategy: .iso8601),
        thumbnail: .init(path: "http://i.annihil.us/u/prod/marvel/i/mg/5/c0/528d340442cca", extension: "jpg"),
        resourceURI: "http://gateway.marvel.com/v1/public/characters/1009382",
        description: ""
    )
    
    static let sabretooth = CharacterEntity(
        id: 1009554,
        name: "Sabretooth",
        modified: try! Date("2014-01-27T16:04:53-0500", strategy: .iso8601),
        thumbnail: .init(path: "http://i.annihil.us/u/prod/marvel/i/mg/1/00/4ce1895117793", extension: "jpg"),
        resourceURI: "http://gateway.marvel.com/v1/public/characters/1009554",
        description: ""
    )
    
    static let rogue = CharacterEntity(
        id: 1009546,
        name: "Rogue",
        modified: try! Date("2016-02-01T14:50:44-0500", strategy: .iso8601),
        thumbnail: .init(path: "http://i.annihil.us/u/prod/marvel/i/mg/3/10/5112d84e2166c", extension: "jpg"),
        resourceURI: "http://gateway.marvel.com/v1/public/characters/1009546",
        description: ""
    )
    
    
}
#endif

import Foundation

struct CharactersRequest {
    // Return only characters matching the specified full character name (e.g. Spider-Man)
    var name: String?
    
    // Return characters with names that begin with the specified string (e.g. Sp).
    var nameStartsWith: String?
    
    // Return only characters which have been modified since the specified date.
    var modifiedSince: Date?
    
    // Return only characters which appear in the specified comics (accepts a comma-separated list of ids).
    var comics: [Int] = []
    
    // Return only characters which appear the specified series (accepts a comma-separated list of ids).
    var series: [Int] = []
    
    // Return only characters which appear in the specified events (accepts a comma-separated list of ids).
    var events: [Int] = []
    
    // Return only characters which appear the specified stories (accepts a comma-separated list of ids).
    var stories: [Int] = []
    
    // Limit the result set to the specified number of resources.
    var limit: Int?

    // Skip the specified number of resources in the result set.
    var offset: Int?
    
    // Order the result set by a field or fields.
    // Add a "-" to the value sort in descending order.
    // Multiple values are given priority in the order in which they are passed.
    enum OrderBy: String {
        case nameAscending = "name"
        case nameDescending = "-name"
        case modifiedAscending = "modified"
        case modifiedDescending = "-modified"
    }
    var orderBy: OrderBy?
}

extension CharactersRequest: APIRequest {
    typealias Result = CharacterEntity

    var path: String {
        "characters"
    }
    
    var query: [String : String] {
        var queryItems: [String: String] = [:]
        if let name = self.name {
            queryItems["name"] = name
        }
        if let nameStartsWith = self.nameStartsWith {
            queryItems["nameStartsWith"] = nameStartsWith
        }
        if let modifiedSince = self.modifiedSince {
            // ？
        }
        if !comics.isEmpty {
            queryItems["comics"] = comics.compactMap({ String($0) }).joined(separator: ",")
        }
        if !series.isEmpty {
            queryItems["series"] = series.compactMap({ String($0) }).joined(separator: ",")
        }
        if !events.isEmpty {
            queryItems["events"] = events.compactMap({ String($0) }).joined(separator: ",")
        }
        if let limit = self.limit {
            queryItems["limit"] = String(limit)
        }
        if let offset = self.offset {
            queryItems["offset"] = String(offset)
        }
        if let orderBy = self.orderBy {
            queryItems["orderBy"] = orderBy.rawValue
        }
        return queryItems
    }
}

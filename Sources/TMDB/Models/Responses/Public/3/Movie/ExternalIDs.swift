import Foundation

public extension TMDB {
    struct ExternalIDs: Codable, Identifiable, Sendable {
        public let id: Int
        public let imdbID: String?
        public let wikidataID: String?
        public let facebookID: String?
        public let instagramID: String?
        public let twitterID: String?

        enum CodingKeys: String, CodingKey {
            case id
            case imdbID = "imdbId"
            case wikidataID = "wikidataId"
            case facebookID = "facebookId"
            case instagramID = "instagramId"
            case twitterID = "twitterId"
        }
    }
}

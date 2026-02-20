import Foundation

public extension TMDB {
    struct ExternalIDs: Codable, Identifiable, Sendable {
        public let id: Int
        public let imdbID: String?
        public let wikidataID: String?
        public let facebookID: String?
        public let instagramID: String?
        public let twitterID: String?
        public let tvdbID: Int?
        public let tvrageID: Int?

        public init(
            id: Int,
            imdbID: String?,
            wikidataID: String?,
            facebookID: String?,
            instagramID: String?,
            twitterID: String?,
            tvdbID: Int?,
            tvrageID: Int?,
        ) {
            self.id = id
            self.imdbID = imdbID
            self.wikidataID = wikidataID
            self.facebookID = facebookID
            self.instagramID = instagramID
            self.twitterID = twitterID
            self.tvdbID = tvdbID
            self.tvrageID = tvrageID
        }

        enum CodingKeys: String, CodingKey {
            case id
            case imdbID = "imdbId"
            case wikidataID = "wikidataId"
            case facebookID = "facebookId"
            case instagramID = "instagramId"
            case twitterID = "twitterId"
            case tvdbID = "tvdbId"
            case tvrageID = "tvrageId"
        }
    }
}

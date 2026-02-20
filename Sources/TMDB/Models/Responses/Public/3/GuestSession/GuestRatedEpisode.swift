import Foundation

public extension TMDB.GuestSession {
    struct RatedEpisode: Codable, Sendable {
        public let airDate: String?
        public let episodeNumber: Int
        public let id: Int
        public let name: String?
        public let overview: String?
        public let productionCode: String?
        public let runtime: Int?
        public let seasonNumber: Int
        public let showID: Int
        public let stillPath: URL?
        public let voteAverage: Double?
        public let voteCount: Int?
        public let rating: Double

        public init(
            airDate: String?,
            episodeNumber: Int,
            id: Int,
            name: String?,
            overview: String?,
            productionCode: String?,
            runtime: Int?,
            seasonNumber: Int,
            showID: Int,
            stillPath: URL?,
            voteAverage: Double?,
            voteCount: Int?,
            rating: Double,
        ) {
            self.airDate = airDate
            self.episodeNumber = episodeNumber
            self.id = id
            self.name = name
            self.overview = overview
            self.productionCode = productionCode
            self.runtime = runtime
            self.seasonNumber = seasonNumber
            self.showID = showID
            self.stillPath = stillPath
            self.voteAverage = voteAverage
            self.voteCount = voteCount
            self.rating = rating
        }

        enum CodingKeys: String, CodingKey {
            case airDate
            case episodeNumber
            case id
            case name
            case overview
            case productionCode
            case runtime
            case seasonNumber
            case showID = "showId"
            case stillPath
            case voteAverage
            case voteCount
            case rating
        }
    }
}

extension TMDB.GuestSession.RatedEpisode: Discoverable {}

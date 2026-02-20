import Foundation

public extension TMDB {
    struct TVEpisode: Identifiable, Sendable {
        public let id: Int
        public let name: String
        public let overview: String
        public let episodeNumber: Int
        public let seasonNumber: Int
        public let airDate: Date?
        public let stillPath: URL?
        public let voteAverage: Double
        public let voteCount: Int
        public let productionCode: String
        public let runtime: Int?
        public let showID: Int?
        public let crew: [CrewMember]?
        public let guestStars: [CastMember]?

        public init(
            id: Int,
            name: String,
            overview: String,
            episodeNumber: Int,
            seasonNumber: Int,
            airDate: Date?,
            stillPath: URL?,
            voteAverage: Double,
            voteCount: Int,
            productionCode: String,
            runtime: Int?,
            showID: Int?,
            crew: [CrewMember]?,
            guestStars: [CastMember]?,
        ) {
            self.id = id
            self.name = name
            self.overview = overview
            self.episodeNumber = episodeNumber
            self.seasonNumber = seasonNumber
            self.airDate = airDate
            self.stillPath = stillPath
            self.voteAverage = voteAverage
            self.voteCount = voteCount
            self.productionCode = productionCode
            self.runtime = runtime
            self.showID = showID
            self.crew = crew
            self.guestStars = guestStars
        }
    }
}

extension TMDB.TVEpisode: Codable {
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case overview
        case episodeNumber
        case seasonNumber
        case airDate
        case stillPath
        case voteAverage
        case voteCount
        case productionCode
        case runtime
        case showID = "showId"
        case crew
        case guestStars
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        overview = try container.decode(String.self, forKey: .overview)
        episodeNumber = try container.decode(Int.self, forKey: .episodeNumber)
        seasonNumber = try container.decode(Int.self, forKey: .seasonNumber)
        if let dateString = try container.decodeIfPresent(String.self, forKey: .airDate) {
            airDate = try? Date(dateString, strategy: .iso8601.year().month().day())
        } else {
            airDate = nil
        }
        stillPath = try container.decodeIfPresent(URL.self, forKey: .stillPath)
        voteAverage = try container.decode(Double.self, forKey: .voteAverage)
        voteCount = try container.decode(Int.self, forKey: .voteCount)
        productionCode = try container.decodeIfPresent(String.self, forKey: .productionCode) ?? ""
        runtime = try container.decodeIfPresent(Int.self, forKey: .runtime)
        showID = try container.decodeIfPresent(Int.self, forKey: .showID)
        crew = try container.decodeIfPresent([TMDB.CrewMember].self, forKey: .crew)
        guestStars = try container.decodeIfPresent([TMDB.CastMember].self, forKey: .guestStars)
    }
}

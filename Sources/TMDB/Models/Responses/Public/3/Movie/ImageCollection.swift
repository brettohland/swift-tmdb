import Foundation

public extension TMDB {
    struct ImageCollection: Sendable {
        public let id: Int
        public let backdrops: [ImageDetail]
        public let logos: [ImageDetail]
        public let posters: [ImageDetail]
        public let stills: [ImageDetail]

        public init(
            id: Int,
            backdrops: [ImageDetail],
            logos: [ImageDetail],
            posters: [ImageDetail],
            stills: [ImageDetail],
        ) {
            self.id = id
            self.backdrops = backdrops
            self.logos = logos
            self.posters = posters
            self.stills = stills
        }
    }

    struct ImageDetail: Codable, Sendable {
        public let aspectRatio: Double
        public let height: Int
        public let width: Int
        public let filePath: URL
        public let voteAverage: Double
        public let voteCount: Int
        public let languageCode: String?

        public init(
            aspectRatio: Double,
            height: Int,
            width: Int,
            filePath: URL,
            voteAverage: Double,
            voteCount: Int,
            languageCode: String?,
        ) {
            self.aspectRatio = aspectRatio
            self.height = height
            self.width = width
            self.filePath = filePath
            self.voteAverage = voteAverage
            self.voteCount = voteCount
            self.languageCode = languageCode
        }

        enum CodingKeys: String, CodingKey {
            case aspectRatio
            case height
            case width
            case filePath
            case voteAverage
            case voteCount
            case languageCode = "iso6391"
        }
    }
}

extension TMDB.ImageCollection: Codable {
    enum CodingKeys: String, CodingKey {
        case id
        case backdrops
        case logos
        case posters
        case stills
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        backdrops = try container.decodeIfPresent([TMDB.ImageDetail].self, forKey: .backdrops) ?? []
        logos = try container.decodeIfPresent([TMDB.ImageDetail].self, forKey: .logos) ?? []
        posters = try container.decodeIfPresent([TMDB.ImageDetail].self, forKey: .posters) ?? []
        stills = try container.decodeIfPresent([TMDB.ImageDetail].self, forKey: .stills) ?? []
    }
}

import Foundation

public extension TMDB {
    /// A collection of logo images, returned by company and network image endpoints.
    struct LogoCollection: Codable, Identifiable, Sendable {
        public let id: Int
        public let logos: [LogoDetail]

        public init(id: Int, logos: [LogoDetail]) {
            self.id = id
            self.logos = logos
        }

        public init(from decoder: any Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            id = try container.decode(Int.self, forKey: .id)
            logos = try container.decodeIfPresent([TMDB.LogoDetail].self, forKey: .logos) ?? []
        }

        enum CodingKeys: String, CodingKey {
            case id
            case logos
        }
    }

    struct LogoDetail: Codable, Sendable {
        public let id: String
        public let aspectRatio: Double
        public let filePath: URL
        public let height: Int
        public let width: Int
        public let fileType: String
        public let voteAverage: Double
        public let voteCount: Int

        public init(
            id: String,
            aspectRatio: Double,
            filePath: URL,
            height: Int,
            width: Int,
            fileType: String,
            voteAverage: Double,
            voteCount: Int,
        ) {
            self.id = id
            self.aspectRatio = aspectRatio
            self.filePath = filePath
            self.height = height
            self.width = width
            self.fileType = fileType
            self.voteAverage = voteAverage
            self.voteCount = voteCount
        }
    }
}

import Foundation

public extension TMDB {
    struct ReleaseDateResult: Codable, Sendable {
        @RegionCode
        public var regionCode: Locale.Region
        public let releaseDates: [ReleaseDate]

        public init(regionCode: Locale.Region, releaseDates: [ReleaseDate]) {
            _regionCode = RegionCode(wrappedValue: regionCode)
            self.releaseDates = releaseDates
        }

        enum CodingKeys: String, CodingKey {
            case regionCode = "iso31661"
            case releaseDates
        }
    }

    struct ReleaseDate: Codable, Sendable {
        public let certification: String
        public let languageCode: String
        public let releaseDate: String
        public let type: Int
        public let note: String?

        public init(certification: String, languageCode: String, releaseDate: String, type: Int, note: String?) {
            self.certification = certification
            self.languageCode = languageCode
            self.releaseDate = releaseDate
            self.type = type
            self.note = note
        }

        enum CodingKeys: String, CodingKey {
            case certification
            case languageCode = "iso6391"
            case releaseDate
            case type
            case note
        }
    }
}

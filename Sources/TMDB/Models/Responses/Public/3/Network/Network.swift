import Foundation

public extension TMDB {
    struct Network: Codable, Identifiable, Sendable {
        public let id: Int
        public let name: String
        public let headquarters: String
        public let homepage: String
        public let logoPath: URL?
        public let originCountry: Locale.Region

        public init(
            id: Int,
            name: String,
            headquarters: String,
            homepage: String,
            logoPath: URL?,
            originCountry: Locale.Region,
        ) {
            self.id = id
            self.name = name
            self.headquarters = headquarters
            self.homepage = homepage
            self.logoPath = logoPath
            self.originCountry = originCountry
        }
    }
}

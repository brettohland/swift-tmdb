import Foundation

public extension TMDB {
    struct ProductionCompany: Codable, Equatable, Identifiable, Sendable {
        public let id: Int
        public let logoPath: String?
        public let name: String
        public let originCountry: Locale.Region

        public init(id: Int, logoPath: String?, name: String, originCountry: Locale.Region) {
            self.id = id
            self.logoPath = logoPath
            self.name = name
            self.originCountry = originCountry
        }
    }
}

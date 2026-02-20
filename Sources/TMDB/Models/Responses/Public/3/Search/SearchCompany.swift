import Foundation

public extension TMDB {
    struct SearchCompany: Codable, Sendable, Discoverable {
        public let id: Int
        public let name: String
        public let logoPath: URL?
        public let originCountry: String?

        public init(id: Int, name: String, logoPath: URL?, originCountry: String?) {
            self.id = id
            self.name = name
            self.logoPath = logoPath
            self.originCountry = originCountry
        }
    }
}

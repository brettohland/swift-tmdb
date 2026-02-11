import Foundation

public extension TMDB {
    struct SearchCompany: Codable, Sendable, Discoverable {
        public let id: Int
        public let name: String
        public let logoPath: URL?
        public let originCountry: String?
    }
}

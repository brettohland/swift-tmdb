import Foundation

public extension TMDB {
    struct Company: Codable, Identifiable, Sendable {
        public let id: Int
        public let name: String
        public let description: String
        public let headquarters: String
        public let homepage: String
        public let logoPath: URL?
        public let originCountry: Locale.Region
        public let parentCompany: ParentCompany?

        public init(
            id: Int,
            name: String,
            description: String,
            headquarters: String,
            homepage: String,
            logoPath: URL?,
            originCountry: Locale.Region,
            parentCompany: ParentCompany?,
        ) {
            self.id = id
            self.name = name
            self.description = description
            self.headquarters = headquarters
            self.homepage = homepage
            self.logoPath = logoPath
            self.originCountry = originCountry
            self.parentCompany = parentCompany
        }
    }
}

// MARK: - Nested Types

public extension TMDB.Company {
    struct ParentCompany: Codable, Identifiable, Sendable {
        public let id: Int
        public let name: String
        public let logoPath: URL?

        public init(id: Int, name: String, logoPath: URL?) {
            self.id = id
            self.name = name
            self.logoPath = logoPath
        }
    }
}

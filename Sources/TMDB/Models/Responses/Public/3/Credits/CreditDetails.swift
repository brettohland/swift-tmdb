import Foundation

public extension TMDB.Credits {
    struct Details: Codable, Identifiable, Sendable {
        public let creditType: String
        public let department: String
        public let job: String
        public let media: Media
        public let mediaType: String
        public let id: String
        public let person: Person
    }
}

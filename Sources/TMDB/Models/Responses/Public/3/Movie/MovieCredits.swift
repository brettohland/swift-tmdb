import Foundation

public extension TMDB {
    struct MovieCredits: Codable, Identifiable, Sendable {
        public let id: Int
        public let cast: [CastMember]
        public let crew: [CrewMember]
    }
}

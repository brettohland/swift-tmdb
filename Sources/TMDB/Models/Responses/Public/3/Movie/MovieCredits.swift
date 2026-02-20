import Foundation

public extension TMDB {
    struct MediaCredits: Codable, Identifiable, Sendable {
        public let id: Int
        public let cast: [CastMember]
        public let crew: [CrewMember]

        public init(id: Int, cast: [CastMember], crew: [CrewMember]) {
            self.id = id
            self.cast = cast
            self.crew = crew
        }
    }
}

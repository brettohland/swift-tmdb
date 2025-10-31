
import Foundation

public extension TMDBInternal {

    struct Genre: Codable, Equatable, Identifiable, Sendable {
        public let id: Int
        public let name: String
    }

}

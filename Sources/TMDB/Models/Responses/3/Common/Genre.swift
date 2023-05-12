
import Foundation

public extension TMDB {

    struct Genre: Codable, Equatable, Identifiable {
        public let id: Int
        public let name: String
    }

}

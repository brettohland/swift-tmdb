import Foundation

public extension TMDB {
    struct PersonImages: Codable, Identifiable, Sendable {
        public let id: Int
        public let profiles: [ImageDetail]

        public init(id: Int, profiles: [ImageDetail]) {
            self.id = id
            self.profiles = profiles
        }

        public init(from decoder: any Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            id = try container.decode(Int.self, forKey: .id)
            profiles = try container.decodeIfPresent([TMDB.ImageDetail].self, forKey: .profiles) ?? []
        }

        enum CodingKeys: String, CodingKey {
            case id
            case profiles
        }
    }
}

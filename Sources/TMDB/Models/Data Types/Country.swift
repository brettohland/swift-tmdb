import Foundation

public struct Country: Equatable {
    public let identifier: String
    public let name: String?

    public var locale: Locale? {
        Locale(identifier: identifier)
    }

    enum CodingKeys: String, CodingKey {
        case iso3166 = "iso_3166_1"
        case englishName = "english_name"
    }
}

extension Country: Codable {
    public init(from decoder: Decoder) throws {
        // First, try to decode the custom type
        if let container = try? decoder.container(keyedBy: CodingKeys.self) {
            identifier = try container.decode(String.self, forKey: .iso3166)
            name = try container.decodeIfPresent(String.self, forKey: .englishName)
            return
        }

        // Otherwise attempt to decode a single value (what happens in the Discover TV endpoint)
        guard let singleValueContainer = try? decoder.singleValueContainer() else {
            let context = DecodingError.Context(codingPath: [], debugDescription: "Invalid structure")
            throw DecodingError.dataCorrupted(context)
        }

        identifier = try singleValueContainer.decode(String.self)
        name = nil
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(identifier, forKey: .iso3166)
        try container.encode(name, forKey: .englishName)
    }
}

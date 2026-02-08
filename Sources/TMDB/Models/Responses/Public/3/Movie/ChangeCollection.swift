import Foundation

public extension TMDB {
    struct ChangeCollection: Codable, Sendable {
        public let changes: [Change]
    }

    struct Change: Codable, Sendable {
        public let key: String
        public let items: [ChangeItem]
    }

    struct ChangeItem: Codable, Sendable {
        public let id: String
        public let action: String
        public let time: String
        public let languageCode: String?
        public let regionCode: String?
        public let value: AnyCodableValue?

        enum CodingKeys: String, CodingKey {
            case id
            case action
            case time
            case languageCode = "iso6391"
            case regionCode = "iso31661"
            case value
        }
    }

    enum AnyCodableValue: Codable, Sendable {
        case string(String)
        case int(Int)
        case double(Double)
        case bool(Bool)
        case dictionary([String: AnyCodableValue])
        case array([AnyCodableValue])

        public init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            if let value = try? container.decode(Bool.self) {
                self = .bool(value)
            } else if let value = try? container.decode(Int.self) {
                self = .int(value)
            } else if let value = try? container.decode(Double.self) {
                self = .double(value)
            } else if let value = try? container.decode(String.self) {
                self = .string(value)
            } else if let value = try? container.decode([String: AnyCodableValue].self) {
                self = .dictionary(value)
            } else if let value = try? container.decode([AnyCodableValue].self) {
                self = .array(value)
            } else {
                throw DecodingError.dataCorruptedError(in: container, debugDescription: "Unsupported value type")
            }
        }

        public func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            switch self {
            case .string(let value):
                try container.encode(value)
            case .int(let value):
                try container.encode(value)
            case .double(let value):
                try container.encode(value)
            case .bool(let value):
                try container.encode(value)
            case .dictionary(let value):
                try container.encode(value)
            case .array(let value):
                try container.encode(value)
            }
        }
    }
}

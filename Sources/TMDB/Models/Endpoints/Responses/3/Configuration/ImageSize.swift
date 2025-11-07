import Foundation

extension TMDB.Configuration {
    enum ImageSize: Codable, RawRepresentable, Equatable {
        case setHeight(Int)
        case setWidth(Int)
        case original

        var rawValue: String {
            switch self {
            case .original:
                "original"
            case .setHeight(let height):
                "h\(height.formatted())"
            case .setWidth(let width):
                "w\(width.formatted())"
            }
        }

        init?(rawValue: String) {
            // Decode original
            if rawValue == Self.original.rawValue {
                self = .original
                return
            }

            let rawValueRegex = /(?<prefix>[wh])(?<digit>\d*\b)/

            guard
                let match = rawValue.wholeMatch(of: rawValueRegex),
                let size = Int(match.output.digit)
            else {
                return nil
            }

            switch match.output.prefix {
            case "w":
                self = .setWidth(size)
            case "h":
                self = .setHeight(size)
            default:
                return nil
            }
        }

        init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            let stringValue = try container.decode(String.self)
            guard let imageSize = Self(rawValue: stringValue) else {
                throw try DecodingError.dataCorruptedError(
                    in: decoder.unkeyedContainer(),
                    debugDescription: """
                    The value found does not match the regex (?<prefix>[wh])(?<digit>\\d*\\b)
                    """,
                )
            }
            self = imageSize
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            try container.encode(rawValue)
        }
    }
}

import Foundation

/// Decodes/Encodes ISO-8601 "yyyy-MM-DD" string values into `Date` objects
@propertyWrapper
public struct ISO8601YMD: Equatable, Sendable {
    public let wrappedValue: Date?

    public init(wrappedValue: Date?) {
        self.wrappedValue = wrappedValue
    }
}

extension ISO8601YMD: Decodable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let stringValue = try container.decode(String.self)
        wrappedValue = try Date(stringValue, strategy: .iso8601.year().month().day())
    }
}

extension ISO8601YMD: Encodable {
    public func encode(to encoder: Encoder) throws {
        guard let wrappedValue else {
            return
        }
        var container = encoder.singleValueContainer()
        try container.encode(wrappedValue.formatted(.iso8601.year().month().day()))
    }
}

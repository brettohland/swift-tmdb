import Foundation

/// Decodes an empty string as `nil`
@propertyWrapper
public struct EmptyStringNullable<T: Codable>: Sendable where T: Sendable {
    public let wrappedValue: T?

    public init(wrappedValue: T?) {
        self.wrappedValue = wrappedValue
    }
}

extension EmptyStringNullable: Decodable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        wrappedValue = try? container.decode(T.self)
    }
}

extension EmptyStringNullable: Encodable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch wrappedValue {
        case nil:
            try container.encode("")
        case .some(let value):
            try container.encode(value)
        }
    }
}

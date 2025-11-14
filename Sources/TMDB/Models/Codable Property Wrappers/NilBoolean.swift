import Foundation

/// Decodes/Encodes an optional boolean string as a `Bool`
///
/// > Important: If the the JSON object omits this key/value pair, it will decode as `false`
@propertyWrapper
public struct NilBoolean: Sendable {
    public let wrappedValue: Bool
    public init(wrappedValue: Bool) {
        self.wrappedValue = wrappedValue
    }
}

extension NilBoolean: Decodable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        wrappedValue = (try? container.decode(Bool.self)) ?? false
    }
}

extension NilBoolean: Encodable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(wrappedValue)
    }
}

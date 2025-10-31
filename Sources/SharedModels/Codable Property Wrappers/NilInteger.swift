import Foundation

@propertyWrapper
public struct NilInteger {
    public let wrappedValue: Int
    public init(wrappedValue: Int) {
        self.wrappedValue = wrappedValue
    }
}

extension NilInteger: Decodable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        wrappedValue = (try? container.decode(Int.self)) ?? 0
    }
}

extension NilInteger: Encodable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(wrappedValue)
    }
}

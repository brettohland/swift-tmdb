import Foundation

@propertyWrapper
public struct NilCodableArray<T: Codable> {
    public let wrappedValue: [T]
    public init(wrappedValue: [T]) {
        self.wrappedValue = wrappedValue
    }
}

extension NilCodableArray: Decodable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let array = try container.decode([T].self)
        wrappedValue = array
    }
}

extension NilCodableArray: Encodable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        guard wrappedValue.isEmpty == false else {
            return
        }
        try container.encode(wrappedValue)
    }
}

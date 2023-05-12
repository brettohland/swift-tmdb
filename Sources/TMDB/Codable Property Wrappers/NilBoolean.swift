import Foundation

@propertyWrapper
struct NilBoolean {
    let wrappedValue: Bool
}

extension NilBoolean: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        wrappedValue = (try? container.decode(Bool.self)) ?? false
    }
}

extension NilBoolean: Encodable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(wrappedValue)
    }
}

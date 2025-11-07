import Foundation

@propertyWrapper
struct NilInteger {
    let wrappedValue: Int
    init(wrappedValue: Int) {
        self.wrappedValue = wrappedValue
    }
}

extension NilInteger: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        wrappedValue = (try? container.decode(Int.self)) ?? 0
    }
}

extension NilInteger: Encodable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(wrappedValue)
    }
}

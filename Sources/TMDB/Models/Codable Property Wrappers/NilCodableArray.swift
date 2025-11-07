import Foundation

@propertyWrapper
struct NilCodableArray<T: Codable> {
    let wrappedValue: [T]
    init(wrappedValue: [T]) {
        self.wrappedValue = wrappedValue
    }
}

extension NilCodableArray: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let array = try container.decode([T].self)
        wrappedValue = array
    }
}

extension NilCodableArray: Encodable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        guard wrappedValue.isEmpty == false else {
            return
        }
        try container.encode(wrappedValue)
    }
}

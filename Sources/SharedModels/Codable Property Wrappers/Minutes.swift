import Foundation

@propertyWrapper
public struct Minutes: Sendable {
    public let wrappedValue: Measurement<UnitDuration>
    public init(wrappedValue: Measurement<UnitDuration>) {
        self.wrappedValue = wrappedValue
    }
}

extension Minutes: Equatable {}

extension Minutes: Decodable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let minutes = try container.decode(Int.self)
        wrappedValue = Measurement(value: Double(minutes), unit: UnitDuration.minutes)
    }
}

extension Minutes: Encodable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        let minutes = wrappedValue.converted(to: .minutes).value
        try container.encode(Int(minutes))
    }
}

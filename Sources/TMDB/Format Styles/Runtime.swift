import Foundation

public struct Runtime: FormatStyle {
    public typealias FormatInput = Measurement<UnitDuration>
    public typealias FormatOutput = String

    let style: Date.ComponentsFormatStyle.Style

    public func format(_ value: Measurement<UnitDuration>) -> String {
        let seconds = value.converted(to: .seconds).value
        let now = Date.now
        let then = now.addingTimeInterval(seconds)
        return (now ..< then).formatted(.components(style: style, fields: [.hour, .minute]))
    }
}

public extension FormatStyle where Self == Measurement<UnitDuration>.FormatStyle {
    static func runtime(style: Date.ComponentsFormatStyle.Style = .condensedAbbreviated) -> Runtime {
        Runtime(style: style)
    }
}

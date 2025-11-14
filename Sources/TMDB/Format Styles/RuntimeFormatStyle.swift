import Foundation

/// A format style purpose-built to display the runtime of a film or television show.
///
/// Use the `.runtime` computed property, or `.runtime(style:displayUnit:)` static method on FormatStyle for easier
/// access.
public struct Runtime: FormatStyle {
    public typealias FormatInput = Measurement<UnitDuration>
    public typealias FormatOutput = String

    /// Controls which units to include when converting the runtime for display to the user
    public enum DisplayUnit: Codable {
        /// Attempts to display the runtime using a combination of hours and minutes.
        ///
        /// > Important: The hours unit will be omitted for runtimes less than an hour.
        case hourMinute
        /// Displays the runtime in minutes.
        ///
        /// > Important: Runtimes over an hour will still only be displayed in minutes
        case minutesOnly
    }

    /// Controls how the duration unit is displayed to the user
    let style: Date.ComponentsFormatStyle.Style
    /// Controls which units are included in the display
    let displayUnit: DisplayUnit
    /// The `Locale` to use when formatting for display
    let locale: Locale

    //// Initialize a new Runtime format style used for displaying movie or television show runtimes to the user.
    /// - Parameters:
    ///   - style: Controls the styling of the unit and its proximity to the numerical value
    ///   - displayUnit: Controls which units to display to the user
    ///   - locale: The Locale used during the conversion (defaults to `.autoupdatingCurrent`
    public init(
        style: Date.ComponentsFormatStyle.Style,
        displayUnit: DisplayUnit,
        locale: Locale = .autoupdatingCurrent,
    ) {
        self.style = style
        self.displayUnit = displayUnit
        self.locale = locale
    }

    public func format(_ value: Measurement<UnitDuration>) -> String {
        let seconds = value.converted(to: .seconds).value
        let now = Date.now
        let then = now.addingTimeInterval(seconds)
        let fields: Set<Date.ComponentsFormatStyle.Field> = switch displayUnit {
        case .hourMinute:
            [.hour, .minute]
        case .minutesOnly:
            [.minute]
        }
        return (now ..< then).formatted(.components(style: style, fields: fields).locale(locale))
    }
}

public extension FormatStyle where Self == Measurement<UnitDuration>.FormatStyle {
    /// Display a movie or television show's runtime in minutes.
    ///
    /// This format style will use your device's current locale for localization.
    ///
    /// > Note: For more options use the `.runtime(style:displayUnit:)` method on
    static var runtime: Runtime {
        runtime(style: .abbreviated, displayUnit: .minutesOnly)
    }

    /// Display a movie or television show's runtime using additional customization values
    /// - Parameters:
    ///   - style: Controls the styling of the unit and its proximity to the numerical value
    ///   - displayUnit: Controls which units to display to the user
    ///   - locale: The Locale used during the conversion (defaults to `.autoupdatingCurrent`)
    /// - Returns: A string representation of the runtime
    static func runtime(
        style: Date.ComponentsFormatStyle.Style,
        displayUnit: Runtime.DisplayUnit,
        locale: Locale = .autoupdatingCurrent,
    ) -> Runtime {
        Runtime(style: style, displayUnit: displayUnit, locale: locale)
    }
}

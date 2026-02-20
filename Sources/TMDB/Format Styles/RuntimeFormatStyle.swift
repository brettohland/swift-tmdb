import Foundation

/// A format style for displaying movie or television show runtimes in a human-readable form.
///
/// `Runtime` converts a `Measurement<UnitDuration>` into a localized string using
/// `Date.ComponentsFormatStyle`. It is most commonly used with the `@Minutes` property wrapper,
/// which decodes integer minutes from the TMDB API into `Measurement<UnitDuration>` values.
///
/// ### Quick Start
///
/// Use the `.runtime` shorthand on any `Measurement<UnitDuration>` value:
///
/// ```swift
/// let movie = try await TMDB.movieDetails(id: 550)
/// movie.runtime.formatted(.runtime)
/// // "139 min"
/// ```
///
/// ### Display Units
///
/// Choose between minutes-only and hour/minute display using ``DisplayUnit``:
///
/// ```swift
/// movie.runtime.formatted(.runtime(style: .abbreviated, displayUnit: .minutesOnly))
/// // "139 min"
///
/// movie.runtime.formatted(.runtime(style: .abbreviated, displayUnit: .hourMinute))
/// // "2 hr, 19 min"
/// ```
///
/// ### Styles
///
/// The `style` parameter accepts any `Date.ComponentsFormatStyle.Style` value:
///
/// ```swift
/// // Abbreviated (default)
/// movie.runtime.formatted(.runtime(style: .abbreviated, displayUnit: .hourMinute))
/// // "2 hr, 19 min"
///
/// // Wide
/// movie.runtime.formatted(.runtime(style: .wide, displayUnit: .hourMinute))
/// // "2 hours, 19 minutes"
///
/// // Narrow
/// movie.runtime.formatted(.runtime(style: .narrow, displayUnit: .hourMinute))
/// // "2h 19m"
///
/// // Condensed Abbreviated
/// movie.runtime.formatted(.runtime(style: .condensedAbbreviated, displayUnit: .hourMinute))
/// // "2hr 19min"
///
/// // Spell Out
/// movie.runtime.formatted(.runtime(style: .spellOut, displayUnit: .hourMinute))
/// // "two hours, nineteen minutes"
/// ```
///
/// ### Locale
///
/// Pass a specific `Locale` to control localization:
///
/// ```swift
/// movie.runtime.formatted(.runtime(style: .wide, displayUnit: .hourMinute, locale: Locale(identifier: "fr_FR")))
/// // "2 heures et 19 minutes"
/// ```
///
public struct Runtime: FormatStyle {
    public typealias FormatInput = Measurement<UnitDuration>
    public typealias FormatOutput = String

    /// Controls which duration units are included in the formatted output.
    public enum DisplayUnit: Codable {
        /// Displays the runtime as hours and minutes.
        ///
        /// For runtimes under one hour, the hours unit is omitted automatically.
        ///
        /// ```swift
        /// // 139 minutes → "2 hr, 19 min"
        /// // 45 minutes  → "45 min"
        /// ```
        case hourMinute
        /// Displays the runtime in minutes only, regardless of duration.
        ///
        /// ```swift
        /// // 139 minutes → "139 min"
        /// // 45 minutes  → "45 min"
        /// ```
        case minutesOnly
    }

    /// The formatting style applied to each duration component (e.g., `.abbreviated`, `.wide`, `.narrow`).
    let style: Date.ComponentsFormatStyle.Style
    /// The units to include in the formatted output.
    let displayUnit: DisplayUnit
    /// The locale used for localization. Defaults to `.autoupdatingCurrent`.
    let locale: Locale

    /// Creates a new runtime format style.
    /// - Parameters:
    ///   - style: The component formatting style (e.g., `.abbreviated` for "hr, min", `.wide` for "hours, minutes").
    ///   - displayUnit: Whether to show hours and minutes or minutes only.
    ///   - locale: The locale for localization. Defaults to `.autoupdatingCurrent`.
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
    /// A convenience format style that displays runtimes in abbreviated minutes.
    ///
    /// Equivalent to `.runtime(style: .abbreviated, displayUnit: .minutesOnly)`.
    ///
    /// ```swift
    /// movie.runtime.formatted(.runtime)
    /// // "139 min"
    /// ```
    static var runtime: Runtime {
        runtime(style: .abbreviated, displayUnit: .minutesOnly)
    }

    /// Creates a runtime format style with the specified options.
    ///
    /// ```swift
    /// movie.runtime.formatted(.runtime(style: .wide, displayUnit: .hourMinute))
    /// // "2 hours, 19 minutes"
    /// ```
    ///
    /// - Parameters:
    ///   - style: The component formatting style (e.g., `.abbreviated`, `.wide`, `.narrow`).
    ///   - displayUnit: Whether to show hours and minutes or minutes only.
    ///   - locale: The locale for localization. Defaults to `.autoupdatingCurrent`.
    /// - Returns: A configured ``Runtime`` format style.
    static func runtime(
        style: Date.ComponentsFormatStyle.Style,
        displayUnit: Runtime.DisplayUnit,
        locale: Locale = .autoupdatingCurrent,
    ) -> Runtime {
        Runtime(style: style, displayUnit: displayUnit, locale: locale)
    }
}

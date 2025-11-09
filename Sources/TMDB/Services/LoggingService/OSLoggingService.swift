import Foundation
import OSLog
internal import Dependencies

enum OSLoggingService {
    static let logger = Logger(subsystem: "com.tmdbswifty", category: "TMDBSDK")
    static func log(
        level: TMDB.LoggingLevel,
        message: String,
        file: String,
        function: String,
        line: Int,
    ) {
        Task {
            do {
                let configuration = try await Dependency(\.sdkConfigurationStore).wrappedValue.configuration()
                guard level >= configuration.minimumLoggingLevel else {
                    return
                }
                let filename = URL(fileURLWithPath: file).deletingLastPathComponent().lastPathComponent
                switch level {
                // swiftformat:disable wrapArguments wrap
                // swiftlint:disable line_length
                case .critical:
                    logger.critical("\(filename, privacy: .public)[\(line, privacy: .public)]: \(function, privacy: .public) - \(message, privacy: .auto)")
                case .debug:
                    logger.debug("\(filename, privacy: .public)[\(line, privacy: .public)]: \(function, privacy: .public) - \(message, privacy: .auto)")
                case .error:
                    logger.error("\(filename, privacy: .public)[\(line, privacy: .public)]: \(function, privacy: .public) - \(message, privacy: .auto)")
                case .info:
                    logger.info("\(filename, privacy: .public)[\(line, privacy: .public)]: \(function, privacy: .public) - \(message, privacy: .auto)")
                case .notice:
                    logger.notice("\(filename, privacy: .public)[\(line, privacy: .public)]: \(function, privacy: .public) - \(message, privacy: .auto)")
                case .warning:
                    logger.warning("\(filename, privacy: .public)[\(line, privacy: .public)]: \(function, privacy: .public) - \(message, privacy: .auto)")
                }
                // swiftformat:enable wrapArguments wrap
                // swiftlint:enable line_length
            } catch {
                assertionFailure("Failed to create OSLoggingService")
            }
        }
    }
}

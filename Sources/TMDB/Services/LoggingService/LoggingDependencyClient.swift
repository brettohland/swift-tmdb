internal import Dependencies
internal import DependenciesMacros
import Foundation

extension TMDB {
    @DependencyClient
    struct LoggingService: Sendable {
        var log: @Sendable (
            _ level: TMDB.LoggingLevel,
            _ message: String,
            _ file: String,
            _ function: String,
            _ line: Int,
        ) -> Void
    }
}

extension TMDB.LoggingService {
    func debug(_ message: String, file: String = #file, function: String = #function, line: Int = #line) {
        log(level: .debug, message: message, file: file, function: function, line: line)
    }

    func info(_ message: String, file: String = #file, function: String = #function, line: Int = #line) {
        log(level: .debug, message: message, file: file, function: function, line: line)
    }

    func notice(_ message: String, file: String = #file, function: String = #function, line: Int = #line) {
        log(level: .debug, message: message, file: file, function: function, line: line)
    }

    func warn(_ message: String, file: String = #file, function: String = #function, line: Int = #line) {
        log(level: .debug, message: message, file: file, function: function, line: line)
    }

    func error(_ message: String, file: String = #file, function: String = #function, line: Int = #line) {
        log(level: .debug, message: message, file: file, function: function, line: line)
    }

    func critical(_ message: String, file: String = #file, function: String = #function, line: Int = #line) {
        log(level: .debug, message: message, file: file, function: function, line: line)
    }
}

// MARK: - Error Logging

extension TMDB.LoggingService {

    func log(level: TMDB.LoggingLevel, message: String, error: any Error, file: String, function: String, line: Int) {
        let errorMessage = error is LocalizedError ? error.localizedDescription : "\(self)"
        let finalMessage = """
        \(message)

        Error: \(errorMessage)
        """
        log(level: level, message: finalMessage, file: file, function: function, line: line)
    }

    func debug(
        _ message: String,
        error: any Error,
        file: String = #file,
        function: String = #function,
        line: Int = #line,
    ) {
        log(level: .debug, message: message, error: error, file: file, function: function, line: line)
    }

    func info(
        _ message: String,
        error: any Error,
        file: String = #file,
        function: String = #function,
        line: Int = #line,
    ) {
        log(level: .info, message: message, error: error, file: file, function: function, line: line)
    }

    func notice(
        _ message: String,
        error: any Error,
        file: String = #file,
        function: String = #function,
        line: Int = #line,
    ) {
        log(level: .notice, message: message, error: error, file: file, function: function, line: line)
    }

    func warn(
        _ message: String,
        error: any Error,
        file: String = #file,
        function: String = #function,
        line: Int = #line,
    ) {
        log(level: .warning, message: message, error: error, file: file, function: function, line: line)
    }

    func error(
        _ message: String,
        error: any Error,
        file: String = #file,
        function: String = #function,
        line: Int = #line,
    ) {
        log(level: .error, message: message, error: error, file: file, function: function, line: line)
    }

    func critical(
        _ message: String,
        error: any Error,
        file: String = #file,
        function: String = #function,
        line: Int = #line,
    ) {
        log(level: .critical, message: message, error: error, file: file, function: function, line: line)
    }
}

extension DependencyValues {
    var logger: TMDB.LoggingService {
        get { self[TMDB.LoggingService.self] }
        set { self[TMDB.LoggingService.self] = newValue }
    }
}

extension TMDB.LoggingService: DependencyKey {
    static var liveValue: TMDB.LoggingService {
        TMDB.LoggingService { level, message, file, function, line in
            // OSLoggingService sends logs into OSLog
            OSLoggingService.log(level: level, message: message, file: file, function: function, line: line)
        }
    }
}

extension TMDB.LoggingService: TestDependencyKey {
    static var testValue: TMDB.LoggingService {
        TMDB.LoggingService { _, _, _, _, _ in
            // We no-op so that no logs are thrown during testing
        }
    }

    static var previewValue: TMDB.LoggingService {
        TMDB.LoggingService { level, message, file, function, line in
            // Preview logging service only sends logs to the console
            PreviewLoggingService.log(level: level, message: message, file: file, function: function, line: line)
        }
    }
}

public extension TMDB {
    enum LoggingLevel: Int, Sendable, Comparable, Equatable {
        case debug = 0
        case info
        case notice
        case warning
        case error
        case critical

        public static func < (lhs: TMDB.LoggingLevel, rhs: TMDB.LoggingLevel) -> Bool {
            lhs.rawValue < rhs.rawValue
        }
    }
}

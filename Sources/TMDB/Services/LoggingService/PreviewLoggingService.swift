internal import Dependencies
import Foundation

enum PreviewLoggingService {
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
                guard
                    ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1",
                    level >= configuration.minimumLoggingLevel
                else {
                    return
                }
                let filename = URL(fileURLWithPath: file).deletingLastPathComponent().lastPathComponent
                let message = "\(level.logString.uppercased()): [\(filename):\(line)] \(function): \(message)"
                print(message)
            } catch {
                assertionFailure("Unable to create preview logger")
            }
        }
    }
}

extension TMDB.LoggingLevel {
    var logString: String {
        switch self {
        case .critical:
            "critical"
        case .debug:
            "debug"
        case .error:
            "error"
        case .info:
            "info"
        case .notice:
            "notice"
        case .warning:
            "warn"
        }
    }
}

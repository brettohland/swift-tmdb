import Foundation

package extension TMDB {
    nonisolated(unsafe) static var mockDataHandler: (@Sendable (URLRequest) throws -> Data)?
}

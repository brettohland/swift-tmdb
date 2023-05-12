import Foundation

/// Represents an HTTP client which handles fetching `Data` from a `URLRequest`
public protocol HTTPClient {
    @discardableResult
    func data(for request: URLRequest) async throws -> Data
}

import Foundation

public struct FileMockHTTPClient: HTTPClient {
    let fileURL: URL
    let responseDelay: TimeInterval

    public init(fileURL: URL, responseDelay: TimeInterval = 0.0) {
        self.fileURL = fileURL
        self.responseDelay = responseDelay
    }

    public func data(for request: URLRequest) async throws -> Data {
        try await Task.sleep(nanoseconds: UInt64(responseDelay * Double(NSEC_PER_SEC)))
        return try Data(contentsOf: fileURL)
    }
}

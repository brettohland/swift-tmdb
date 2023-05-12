import Foundation

public struct InMemoryMockHTTPClient: HTTPClient {
    let data: Data
    let responseDelay: TimeInterval

    public init(mockedData: Data, responseDelay: TimeInterval = 0.0) {
        data = mockedData
        self.responseDelay = responseDelay
    }

    public func data(for request: URLRequest) async throws -> Data {
        try await Task.sleep(nanoseconds: UInt64(responseDelay * Double(NSEC_PER_SEC)))
        return data
    }
}

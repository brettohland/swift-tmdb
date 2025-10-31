import Dependencies
import DependenciesMacros
import Foundation
import Utilities

public extension HTTP {
    @DependencyClient
    struct Client: Sendable {
        public var data: @Sendable (_ request: URLRequest, _ configuration: URLSessionConfiguration?) async throws -> Data
    }
}

extension HTTP.Client: DependencyKey {
    public static var liveValue: Self {
        Self { request, sessionConfiguration in
            let urlSession = URLSession(configuration: sessionConfiguration ?? .default)
            let (data, response) = try await urlSession.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse else {
                throw HTTP.Client.Error.invalidResponseFromServer(response, data)
            }
            switch  httpResponse.responseStatus.category {
            case .informational,
                 .redirection,
                 .success:
                return data
            case .clientError:
                throw HTTP.Client.Error.clientError(httpResponse, data)
            case .serverError:
                throw HTTP.Client.Error.serverError(httpResponse, data)
            }
        }
    }
}

public extension DependencyValues {
    var httpClient: HTTP.Client {
        get { self[HTTP.Client.self] }
        set { self[HTTP.Client.self] = newValue }
    }
}

// MARK: - Test/Preview Mocks

extension HTTP.Client: TestDependencyKey {
    public static let testValue =  Self()
}

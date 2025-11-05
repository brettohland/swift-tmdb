import Dependencies
import DependenciesMacros
import Foundation
import RequestService

public extension TMDB.Client {
    @DependencyClient
    struct HTTPClient: Sendable {
        public var data: @Sendable (_ request: URLRequest, _ configuration: URLSessionConfiguration?) async throws
            -> Data
    }
}

extension TMDB.Client.HTTPClient: DependencyKey {
    public static var liveValue: Self {
        Self { request, sessionConfiguration in
            let urlSession = URLSession(configuration: sessionConfiguration ?? .default)
            let (data, response) = try await urlSession.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse else {
                throw TMDBClientError.invalidResponseFromServer(response, data)
            }
            switch httpResponse.responseStatus.category {
            case .informational,
                 .redirection,
                 .success:
                return data
            case .clientError:
                throw TMDBClientError.clientError(httpResponse, data)
            case .serverError:
                throw TMDBClientError.serverError(httpResponse, data)
            }
        }
    }
}

public extension DependencyValues {
    var httpClient: TMDB.Client.HTTPClient {
        get { self[TMDB.Client.HTTPClient.self] }
        set { self[TMDB.Client.HTTPClient.self] = newValue }
    }
}

// MARK: - Test/Preview Mocks

extension TMDB.Client.HTTPClient: TestDependencyKey {
    public static var testValue: Self {
        Self { _, _ in
            Data()
        }
    }

    public static let previewValue = Self()
}

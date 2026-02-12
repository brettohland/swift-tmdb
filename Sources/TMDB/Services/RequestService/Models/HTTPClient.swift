internal import Dependencies
internal import DependenciesMacros
import Foundation

extension TMDB {
    @DependencyClient
    struct HTTPClient: Sendable {
        var data: @Sendable (
            _ request: URLRequest,
            _ configuration: URLSessionConfiguration,
        ) async throws -> Data
    }
}

extension TMDB.HTTPClient: DependencyKey {
    static var liveValue: Self {
        TMDB.HTTPClient { request, sessionConfiguration in
            let logger = Dependency(\.logger).wrappedValue
            let urlSession = URLSession(configuration: sessionConfiguration)
            let (data, response) = try await urlSession.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse else {
                throw TMDBRequestError.networkError(.invalidResponseFromServer(response, data))
            }
            switch httpResponse.responseStatus.category {
            case .informational,
                 .redirection,
                 .success:
                return data
            case .clientError:
                let error = TMDBRequestError.networkError(.clientError(httpResponse, data))
                logger.error("URLRequest failure", error: error)
                throw error
            case .serverError:
                let error = TMDBRequestError.networkError(.serverError(httpResponse, data))
                logger.error("URLRequest failure", error: error)
                throw error
            }
        }
    }
}

extension DependencyValues {
    var httpClient: TMDB.HTTPClient {
        get { self[TMDB.HTTPClient.self] }
        set { self[TMDB.HTTPClient.self] = newValue }
    }
}

// MARK: - Test/Preview Mocks

extension TMDB.HTTPClient: TestDependencyKey {

    static var logger: TMDB.LoggingService {
        Dependency(\.logger).wrappedValue
    }

    static var testValue: TMDB.HTTPClient {
        TMDB.HTTPClient { request, _ throws in
            guard let handler = TMDB.mockDataHandler else {
                logger.notice(
                    "TMDB mock data handler not registered. Call TMDBMockData.register() before running tests.",
                )
                return Data()
            }
            return try handler(request)
        }
    }

    static var previewValue: TMDB.HTTPClient {
        TMDB.HTTPClient { request, _ throws in
            guard let handler = TMDB.mockDataHandler else {
                logger.notice(
                    "TMDB mock data handler not registered. Call TMDBMockData.register() before using previews.",
                )
                return Data()
            }
            try await Task.sleep(for: .seconds(2))
            return try handler(request)
        }
    }
}

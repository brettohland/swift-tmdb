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
                throw TMDBRequestError.networkError(.clientError(httpResponse, data))
            case .serverError:
                throw TMDBRequestError.networkError(.serverError(httpResponse, data))
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
    static var testValue: TMDB.HTTPClient {
        TMDB.HTTPClient { request, _ throws in
            try PathMatchingService.dataFromURLRequest(request)
        }
    }

    static var previewValue: TMDB.HTTPClient {
        TMDB.HTTPClient { request, _ throws in
            try PathMatchingService.dataFromURLRequest(request)
        }
    }
}

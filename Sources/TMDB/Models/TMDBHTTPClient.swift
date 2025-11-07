import Dependencies
import DependenciesMacros
import Foundation

extension TMDB {
    @DependencyClient
    struct HTTPClient: Sendable {
        var data: @Sendable (_ request: URLRequest, _ configuration: URLSessionConfiguration?) async throws
            -> Data
    }
}

extension TMDB.HTTPClient: DependencyKey {
    static var liveValue: Self {
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

extension DependencyValues {
    var httpClient: TMDB.HTTPClient {
        get { self[TMDB.HTTPClient.self] }
        set { self[TMDB.HTTPClient.self] = newValue }
    }
}

// MARK: - Test/Preview Mocks

extension TMDB.HTTPClient: TestDependencyKey {
    static var testValue: Self {
        Self { request, _ in
            try PathMatchingService.dataFromURLRequest(request)
        }
    }

    static var previewValue: Self {
        Self { request, _ in
            try PathMatchingService.dataFromURLRequest(request)
        }
    }
}

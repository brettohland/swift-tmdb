import Foundation
import RequestService
import Dependencies
import SharedModels

public extension TMDB {
    final class Client {
        enum Constants {
            static let baseURL = URL(string: "https://api.themoviedb.org")!
        }

        @MainActor private static var apiKey: String?
        @MainActor private static var isInitialized = false

        static func initialize(configuration: Configuration) async throws {
            try await checkIsInitialized()
            Task { @MainActor in
                self.apiKey = configuration.apiKey
                self.isInitialized = true
            }
        }

        static func initialize(apiKey: String) async throws {
            let configuration = Configuration(apiKey: apiKey)
            try await initialize(configuration: configuration)
        }

        @MainActor
        static func checkForAPIKey() async throws {
            guard
                let apiKey,
                apiKey.isEmpty == false
            else {
                throw TMDBError.apiKeyMissing
            }
        }

        @MainActor
        static func checkIsInitialized() async throws {
            guard  isInitialized else {
                throw TMDBError.alreadyInitialized
            }
        }

    }
}

enum TMDBError: Error {
    case alreadyInitialized
    case apiKeyMissing
}

extension TMDB.Client {
    struct Configuration: Sendable {
        let apiKey: String
    }
}







extension TMDBInternal.V3Endpoints.Movies: DynamicV3Endpoint {
    public func makeFinalURL(baseURL: URL) -> URL {
        var paths: [any StringProtocol] = ["3","movie"]
        switch self {
        case .details(let id):
            paths.append(String(id))
        case .alternativeTitles(let id):
            paths += [String(id), "alternative_titles"]
        }
        return URLFactory.makeURL(baseURL: baseURL, appending: paths)
    }
}

extension TMDB.Client {

    enum Movie {
        static func details(id: Int) async throws -> TMDBInternal.Movie.Details {
            let endpoint = TMDBEndpoint<HTTP.EmptyRequestBody, TMDBInternal.Movie.Details>(
                baseURL: TMDB.Client.Constants.baseURL,
                endpoint: TMDBInternal.V3Endpoints.Movies.details(id: id),
                httpMethod: .get
            )
            return try await endpoint.decodedResponse()
        }

        static func alternativeTitles(id: Int) async throws -> TMDBInternal.Movie.AlternativeTitle {
            let endpoint = TMDBEndpoint<HTTP.EmptyRequestBody, TMDBInternal.Movie.AlternativeTitle>(
                baseURL: TMDB.Client.Constants.baseURL,
                endpoint: TMDBInternal.V3Endpoints.Movies.alternativeTitles(id: id),
                httpMethod: .get
            )
            return try await endpoint.decodedResponse()
        }
    }
}


struct TMDBEndpoint<RequestBody: Encodable, ResponseBody: Decodable> {
    let baseURL: URL
    let endpoint: DynamicV3Endpoint
    let httpMethod: HTTP.Method
    let sessionConfiguration: URLSessionConfiguration
    let encoder: JSONEncoder
    let decoder: JSONDecoder

    init(
        baseURL: URL,
        endpoint: DynamicV3Endpoint,
        httpMethod: HTTP.Method,
        sessionConfiguration: URLSessionConfiguration = .default,
        encoder: JSONEncoder = .iso8601SnakeCake,
        decoder: JSONDecoder = .iso8601SnakeCake
    ) {
        self.baseURL = baseURL
        self.endpoint = endpoint
        self.httpMethod = httpMethod
        self.sessionConfiguration = sessionConfiguration
        self.encoder = encoder
        self.decoder = decoder
    }

    func data(forRequest request: URLRequest) async throws -> Data {
        try await Dependency(\.httpClient).wrappedValue.data(request: request, configuration: sessionConfiguration)
    }

    func decodedResponse(forRequest request: URLRequest) async throws -> ResponseBody {
        let data = try await data(forRequest: request)
        return try decoder.decode(ResponseBody.self, from: data)
    }

    func decodedResponse() async throws -> ResponseBody {
        let finalURL = endpoint.makeFinalURL(baseURL: baseURL)
        var request = URLRequest(url: finalURL)
        request.httpMethod = httpMethod.rawValue
        return try await decodedResponse(forRequest: request)
    }
}

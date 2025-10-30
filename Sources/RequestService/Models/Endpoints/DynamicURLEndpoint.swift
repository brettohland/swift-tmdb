import Dependencies
import Foundation

public extension HTTP {
    struct DynamicURLEndpoint<RequestBody: Encodable, ResponseBody: Decodable>: HTTPEndpoint {
        public let baseURL: URL
        public let encoder: JSONEncoder
        public let method: HTTP.Method
        public let path: String
        public let sessionConfiguration: URLSessionConfiguration
        public let decoder: JSONDecoder

        public init(
            baseURL: URL,
            method: HTTP.Method,
            sessionConfiguration: URLSessionConfiguration = .default,
            encoder: JSONEncoder = .iso8601SnakeCake,
            decoder: JSONDecoder = .iso8601SnakeCake,
        ) {
            self.baseURL = baseURL
            self.sessionConfiguration = sessionConfiguration
            path = ""
            self.method = method
            self.encoder = encoder
            self.decoder = decoder
        }
    }
}

public extension HTTP.DynamicURLEndpoint {
    /// Factory method to create a ``URLRequest`` instance.
    /// - Parameters:
    ///   - pathComponent: A `String` path component to append to the URL.
    ///   - queryItems: An array of ``URLQueryItem`` values to include in the URL
    ///   - httpBody: The `Encodable` body to add to the URLRequest's httpBody
    /// - Returns: A ``URLRequest``.
    func makeURLRequest(
        _ httpBody: RequestBody,
        queryItems: [URLQueryItem] = [],
        urlComponentBuilder: @escaping (URLComponents) -> URLComponents,
    ) throws -> URLRequest {
        guard method != .get else {
            throw HTTP.Error.noBodyForGetRequest
        }
        let url = try makeURL(queryItems: queryItems)
        let finalURL = try convert(url: url, usingComponentBuilder: urlComponentBuilder)
        var request = URLRequest(url: finalURL)
        request.httpMethod = method.rawValue
        if type(of: httpBody) != HTTP.EmptyRequestBody.self {
            request.httpBody = try encoder.encode(httpBody)
        }
        return request
    }

    /// Factory method to create a ``URLRequest`` instance without an httpBody parameter
    /// - Parameters:
    ///   - pathComponent: A `String` path component to append to the URL.
    ///   - queryItems: An array of `URLQueryItem` values to include in the URL.
    /// - Returns: A ``URLRequest``.
    func makeURLRequest(
        queryItems: [URLQueryItem] = [],
        urlComponentBuilder: @escaping (URLComponents) -> URLComponents,
    ) throws -> URLRequest {
        let url = try makeURL(queryItems: queryItems)
        let finalURL = try convert(url: url, usingComponentBuilder: urlComponentBuilder)
        var request = URLRequest(url: finalURL)
        request.httpMethod = method.rawValue
        return request
    }
}

private extension HTTP.DynamicURLEndpoint {
    func convert(url: URL, usingComponentBuilder builder: (URLComponents) -> URLComponents) throws -> URL {
        guard let currentURLComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            throw URLError(.badURL)
        }
        guard let finalURL = builder(currentURLComponents).url else {
            throw URLError(.badURL)
        }
        return finalURL
    }
}

import Foundation

public protocol HTTPEndpoint {
    associatedtype RequestBody: Encodable
    associatedtype ResponseBody: Decodable
    var httpConfiguration: HTTPConfiguration { get }
    var path: String { get }
    var method: HTTP.Method { get }
    var encoder: JSONEncoder { get }
    var decoder: JSONDecoder { get }
}

// MARK: = Internal Factories

extension HTTPEndpoint {
    /// Builds the URL based on the HTTP Configuration, the current endpoint's parameters, and the provided query items.
    /// - Parameter queryItems: An array of `URLQueryItem` values.
    /// - Returns: The build ``URL``
    /// - Throws: A ``HTTP.URLBuilderError`` with the details of the failure.
    func makeURL(queryItems: [URLQueryItem]) throws -> URL {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = httpConfiguration.host
        urlComponents.path = path.normalizePathComponent()
        urlComponents.queryItems = queryItems.isEmpty ? nil : queryItems
        guard let url = urlComponents.url else {
            throw URLError(.badURL)
        }
        return url
    }
}

// MARK: - URLRequest Factories

public extension HTTPEndpoint {
    /// Factory method to create a ``URLRequest`` instance.
    /// - Parameters:
    ///   - queryItems: An array of ``URLQueryItem`` values to include in the URL
    ///   - httpBody: The `Encodable` body to add to the URLRequest's httpBody
    /// - Returns: A ``URLRequest``.
    func makeURLRequest(_ httpBody: RequestBody, queryItems: [URLQueryItem] = []) throws -> URLRequest {
        guard method != .get else {
            throw HTTP.Error.noBodyForGetRequest
        }
        let url = try makeURL(queryItems: queryItems)
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        if type(of: httpBody) != HTTP.EmptyRequestBody.self {
            request.httpBody = try encoder.encode(httpBody)
        }
        return request
    }

    /// Factory method to create a ``URLRequest`` instance without an httpBody parameter
    /// - Parameter queryItems: An array of `URLQueryItem` values to include in the URL.
    /// - Returns: A ``URLRequest``.
    func makeURLRequest(queryItems: [URLQueryItem] = []) throws -> URLRequest {
        let url = try makeURL(queryItems: queryItems)
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        return request
    }
}

// MARK: - HTTPClient calls

public extension HTTPEndpoint {
    /// Fetches and decodes the response from the endpoint using the HTTP Configuration's HTTP Client.
    /// - Parameters:
    ///   - request: A ``URLRequest`` to use in the request
    /// - Returns: The decoded associated ResponseType that was in the response body.
    /// - Throws: ``HTTP.Client.Error``
    func responseObject(from request: URLRequest) async throws -> ResponseBody {
        let data = try await httpConfiguration.client.data(for: request)
        return try decoder.decode(ResponseBody.self, from: data)
    }

    /// Initiates the given ``URLRequest`` using the HTTP Configuration's HTTP Client.
    /// - Parameter request: The ``URLRequest`` to use in the request
    func response(from request: URLRequest) async throws {
        try await httpConfiguration.client.data(for: request)
    }
}

// MARK: - Combination URLResponse Factory & Response Decoding

public extension HTTPEndpoint {
    /// Initiate an HTTP Request with the given body and query items, the response from the server is decoded.
    /// - Parameters:
    ///   - body: The `Encodable` body to add to the request.
    ///   - queryItems: An array of `URLQueryItem` values to encode into the URL.
    /// - Returns: The http body of the response, decoded.
    func requestDecodingResponse(
        withHTTPBody body: RequestBody,
        andQueryItems queryItems: [URLQueryItem] = []
    ) async throws -> ResponseBody {
        guard method != .get else {
            throw HTTP.Error.noBodyForGetRequest
        }
        let request = try makeURLRequest(body, queryItems: queryItems)
        return try await responseObject(from: request)
    }

    /// Initiate an HTTP Request with the given body and query items, the response from the server is decoded.
    /// - Parameters:
    ///   - queryItems: An array of `URLQueryItem` values to encode into the URL.
    /// - Returns: The http body of the response, decoded.
    func requestDecodingResponse(withQueryItems queryItems: [URLQueryItem] = []) async throws -> ResponseBody {
        let request = try makeURLRequest(queryItems: queryItems)
        return try await responseObject(from: request)
    }

    /// Initiate an HTTP Request with the given body and query items, the response from the server is decoded.
    /// - Parameters:
    ///   - body: The `Encodable` body to add to the request.
    ///   - queryItems: An array of `URLQueryItem` values to encode into the URL.
    func request(
        withHTTPBody body: RequestBody,
        andQueryItems queryItems: [URLQueryItem] = []
    ) async throws {
        let request = try makeURLRequest(body, queryItems: queryItems)
        return try await response(from: request)
    }

    /// Initiate an HTTP Request with the given body and query items, the response from the server is decoded.
    /// - Parameters:
    ///   - queryItems: An array of `URLQueryItem` values to encode into the URL.
    /// - Returns: The http body of the response, decoded.
    func request(withQueryItems queryItems: [URLQueryItem] = []) async throws {
        let request = try makeURLRequest(queryItems: queryItems)
        try await response(from: request)
    }
}

// MARK: - Private Utility Methods

private extension String {
    static var slashCharacterSet: CharacterSet {
        .init(charactersIn: "/")
    }

    /// Normalizes a string for use as a `path` component for use on a `URLComponent` instance.
    /// - Returns: A ``String`` path component with a leading `/` character, but no trailing `/` character.
    func normalizePathComponent() -> String {
        "/" + trimmingCharacters(in: Self.slashCharacterSet)
    }
}

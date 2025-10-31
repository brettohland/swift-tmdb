import Foundation
import Dependencies

public protocol HTTPEndpoint {
    associatedtype RequestBody: Any
    associatedtype ResponseBody: Any
    var sessionConfiguration: URLSessionConfiguration { get }
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTP.Method { get }
    var encoder: JSONEncoder { get }
    var decoder: JSONDecoder { get }
}

// MARK: - Public Factories

// MARK: URLRequest Factory (No Body)

public extension HTTPEndpoint where RequestBody == Void {
    func makeURLRequest(queryItems: [URLQueryItem] = []) throws -> URLRequest {
        try URLRequestFactory.makeURLRequest(
            baseURL: baseURL,
            method: method,
            appending: [path],
            queryItems: queryItems
        )
    }

    func makeURLRequest(appending path: some StringProtocol, queryItems: [URLQueryItem] = []) throws -> URLRequest {
        try URLRequestFactory.makeURLRequest(
            baseURL: baseURL,
            method: method,
            appending: [self.path, path],
            queryItems: queryItems
        )
    }

    func makeURLRequest<Path>(
        appending paths: Path...,
        queryItems: [URLQueryItem] = []
    ) throws -> URLRequest where Path: StringProtocol {
        try URLRequestFactory.makeURLRequest(
            baseURL: baseURL,
            method: method,
            appending: [path] + paths,
            queryItems: queryItems
        )
    }
}

// MARK: URLRequest Factory (Encodable Body)

public extension HTTPEndpoint where RequestBody: Encodable {
    func makeURLRequest(queryItems: [URLQueryItem] = [], httpBody: RequestBody? = nil) throws -> URLRequest {
        try URLRequestFactory.makeURLRequest(
            baseURL: baseURL,
            method: method,
            appending: [path],
            queryItems: queryItems,
            httpBody: httpBody,
            jsonEncoder: encoder
        )
    }

    func makeURLRequest(
        appending path: some StringProtocol,
        queryItems: [URLQueryItem] = [],
        httpBody: RequestBody? = nil
    ) throws -> URLRequest {
        try URLRequestFactory.makeURLRequest(
            baseURL: baseURL,
            method: method,
            appending: [self.path, path],
            queryItems: queryItems,
            httpBody: httpBody,
            jsonEncoder: encoder
        )
    }

    func makeURLRequest<Path>(
        appending paths: Path...,
        queryItems: [URLQueryItem] = [],
        httpBody: RequestBody? = nil
    ) throws -> URLRequest where Path: StringProtocol {
        try URLRequestFactory.makeURLRequest(
            baseURL: baseURL,
            method: method,
            appending: [path] + paths,
            queryItems: queryItems,
            httpBody: httpBody,
            jsonEncoder: encoder
        )
    }
}

// MARK: - Data Request

public extension HTTPEndpoint {
    @discardableResult
    func data(fromURLRequest request: URLRequest) async throws -> Data {
        try await Dependency(\.httpClient).wrappedValue.data(request: request, configuration: sessionConfiguration)
    }
}

// MARK: - Request (No Body, No Response)

public extension HTTPEndpoint where RequestBody == Void, ResponseBody == Void {
    func performRequest(queryItems: [URLQueryItem] = []) async throws {
        let request = try makeURLRequest(queryItems: queryItems)
        try await data(fromURLRequest: request)
    }

    func performRequest(appending path: some StringProtocol, queryItems: [URLQueryItem] = []) async throws {
        let request = try URLRequestFactory.makeURLRequest(
            baseURL: baseURL,
            method: method,
            appending: [self.path, path],
            queryItems: queryItems
        )
        try await data(fromURLRequest: request)
    }

    func performRequest<Path>(
        appending paths: Path...,
        queryItems: [URLQueryItem] = []
    ) async throws where Path: StringProtocol {
        let request = try URLRequestFactory.makeURLRequest(
            baseURL: baseURL,
            method: method,
            appending: [path] + paths,
            queryItems: queryItems
        )
        try await data(fromURLRequest: request)
    }
}

// MARK: - Request (Encodable Body, No Response)

public extension HTTPEndpoint where RequestBody: Encodable, ResponseBody == Void {
    func performRequest(queryItems: [URLQueryItem] = [], httpBody: RequestBody? = nil) async throws {
        let request = try makeURLRequest(queryItems: queryItems, httpBody: httpBody)
        try await data(fromURLRequest: request)
    }

    func performRequest(
        appending path: some StringProtocol,
        queryItems: [URLQueryItem] = [],
        httpBody: RequestBody? = nil
    ) async throws {
        let request = try URLRequestFactory.makeURLRequest(
            baseURL: baseURL,
            method: method,
            appending: [self.path, path],
            queryItems: queryItems,
            httpBody: httpBody,
            jsonEncoder: encoder
        )
        try await data(fromURLRequest: request)
    }

    func performRequest<Path>(
        appending paths: Path...,
        queryItems: [URLQueryItem] = [],
        httpBody: RequestBody? = nil
    ) async throws where Path: StringProtocol {
        let request = try URLRequestFactory.makeURLRequest(
            baseURL: baseURL,
            method: method,
            appending: [path] + paths,
            queryItems: queryItems,
            httpBody: httpBody,
            jsonEncoder: encoder
        )
        try await data(fromURLRequest: request)
    }
}

// MARK: - Response (No Response)

public extension HTTPEndpoint where ResponseBody == Void {
    func performRequest(_ request: URLRequest) async throws {
        try await data(fromURLRequest: request)
    }
}

// MARK: - Response (Data Response)

public extension HTTPEndpoint where ResponseBody == Data {
    func performRequest(_ request: URLRequest) async throws -> ResponseBody {
        try await data(fromURLRequest: request)
    }
}

public extension HTTPEndpoint where RequestBody == Void, ResponseBody == Data {
    func performRequest(queryItems: [URLQueryItem] = []) async throws -> ResponseBody {
        let request = try makeURLRequest(queryItems: queryItems)
        return try await performRequest(request)
    }
}

// MARK: - Response (Request Decodable)

public extension HTTPEndpoint where ResponseBody: Decodable {
    func performRequest(_ request: URLRequest) async throws -> ResponseBody {
        let data = try await data(fromURLRequest: request)
        return try decoder.decode(ResponseBody.self, from: data)
    }
}

// MARK: - Response (No Body, Decodable Response)

public extension HTTPEndpoint where RequestBody == Void, ResponseBody: Decodable {
    func performRequest(queryItems: [URLQueryItem] = []) async throws -> ResponseBody {
        let request = try makeURLRequest(queryItems: queryItems)
        return try await performRequest(request)
    }

    func performRequest(
        appending path: some StringProtocol,
        queryItems: [URLQueryItem] = []
    ) async throws -> ResponseBody {
        let request = try URLRequestFactory.makeURLRequest(
            baseURL: baseURL,
            method: method,
            appending: [self.path, path],
            queryItems: queryItems
        )
        return try await performRequest(request)
    }

    func performRequest<Path>(
        appending paths: Path...,
        queryItems: [URLQueryItem] = []
    ) async throws -> ResponseBody where Path: StringProtocol {
        let request = try URLRequestFactory.makeURLRequest(
            baseURL: baseURL,
            method: method,
            appending: [path] + paths,
            queryItems: queryItems
        )
        return try await performRequest(request)
    }
}

// MARK: - Response (Encodable Body, Decodable Response)

public extension HTTPEndpoint where RequestBody: Encodable, ResponseBody: Decodable {
    func performRequest(queryItems: [URLQueryItem] = [], httpBody: RequestBody? = nil) async throws -> ResponseBody {
        let request = try makeURLRequest(queryItems: queryItems, httpBody: httpBody)
        return try await performRequest(request)
    }

    func performRequest(
        appending path: some StringProtocol,
        queryItems: [URLQueryItem] = [],
        httpBody: RequestBody? = nil
    ) async throws -> ResponseBody {
        let request = try URLRequestFactory.makeURLRequest(
            baseURL: baseURL,
            method: method,
            appending: [self.path, path],
            queryItems: queryItems,
            httpBody: httpBody,
            jsonEncoder: encoder
        )
        return try await performRequest(request)
    }

    func performRequest<Path>(
        appending paths: Path...,
        queryItems: [URLQueryItem] = [],
        httpBody: RequestBody? = nil
    ) async throws -> ResponseBody where Path: StringProtocol {
        let request = try URLRequestFactory.makeURLRequest(
            baseURL: baseURL,
            method: method,
            appending: [path] + paths,
            queryItems: queryItems,
            httpBody: httpBody,
            jsonEncoder: encoder
        )
        return try await performRequest(request)
    }
}

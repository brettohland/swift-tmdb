import Foundation

public enum URLRequestFactory {
    public static func makeURLRequest(
        baseURL url: URL,
        method: HTTP.Method,
        appending paths: [any StringProtocol] = [],
        queryItems: [URLQueryItem] = []
    ) throws -> URLRequest {
        let url = URLFactory.makeURL(baseURL: url, appending: paths, queryItems: queryItems)
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        return request
    }

    public static func makeURLRequest(
        baseURL url: URL,
        method: HTTP.Method,
        appending paths: [any StringProtocol] = [],
        queryItems: [URLQueryItem] = [],
        httpBody: (some Encodable)? = nil,
        jsonEncoder: JSONEncoder
    ) throws -> URLRequest {
        let url = URLFactory.makeURL(baseURL: url, appending: paths, queryItems: queryItems)
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        switch httpBody {
        case .some where method == .get:
            // GET requests with a body are against the HTTP spec.
            throw HTTP.Error.noBodyForGetRequest
        case .some(let body):
            request.httpBody = try jsonEncoder.encode(body)
        default:
            break
        }
        return request
    }
}

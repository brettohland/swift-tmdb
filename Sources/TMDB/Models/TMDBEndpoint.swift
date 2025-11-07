import Dependencies
import Foundation

struct TMDBEndpoint<RequestBody: Encodable, ResponseBody: Decodable> {
    let endpoint: EndpointFactory
    let httpMethod: HTTP.Method
    let sessionConfiguration: URLSessionConfiguration
    let encoder: JSONEncoder
    let decoder: JSONDecoder

    init(
        endpoint: EndpointFactory,
        httpMethod: HTTP.Method,
        sessionConfiguration: URLSessionConfiguration = .default,
        encoder: JSONEncoder = .iso8601SnakeCake,
        decoder: JSONDecoder = .iso8601SnakeCake,
    ) {
        self.decoder = decoder
        self.encoder = encoder
        self.endpoint = endpoint
        self.httpMethod = httpMethod
        self.sessionConfiguration = sessionConfiguration
    }

    func data(forRequest request: URLRequest) async throws -> Data {
        try await Dependency(\.httpClient).wrappedValue.data(request: request, configuration: sessionConfiguration)
    }

    func decodedResponse(forRequest request: URLRequest) async throws -> ResponseBody {
        let data = try await data(forRequest: request)
        return try decoder.decode(ResponseBody.self, from: data)
    }

    func decodedResponse() async throws -> ResponseBody {
        let baseURL = TMDB.Constants.baseURL
        let finalURL = endpoint.makeURL(baseURL: baseURL)
        var request = URLRequest(url: finalURL)
        request.httpMethod = httpMethod.rawValue
        return try await decodedResponse(forRequest: request)
    }
}

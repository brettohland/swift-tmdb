internal import Dependencies
import Foundation

struct Endpoint<RequestBody: Encodable, ResponseBody: Decodable> {
    let endpoint: EndpointFactory
    let httpMethod: HTTP.Method
    let encoder: JSONEncoder
    let decoder: JSONDecoder

    @Dependency(\.sdkConfigurationStore.configuration) private var sdkConfiguration
    @Dependency(\.httpClient) private var httpClient
    @Dependency(\.logger) private var logger

    init(
        endpoint: EndpointFactory,
        httpMethod: HTTP.Method,
        encoder: JSONEncoder = .iso8601SnakeCake,
        decoder: JSONDecoder = .iso8601SnakeCake,
    ) {
        self.decoder = decoder
        self.encoder = encoder
        self.endpoint = endpoint
        self.httpMethod = httpMethod
    }

    func data(forRequest request: URLRequest) async throws -> Data {
        let sessionConfiguration = try await sdkConfiguration().urlSessionConfiguration
        return try await httpClient.data(request: request, configuration: sessionConfiguration)
    }

    func decodedResponse(forRequest request: URLRequest) async throws -> ResponseBody {
        let apiKey = try await sdkConfiguration().apiKey
        var urlRequest = request
        urlRequest.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        let data = try await data(forRequest: urlRequest)
        let decodedData = try decoder.decode(ResponseBody.self, from: data)
        logger.debug(
            """
            Request successful:
            URL: \(urlRequest.url?.absoluteString ?? "Unknown")
            Decoded Body: \(data.prettyJSON ?? "Unknown")
            """)
        return decodedData
    }

    func decodedResponse() async throws -> ResponseBody {
        let baseURL = TMDB.Constants.baseURL
        let finalURL = endpoint.makeURL(baseURL: baseURL)
        var request = URLRequest(url: finalURL)
        request.httpMethod = httpMethod.rawValue
        return try await decodedResponse(forRequest: request)
    }
}

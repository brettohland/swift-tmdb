internal import Dependencies
import Foundation

struct Endpoint<RequestBody: Encodable, ResponseBody: Decodable> {
    let endpoint: EndpointFactory
    let httpMethod: HTTP.Method
    let requestBody: RequestBody?
    let encoder: JSONEncoder
    let decoder: JSONDecoder

    @Dependency(\.sdkConfigurationStore.configuration) private var sdkConfiguration
    @Dependency(\.httpClient) private var httpClient
    @Dependency(\.logger) private var logger

    init(
        endpoint: EndpointFactory,
        httpMethod: HTTP.Method,
        requestBody: RequestBody? = nil,
        encoder: JSONEncoder = .iso8601SnakeCake,
        decoder: JSONDecoder = .iso8601SnakeCake,
    ) {
        self.decoder = decoder
        self.encoder = encoder
        self.endpoint = endpoint
        self.httpMethod = httpMethod
        self.requestBody = requestBody
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
        var finalURL = endpoint.makeURL(baseURL: baseURL)
        let configuration = try await sdkConfiguration()
        finalURL = applyDefaults(to: finalURL, from: configuration)
        var request = URLRequest(url: finalURL)
        request.httpMethod = httpMethod.rawValue
        if let requestBody, !(requestBody is HTTP.EmptyRequestBody) {
            request.httpBody = try encoder.encode(requestBody)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        return try await decodedResponse(forRequest: request)
    }

    private func applyDefaults(to url: URL, from configuration: TMDBConfiguration) -> URL {
        guard endpoint.supportsLanguage || endpoint.supportsRegion else { return url }
        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: false) else { return url }
        var queryItems = components.queryItems ?? []
        let existingKeys = Set(queryItems.map(\.name))
        if endpoint.supportsLanguage,
           !existingKeys.contains("language"),
           let defaultLanguage = configuration.defaultLanguage
        {
            queryItems.append(.language, value: defaultLanguage)
        }
        if endpoint.supportsRegion,
           !existingKeys.contains("region"),
           let defaultRegion = configuration.defaultRegion
        {
            queryItems.append(.region, value: defaultRegion)
        }
        if !queryItems.isEmpty {
            components.queryItems = queryItems
        }
        return components.url ?? url
    }
}

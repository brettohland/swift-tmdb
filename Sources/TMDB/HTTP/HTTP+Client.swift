import Foundation

extension HTTP {
    struct Client {
        let urlSession: URLSession

        init(authToken: String) {
            let config = URLSessionConfiguration.default
            config.httpAdditionalHeaders = [
                "Authorization": "Bearer \(authToken)",
                "Content": "application/json;charset=utf-8",
            ]
            urlSession = URLSession(configuration: config)
        }
    }
}

extension HTTP.Client {
    enum NetworkError: Error {
        case invalidRequest
        case clientError(HTTPURLResponse, Data)
        case serverError(HTTPURLResponse, Data)
    }
}

extension HTTP.Client {
    func data(for request: URLRequest) async throws -> Data {
        let (data, response) = try await urlSession.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidRequest
        }

        switch httpResponse.status.responseCategory {
        case .informational,
             .redirection,
             .success:
            return data
        case .clientError:
            throw NetworkError.clientError(httpResponse, data)
        case .serverError:
            throw NetworkError.serverError(httpResponse, data)
        }
    }
}

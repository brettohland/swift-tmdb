import Foundation

struct Endpoint<ResponseType: Decodable> {
    let path: String
    let method: HTTP.method
}

extension Endpoint {
    func makeURLRequest(with queryItems: [URLQueryItem] = [], httpBody: Data? = nil) throws -> URLRequest {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.themoviedb.org"
        urlComponents.path = "/" + path
        urlComponents.queryItems = queryItems.isEmpty ? nil : queryItems
        guard let url = urlComponents.url else {
            throw URLError(.badURL)
        }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.httpBody = httpBody
        return request
    }

    static func responseObject(from request: URLRequest, using client: HTTP.Client) async throws -> ResponseType {
        do {
            let data = try await client.data(for: request)
            return try TMDB.decoder.decode(ResponseType.self, from: data)
        } catch HTTP.Client.NetworkError.clientError(let response, let data) {
            switch try? TMDB.decoder.decode(TMDB.ErrorResponse.self, from: data) {
            case .some(let status):
                throw TMDB.RequestError.errorWithStatus(status)
            case .none:
                throw HTTP.Client.NetworkError.clientError(response, data)
            }
        } catch {
            throw error
        }
    }
}

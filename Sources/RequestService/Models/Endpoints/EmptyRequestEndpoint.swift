import Dependencies
import Foundation

public extension HTTP {
    struct EmptyRequestEndpoint<ResponseBody: Decodable>: HTTPEndpoint {
        // GET requests cannot have a body in the URLRequest.
        public typealias RequestBody = EmptyRequestBody

        public let baseURL: URL
        public let decoder: JSONDecoder
        public let encoder: JSONEncoder
        public let method: HTTP.Method = .get
        public let path: String
        public let sessionConfiguration: URLSessionConfiguration

        public init(
            baseURL: URL,
            path: String,
            sessionConfiguration: URLSessionConfiguration = .default,
            encoder: JSONEncoder = .iso8601SnakeCake,
            decoder: JSONDecoder = .iso8601SnakeCake
        ) {
            self.baseURL = baseURL
            self.decoder = decoder
            self.encoder = encoder
            self.path = path
            self.sessionConfiguration = sessionConfiguration
        }
    }
}

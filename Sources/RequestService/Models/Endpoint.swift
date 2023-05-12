import Dependencies
import Foundation

public extension HTTP {
    struct Endpoint<RequestBody: Encodable, ResponseBody: Decodable>: HTTPEndpoint {

        @Dependency(\.httpConfigProvider) private var httpConfigProvider

        public var httpConfiguration: HTTPConfiguration {
            httpConfigProvider.configuration
        }

        public let path: String
        public let method: HTTP.Method
        public let encoder: JSONEncoder
        public let decoder: JSONDecoder

        public init(
            path: String,
            method: HTTP.Method,
            encoder: JSONEncoder = .iso8601SnakeCake,
            decoder: JSONDecoder = .iso8601SnakeCake
        ) {
            self.path = path
            self.method = method
            self.encoder = encoder
            self.decoder = decoder
        }
    }
}

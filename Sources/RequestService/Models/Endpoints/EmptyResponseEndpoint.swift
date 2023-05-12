import Dependencies
import Foundation

public extension HTTP {
    struct EmptyResponseEndpoint<RequestBody: Encodable>: HTTPEndpoint {
        public typealias ResponseBody = EmptyResponseBody

        @Dependency(\.httpConfigProvider) private var configurationProvider

        public var httpConfiguration: HTTPConfiguration {
            configurationProvider.configuration
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

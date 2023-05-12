import Dependencies
import Foundation

public extension HTTP {
    struct EmptyRequestEndpoint<ResponseBody: Decodable>: HTTPEndpoint {
        // GET requests cannot have a body in the URLRequest.
        public typealias RequestBody = EmptyRequestBody

        @Dependency(\.httpConfigProvider) private var configurationProvider

        public var httpConfiguration: HTTPConfiguration {
            configurationProvider.configuration
        }

        public let path: String
        public let method: HTTP.Method = .get
        public let encoder: JSONEncoder
        public let decoder: JSONDecoder

        public init(path: String, encoder: JSONEncoder = .iso8601SnakeCake, decoder: JSONDecoder = .iso8601SnakeCake) {
            self.path = path
            self.encoder = encoder
            self.decoder = decoder
        }
    }
}

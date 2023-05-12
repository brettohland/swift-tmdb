import Foundation

public extension HTTP {
    struct Configuration: HTTPConfiguration {
        public let host: String
        public let client: HTTPClient

        public init(host: String, authenticationToken: String) {
            self.host = host
            client = HTTP.Client(configuration: .authorization(withToken: authenticationToken))
        }

        public init(host: String, sessionConfiguration: URLSessionConfiguration) {
            self.host = host
            client = HTTP.Client(configuration: sessionConfiguration)
        }
    }
}

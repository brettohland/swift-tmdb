//import Foundation
//
//public extension HTTP {
//    struct Endpoint<RequestBody: Encodable, ResponseBody: Decodable>: HTTPEndpoint {
//        public let sessionConfiguration: URLSessionConfiguration
//        public let baseURL: URL
//        public let path: String
//        public let method: HTTP.Method
//        public let encoder: JSONEncoder
//        public let decoder: JSONDecoder
//
//        public init(
//            baseURL: URL,
//            path: String,
//            method: HTTP.Method,
//            sessionConfiguration: URLSessionConfiguration = .default,
//            encoder: JSONEncoder = .iso8601SnakeCake,
//            decoder: JSONDecoder = .iso8601SnakeCake,
//        ) {
//            self.baseURL = baseURL
//            self.decoder = decoder
//            self.encoder = encoder
//            self.method = method
//            self.path = path
//            self.sessionConfiguration = sessionConfiguration
//        }
//    }
//}

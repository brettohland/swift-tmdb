// import Foundation
//
// extension HTTP {
//    struct Endpoint<RequestBody: Encodable, ResponseBody: Decodable>: HTTPEndpoint {
//         let sessionConfiguration: URLSessionConfiguration
//         let baseURL: URL
//         let path: String
//         let method: HTTP.Method
//         let encoder: JSONEncoder
//         let decoder: JSONDecoder
//
//         init(
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
// }

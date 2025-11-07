import Foundation

extension HTTP {
    enum Method: String {
        case delete = "DELETE"
        case get = "GET"
        case patch = "PATCH"
        case post = "POST"
        case put = "PUT"
    }
}

extension URLRequest {
    func httpMethod() throws -> HTTP.Method {
        guard let httpMethod else {
            throw HTTP.Error.unsupportedHTTPMethod
        }
        switch httpMethod {
        case HTTP.Method.delete.rawValue:
            return .delete
        case HTTP.Method.get.rawValue:
            return .get
        case HTTP.Method.patch.rawValue:
            return .patch
        case HTTP.Method.post.rawValue:
            return .post
        case HTTP.Method.put.rawValue:
            return .put
        default:
            throw HTTP.Error.unsupportedHTTPMethod
        }
    }
}

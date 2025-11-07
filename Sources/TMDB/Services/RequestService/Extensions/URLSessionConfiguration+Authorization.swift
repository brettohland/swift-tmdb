import Foundation

extension URLSessionConfiguration {
    static func authorization(withToken token: String) -> URLSessionConfiguration {
        let defaultConfiguration = URLSessionConfiguration.default
        let defaultHeaders: [HTTP.Header] = [
            .accept(.json),
            .contentType(.json),
            .authorizationToken(token),
        ]
        defaultConfiguration.addHTTPHeaders(defaultHeaders)
        return defaultConfiguration
    }
}

extension URLSessionConfiguration {
    func addHTTPHeaders(_ httpHeaders: [HTTP.Header]) {
        guard httpHeaders.isEmpty == false else {
            return
        }
        var headers = httpAdditionalHeaders ?? [:]
        for header in httpHeaders {
            headers[header.key] = header.value
        }
        httpAdditionalHeaders = headers
    }
}

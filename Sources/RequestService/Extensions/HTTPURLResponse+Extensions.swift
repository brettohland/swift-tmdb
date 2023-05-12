import Foundation

extension HTTPURLResponse {
    var responseStatus: HTTP.ResponseStatus {
        .init(statusCode: statusCode)
    }
}

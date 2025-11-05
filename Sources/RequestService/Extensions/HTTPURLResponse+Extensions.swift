import Foundation

public extension HTTPURLResponse {
    var responseStatus: HTTP.ResponseStatus {
        .init(statusCode: statusCode)
    }
}

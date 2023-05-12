import Foundation

extension HTTPURLResponse {
    var status: HTTP.Status {
        .init(statusCode: statusCode)
    }
}

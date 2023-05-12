import Foundation

public extension HTTP {
    enum Header {
        case authorization(prefix: String, value: String)
        case authorizationToken(String)
        case contentType(EncodingType)
        case accept(EncodingType)
    }

    enum EncodingType: String {
        case json = "application/json"
    }
}

extension HTTP.Header {
    var key: String {
        switch self {
        case .authorization,
             .authorizationToken:
            return "Authorization"
        case .contentType:
            return "Content-Type"
        case .accept:
            return "Accept"
        }
    }

    var value: String {
        switch self {
        case .authorization(let prefix, let value):
            return "\(prefix) \(value)"
        case .authorizationToken(let token):
            return "Token \(token)"
        case .accept(let encodingType),
             .contentType(let encodingType):
            return encodingType.rawValue
        }
    }
}

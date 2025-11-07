import Foundation

extension HTTP {
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
            "Authorization"
        case .contentType:
            "Content-Type"
        case .accept:
            "Accept"
        }
    }

    var value: String {
        switch self {
        case .authorization(let prefix, let value):
            "\(prefix) \(value)"
        case .authorizationToken(let token):
            "Token \(token)"
        case .accept(let encodingType),
             .contentType(let encodingType):
            encodingType.rawValue
        }
    }
}

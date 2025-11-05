import Foundation

// MARK: - HTTP.Error

public extension HTTP {
    enum Error {
        case noBodyForGetRequest
        case unsupportedHTTPMethod
    }
}

extension HTTP.Error: Error  {
    public var errorDescription: String? {
        switch self {
        case .noBodyForGetRequest:
            "Invalid Configuration"
        case .unsupportedHTTPMethod:
            "Unsupported HTTP Method"
        }
    }

    public var failureReason: String? {
        switch self {
        case .noBodyForGetRequest:
            "HTTP GET requests that include an encoded body is invalid."
        case .unsupportedHTTPMethod:
            "The HTTP Method on the URLRequest isn't supported"
        }
    }
}

// MARK: - HTTP.Client.Error


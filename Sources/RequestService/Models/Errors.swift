import Foundation

// MARK: - HTTP.Error

public extension HTTP {
    enum Error {
        case noBodyForGetRequest
    }
}

extension HTTP.Error: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .noBodyForGetRequest:
            return "Invalid Configuration"
        }
    }

    public var failureReason: String? {
        switch self {
        case .noBodyForGetRequest:
            return "HTTP GET requests that include an encoded body is invalid."
        }
    }
}

// MARK: - HTTP.Client.Error

public extension HTTP.Client {
    enum Error {
        /// The ``URLResponse`` from the server could not be cast to an ``HTTPURLResponse``.
        case invalidResponseFromServer(URLResponse, Data)
        /// The HTTP Status Code of the response was in the Client Error (4XX) range.
        case clientError(HTTPURLResponse, Data)
        /// The HTTP Status Code of the response was in the Server Error (5XX) range.
        case serverError(HTTPURLResponse, Data)
    }
}

extension HTTP.Client.Error: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .invalidResponseFromServer:
            return "Bad Response"
        case .clientError(let response, _):
            return "Client Error (\(response.responseStatus.intValue))"
        case .serverError(let response, _):
            return "Server Error (\(response.responseStatus.intValue))"
        }
    }

    public var failureReason: String? {
        switch self {
        case .invalidResponseFromServer:
            return "The URLResponse from the server was invalid."
        case .clientError(let response, _),
             .serverError(let response, _):
            let status = response.responseStatus
            return "The server reported the error: \(status.prettyString) (\(status.intValue))"
        }
    }
}

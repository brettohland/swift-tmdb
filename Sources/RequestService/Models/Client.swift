import Foundation

public extension HTTP {
    /// An HTTPClient which validates the server's HTTP Status Code.
    struct Client: HTTPClient {
        public let urlSession: URLSession

        public init(configuration: URLSessionConfiguration = .default) {
            urlSession = URLSession(configuration: configuration)
        }

        /// Uses the HTTPClient's `URLSession` to make the request to the server. Additionally, handles the decoding of
        /// the response's status code.
        /// The call will be considered a success if the server returns a status code inside of the Informational (1XX),
        /// Redirection (2XX), or Success (3XX) ranges.
        /// **NOTE:** In all cases, the returned or thrown values will include the HTTP response body. DO NOT LOG THE
        /// RAW BODY RESPONSE TO THE SYSTEM CONSOLE AS IT MAY CONTAIN PII.
        /// - Parameter request: A `URLRequest` to call.
        /// - Returns: The `Data` inside of the body of the response.
        /// - Throws: Will throw the following ``HTTP.Client.Error`` enums:
        ///     - ``.invalidResponseFromServer(Data)`` is thrown when the URLResponse from the server is invalid.
        ///     - ``.clientError(HTTPURLResponse, Data)`` Thrown on Client Error (4XX) status codes
        ///     - ``.serverError(HTTPURLResponse, Data)`` Thrown on Server Error (5XX) status codes
        public func data(for request: URLRequest) async throws -> Data {
            let (data, response) = try await urlSession.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse else {
                throw Error.invalidResponseFromServer(response, data)
            }
            switch httpResponse.responseStatus.category {
            case .informational,
                 .redirection,
                 .success:
                return data
            case .clientError:
                throw Error.clientError(httpResponse, data)
            case .serverError:
                throw Error.serverError(httpResponse, data)
            }
        }
    }
}

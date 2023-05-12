import Foundation

public extension HTTP {
    enum ResponseStatus: Int {
        // MARK: - 1XX/Informational

        case `continue` = 100
        case switchingProtocols = 101
        case processing = 102

        // MARK: - 2XX/Success

        case ok = 200
        case created = 201
        case accepted = 202
        case nonAuthoritativeInformation = 203
        case noContent = 204
        case resetContent = 205
        case partialContent = 206
        case multiStatus = 207
        case alreadyReported = 208
        case imUsed = 226

        // MARK: 3XX/Redirection

        case multipleChoices = 300
        case movedPermanently = 301
        case found = 302
        case seeOther = 303
        case notModified = 304
        case useProxy = 305
        case switchProxy = 306
        case temporaryRedirect = 307
        case permanentRedirect = 308

        // MARK: - 4XX/Client Error

        case badRequest = 400
        case unauthorized = 401
        case paymentRequired = 402
        case forbidden = 403
        case notFound = 404
        case methodNotAllowed = 405
        case notAcceptable = 406
        case proxyAuthenticationRequired = 407
        case requestTimeout = 408
        case conflict = 409
        case gone = 410
        case lengthRequired = 411
        case preconditionFailed = 412
        case payloadTooLarge = 413
        case URITooLong = 414
        case unsupportedMediaType = 415
        case rangeNotSatisfiable = 416
        case expectationFailed = 417
        case imATeapot = 418
        case misdirectedRequest = 421
        case unprocessableEntity = 422
        case locked = 423
        case failedDependency = 424
        case upgradeRequired = 426
        case preconditionRequired = 428
        case tooManyRequests = 429
        case requestHeaderFieldsTooLarge = 431
        case noResponse = 444
        case unavailableForLegalReasons = 451
        case sslCertificateError = 495
        case sslCertificateRequired = 496
        case httpRequestSentToHTTPSPort = 497
        case clientClosedRequest = 499

        // MARK: - 5XX/Server Error

        case internalServerError = 500
        case notImplemented = 501
        case badGateway = 502
        case serviceUnavailable = 503
        case gatewayTimeout = 504
        case HTTPVersionNotSupported = 505
        case variantAlsoNegotiates = 506
        case insufficientStorage = 507
        case loopDetected = 508
        case notExtended = 510
        case networkAuthenticationRequired = 511

        public init(statusCode: Int) {
            self = .init(rawValue: statusCode) ?? .internalServerError
        }
    }
}

public extension HTTP.ResponseStatus {
    enum Category {
        /// 1XX: An informational response indicates that the request was received and understood.
        case informational
        /// 2XX: Indicates the action requested by the client was received, understood, and accepted.
        case success
        /// 3XX: Indicates the client must take additional action to complete the request.
        case redirection
        /// 4XX: Intended for situations in which the error seems to have been caused by the client.
        case clientError
        /// 5XX: The server failed to fulfill a request
        case serverError
    }
}

public extension HTTP.ResponseStatus {
    /// Returns the Category for the given HTTPStatusCode
    var category: Category {
        switch rawValue {
        case 100 ... 199:
            return .informational
        case 200 ... 299:
            return .success
        case 300 ... 399:
            return .redirection
        case 400 ... 499:
            return .clientError
        case 500 ... 599:
            return .serverError
        default:
            assertionFailure("Response code was an unknown type, falling back to server error")
            return .serverError
        }
    }
}

public extension HTTP.ResponseStatus {
    var prettyString: String {
        // Adds a space before all capital letters.
        let splitString = String(describing: self).unicodeScalars.reduce("") {
            guard CharacterSet.uppercaseLetters.contains($1) else {
                return $0 + String($1)
            }
            return $0 + " " + String($1)
        }
        return splitString.capitalized
    }

    var intValue: Int {
        rawValue
    }
}

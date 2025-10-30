import Dependencies
import Foundation
import RequestService
import Utilities

public enum MockHTTPClientError: Error {
    case endpointNotDefined
    case noData
}

struct V3Mocks {
    static func data(for request: URLRequest) async throws -> Data {
        let requestEndpoint = try endpointForURLRequest(request)
        let httpMethod = try request.httpMethod()
        return try requestEndpoint.mockData(method: httpMethod)
    }
}

extension V3Mocks {
    static func endpointForURLRequest(_ request: URLRequest) throws -> TMDB.Endpoint.v3 {
        guard let url = request.url else {
            throw MockHTTPClientError.endpointNotDefined
        }
        // Movie Details
        if url.path().wholeMatch(of: /\/3\/movie\/\d*/)?.isEmpty == false {
            return .movieDetails
        }
        throw MockHTTPClientError.endpointNotDefined
    }
}

extension TMDB.Endpoint.v3 {
    func mockData(method: HTTP.Method) throws -> Data {
        let fileName: String
        switch (method, self) {
        case (.get, .movieDetails):
            fileName = "GetMovieDetails"
        default:
            throw MockHTTPClientError.noData
        }
        return try MockData.contents(ofFileNamed: fileName)
    }
}


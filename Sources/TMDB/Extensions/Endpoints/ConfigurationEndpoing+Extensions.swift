import Foundation
import RequestService
import SharedModels

extension TMDBInternal.V3Endpoints.Configuration: EndpointFactory {
    public func makeURL(baseURL: URL) -> URL {
        // /3
        var paths = ["3"]
        switch self {
        case .details:
            // /3/details
            paths.append("details")
        case .countries:
            // /3/configuration
            paths.append("configuration")
        }
        return URLFactory.makeURL(baseURL: baseURL, appending: paths)
    }

}

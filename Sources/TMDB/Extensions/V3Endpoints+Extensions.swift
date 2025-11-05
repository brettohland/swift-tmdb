import Foundation
import RequestService
import SharedModels

extension TMDBInternal.V3Endpoints: EndpointRoot {
    public static var rootPaths: [String] {
        ["3"]
    }
}

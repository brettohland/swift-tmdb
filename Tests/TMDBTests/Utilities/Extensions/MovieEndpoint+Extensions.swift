import Foundation
import SharedModels

extension TMDBInternal.V3Endpoints.Movies: MockableEndpoint {
    var mockFilename: String {
        switch self {
        case .alternativeTitles:
            "AlternativeTitles"
        case .details:
            "MovieDetails"
        }
    }
}

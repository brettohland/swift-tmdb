import Foundation
import Testing
@testable import TMDB
import SharedModels

struct PathMatchingServiceTests {




    @Test func matchV3Paths() async throws {



    }

}

extension TMDBInternal.V3Endpoints.Configuration: RawRepresentable {
    public init?(rawValue: String) {
        nil
    }
    
    public var rawValue: String {
        switch self {
        case .details:
            "https://api.themoviedb.org/3/configuration"
        case .countries:
            "https://api.themoviedb.org/3/configuration/countries"
        }
    }
}

extension TMDBInternal.V3Endpoints.Movies: RawRepresentable {
    public init?(rawValue: String) {
        nil
    }

    public var rawValue: String {
        switch self {
        case .details(id: let id):
            "https://api.themoviedb.org/3/movie/\(id)"
        case .alternativeTitles(id: let id):
            "https://api.themoviedb.org/3/movie/\(id)/alternative_titles"
        }
    }
}

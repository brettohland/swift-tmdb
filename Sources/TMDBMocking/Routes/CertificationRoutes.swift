import Foundation
import TMDB

enum CertificationRoutes: MockRouteProvider {
    static var mockRoutes: [MockRoute] {
        [
            MockRoute(pattern: "^/3/certification/movie/list$") {
                try TMDB.MovieCertifications.mockData()
            },
            MockRoute(pattern: "^/3/certification/tv/list$") {
                try TMDB.TVCertifications.mockData()
            },
        ]
    }
}

import Foundation
internal import Dependencies

enum PathMatchingService {
    enum MatchingError: Error {
        case missingURL
        case invalidV3Path(String)
        case unsupportedAPIVersion
    }

    private static let v3Routes: [MockRoute] =
        TMDB.V3Endpoints.Configuration.mockRoutes
            + TMDB.V3Endpoints.Certifications.mockRoutes
            + TMDB.V3Endpoints.Credits.mockRoutes
            + TMDB.V3Endpoints.Discover.mockRoutes
            + TMDB.V3Endpoints.Genres.mockRoutes
            + TMDB.V3Endpoints.Movies.mockRoutes
            + TMDB.V3Endpoints.Reviews.mockRoutes
            + TMDB.V3Endpoints.Trending.mockRoutes
            + TMDB.V3Endpoints.WatchProviders.mockRoutes
            + TMDB.V3Endpoints.Search.mockRoutes
            + TMDB.V3Endpoints.Find.mockRoutes
            + TMDB.V3Endpoints.Keywords.mockRoutes
            + TMDB.V3Endpoints.Collections.mockRoutes
            + TMDB.V3Endpoints.TVEpisodes.mockRoutes
            + TMDB.V3Endpoints.TVEpisodeGroups.mockRoutes
            + TMDB.V3Endpoints.TVSeasons.mockRoutes
            + TMDB.V3Endpoints.TVSeries.mockRoutes

    static func dataFromURLRequest(_ request: URLRequest) throws -> Data {
        guard let url = request.url else {
            throw MatchingError.missingURL
        }
        switch url.pathComponents[1] {
        case "3":
            return try handleV3Path(url)
        case "4":
            return try handleV4Paths(url)
        default:
            throw MatchingError.unsupportedAPIVersion
        }
    }

    static func handleV3Path(_ url: URL) throws -> Data {
        let path = url.path()

        for route in v3Routes {
            let regex = try Regex(route.pattern)
            if path.contains(regex) {
                Dependency(\.logger).wrappedValue.debug("Matched \(route.pattern) in \(path)")
                return try route.dataProvider()
            }
        }

        Dependency(\.logger).wrappedValue.critical("Failed to match any known endpoints to \(path)")
        throw MatchingError.invalidV3Path(path)
    }

    static func handleV4Paths(_ url: URL) throws -> Data {
        Dependency(\.logger).wrappedValue.critical("V4 Paths are not supported at this time")
        throw MatchingError.unsupportedAPIVersion
    }
}

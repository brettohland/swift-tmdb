import Foundation

enum PathMatchingService {
    enum MatchingError: Error {
        case missingURL
        case invalidV3Path(String)
        case unsupportedAPIVersion
    }

    private static let v3Routes: [MockRoute] =
        ConfigurationRoutes.mockRoutes
            + CertificationRoutes.mockRoutes
            + CreditRoutes.mockRoutes
            + DiscoverRoutes.mockRoutes
            + GenreRoutes.mockRoutes
            + MovieRoutes.mockRoutes
            + ReviewRoutes.mockRoutes
            + TrendingRoutes.mockRoutes
            + WatchProviderRoutes.mockRoutes
            + SearchRoutes.mockRoutes
            + FindRoutes.mockRoutes
            + KeywordRoutes.mockRoutes
            + CollectionRoutes.mockRoutes
            + TVEpisodeRoutes.mockRoutes
            + TVEpisodeGroupRoutes.mockRoutes
            + TVSeasonRoutes.mockRoutes
            + TVSeriesRoutes.mockRoutes

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
                #if DEBUG
                print("[TMDBMocking] Matched \(route.pattern) in \(path)")
                #endif
                return try route.dataProvider()
            }
        }

        #if DEBUG
        print("[TMDBMocking] Failed to match any known endpoints to \(path)")
        #endif
        throw MatchingError.invalidV3Path(path)
    }

    static func handleV4Paths(_ url: URL) throws -> Data {
        #if DEBUG
        print("[TMDBMocking] V4 Paths are not supported at this time")
        #endif
        throw MatchingError.unsupportedAPIVersion
    }
}

import Foundation
internal import Dependencies
import RegexBuilder

enum PathMatchingService {
    enum MatchingError: Error {
        case missingURL
        case invalidV3Path([String])
        case unsupportedAPIVersion
    }

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
        if try doesURLMatchPath(url, path: TMDB.V3Endpoints.Configuration.details) {
            return try TMDB.ConfigurationResponse.mockData()
        }

        if try doesURLMatchPath(url, path: TMDB.V3Endpoints.Configuration.countries) {
            return try CountriesResponse.mockData()
        }

        if try doesURLMatchPath(url, path: TMDB.V3Endpoints.Configuration.jobs) {
            return try TMDB.Configuration.JobDepartment.mockData()
        }

        if try doesURLMatchPath(url, path: TMDB.V3Endpoints.Configuration.languages) {
            return try TMDB.Configuration.Language.mockData()
        }

        if try doesURLMatchPath(url, path: TMDB.V3Endpoints.Configuration.primaryTranslations) {
            return try MockUtilities.jsonDataFromFile("PrimaryTranslations")
        }

        if try doesURLMatchPath(url, path: TMDB.V3Endpoints.Configuration.timezones) {
            return try TMDB.Configuration.Timezone.mockData()
        }

        if try doesURLMatchPath(url, path: TMDB.V3Endpoints.Certifications.movieList) {
            return try TMDB.MovieCertifications.mockData()
        }

        if try doesURLMatchPath(url, path: TMDB.V3Endpoints.Certifications.tvList) {
            return try TMDB.TVCertifications.mockData()
        }

        if try doesURLMatchPath(url, path: TMDB.V3Endpoints.Genres.movieList) {
            return try TMDB.GenreList.mockData()
        }

        if try doesURLMatchPath(url, path: TMDB.V3Endpoints.Genres.tvList) {
            return try MockUtilities.jsonDataFromFile("TVGenres")
        }

        if try doesURLMatchPath(url, path: TMDB.V3Endpoints.Trending.all(timeWindow: .day)) {
            return try MockUtilities.jsonDataFromFile("TrendingAll")
        }

        if try doesURLMatchPath(url, path: TMDB.V3Endpoints.Trending.movie(timeWindow: .day)) {
            return try MockUtilities.jsonDataFromFile("TrendingMovies")
        }

        if try doesURLMatchPath(url, path: TMDB.V3Endpoints.Trending.tv(timeWindow: .day)) {
            return try MockUtilities.jsonDataFromFile("TrendingTV")
        }

        if try doesURLMatchPath(url, path: TMDB.V3Endpoints.Trending.person(timeWindow: .day)) {
            return try MockUtilities.jsonDataFromFile("TrendingPeople")
        }

        if try doesURLMatchPath(url, path: TMDB.V3Endpoints.WatchProviders.regions) {
            return try TMDB.WatchProviderRegions.mockData()
        }

        if try doesURLMatchPath(url, path: TMDB.V3Endpoints.WatchProviders.movie) {
            return try TMDB.WatchProviderList.mockData()
        }

        if try doesURLMatchPath(url, path: TMDB.V3Endpoints.WatchProviders.tv) {
            return try MockUtilities.jsonDataFromFile("TVProviders")
        }

        // Movie sub-endpoints (must come before details match)
        if try doesURLMatchPath(url, path: TMDB.V3Endpoints.Movies.credits(id: 0)) {
            return try TMDB.MovieCredits.mockData()
        }

        if try doesURLMatchPath(url, path: TMDB.V3Endpoints.Movies.images(id: 0)) {
            return try TMDB.ImageCollection.mockData()
        }

        if try doesURLMatchPath(url, path: TMDB.V3Endpoints.Movies.videos(id: 0)) {
            return try TMDB.VideoCollection.mockData()
        }

        if try doesURLMatchPath(url, path: TMDB.V3Endpoints.Movies.reviews(id: 0)) {
            return try MockUtilities.jsonDataFromFile("MovieReviews")
        }

        if try doesURLMatchPath(url, path: TMDB.V3Endpoints.Movies.keywords(id: 0)) {
            return try MockUtilities.jsonDataFromFile("MovieKeywords")
        }

        if try doesURLMatchPath(url, path: TMDB.V3Endpoints.Movies.similar(id: 0)) {
            return try MockUtilities.jsonDataFromFile("SimilarMovies")
        }

        if try doesURLMatchPath(url, path: TMDB.V3Endpoints.Movies.recommendations(id: 0)) {
            return try MockUtilities.jsonDataFromFile("MovieRecommendations")
        }

        if try doesURLMatchPath(url, path: TMDB.V3Endpoints.Movies.releaseDates(id: 0)) {
            return try MockUtilities.jsonDataFromFile("MovieReleaseDates")
        }

        if try doesURLMatchPath(url, path: TMDB.V3Endpoints.Movies.externalIDs(id: 0)) {
            return try TMDB.ExternalIDs.mockData()
        }

        if try doesURLMatchPath(url, path: TMDB.V3Endpoints.Movies.translations(id: 0)) {
            return try MockUtilities.jsonDataFromFile("MovieTranslations")
        }

        if try doesURLMatchPath(url, path: TMDB.V3Endpoints.Movies.watchProviders(id: 0)) {
            return try TMDB.MovieWatchProviderResult.mockData()
        }

        if try doesURLMatchPath(url, path: TMDB.V3Endpoints.Movies.changes(id: 0)) {
            return try TMDB.ChangeCollection.mockData()
        }

        if try doesURLMatchPath(url, path: TMDB.V3Endpoints.Movies.alternativeTitles(id: 0)) {
            return try TMDB.AlternativeTitle.mockData()
        }

        if try doesURLMatchPath(url, path: TMDB.V3Endpoints.Movies.details(id: 0)) {
            return try TMDB.Movie.mockData()
        }

        // Movie list endpoints
        if try doesURLMatchPath(url, path: TMDB.V3Endpoints.Movies.latest) {
            return try MockUtilities.jsonDataFromFile("MovieLatest")
        }

        if try doesURLMatchPath(url, path: TMDB.V3Endpoints.Movies.nowPlaying) {
            return try MockUtilities.jsonDataFromFile("MoviesNowPlaying")
        }

        if try doesURLMatchPath(url, path: TMDB.V3Endpoints.Movies.popular) {
            return try MockUtilities.jsonDataFromFile("PopularMovies")
        }

        if try doesURLMatchPath(url, path: TMDB.V3Endpoints.Movies.topRated) {
            return try MockUtilities.jsonDataFromFile("TopRatedMovies")
        }

        if try doesURLMatchPath(url, path: TMDB.V3Endpoints.Movies.upcoming) {
            return try MockUtilities.jsonDataFromFile("UpcomingMovies")
        }

        // Review endpoint
        if try doesURLMatchPath(url, path: TMDB.V3Endpoints.Reviews.details(id: "0")) {
            return try TMDB.Review.mockData()
        }

        if try doesURLMatchPath(url, path: TMDB.V3Endpoints.Discover.movie(filters: [])) {
            let movie = try TMDB.Discover.DiscoverMovie.mock()
            let response = TMDB.Discover.PaginatedResponse<TMDB.Discover.DiscoverMovie>(
                page: 1,
                totalResults: 1,
                totalPages: 1,
                results: [movie],
            )
            return try JSONEncoder().encode(response)
        }

        if try doesURLMatchPath(url, path: TMDB.V3Endpoints.Discover.tv(filters: [])) {
            let show = try TMDB.Discover.DiscoverTV.mock()
            let response = TMDB.Discover.PaginatedResponse<TMDB.Discover.DiscoverTV>(
                page: 1,
                totalResults: 1,
                totalPages: 1,
                results: [show],
            )
            let encoder = JSONEncoder()
            encoder.keyEncodingStrategy = .convertToSnakeCase
            return try encoder.encode(response)
        }

        Dependency(\.logger).wrappedValue.critical("Failed to match any known endpoints to \(url.path())")
        throw MatchingError.unsupportedAPIVersion
    }

    static func doesURLMatchPath(_ url: URL, path: RegexComparable) throws -> Bool {
        switch try url.relativePath.contains(path.pattern()) {
        case true:
            Dependency(\.logger).wrappedValue.debug("Matched \(path.patternString) in \(url.path)")
            return true
        case false:
            return false
        }
    }

    static func handleV4Paths(_ url: URL) throws -> Data {
        Dependency(\.logger).wrappedValue.critical("V4 Paths are not supported at this time")
        throw MatchingError.unsupportedAPIVersion
    }
}

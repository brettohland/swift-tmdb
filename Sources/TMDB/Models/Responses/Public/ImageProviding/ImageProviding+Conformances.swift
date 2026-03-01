import Foundation

// MARK: - PosterImageProviding + BackdropImageProviding

extension TMDB.Movie: PosterImageProviding, BackdropImageProviding {}
extension TMDB.TVSeries: PosterImageProviding, BackdropImageProviding {}
extension TMDB.Discover.DiscoverMovie: PosterImageProviding, BackdropImageProviding {}
extension TMDB.Discover.DiscoverTV: PosterImageProviding, BackdropImageProviding {}
extension TMDB.Collection: PosterImageProviding, BackdropImageProviding {}
extension TMDB.SearchCollection: PosterImageProviding, BackdropImageProviding {}
extension TMDB.List.Item: PosterImageProviding, BackdropImageProviding {}
extension TMDB.List.Details: PosterImageProviding, BackdropImageProviding {}
extension TMDB.Account.AccountList: PosterImageProviding, BackdropImageProviding {}
extension TMDB.Account.RatedTV: PosterImageProviding, BackdropImageProviding {}
extension TMDB.Account.RatedMovie: PosterImageProviding, BackdropImageProviding {}
extension TMDB.GuestSession.RatedTV: PosterImageProviding, BackdropImageProviding {}
extension TMDB.GuestSession.RatedMovie: PosterImageProviding, BackdropImageProviding {}
extension TMDB.PersonCombinedCredit: PosterImageProviding, BackdropImageProviding {}
extension TMDB.PersonMovieCastCredit: PosterImageProviding, BackdropImageProviding {}
extension TMDB.PersonMovieCrewCredit: PosterImageProviding, BackdropImageProviding {}
extension TMDB.PersonTVCastCredit: PosterImageProviding, BackdropImageProviding {}
extension TMDB.PersonTVCrewCredit: PosterImageProviding, BackdropImageProviding {}
extension TMDB.Credits.Media: PosterImageProviding, BackdropImageProviding {}

// MARK: - PosterImageProviding + BackdropImageProviding + ProfileImageProviding

extension TMDB.MultiSearchResult: PosterImageProviding, BackdropImageProviding, ProfileImageProviding {}
extension TMDB.TrendingResult: PosterImageProviding, BackdropImageProviding, ProfileImageProviding {}

// MARK: - PosterImageProviding only

extension TMDB.TVSeries.SeasonOverview: PosterImageProviding {}
extension TMDB.TVSeason: PosterImageProviding {}
extension TMDB.FindTVSeason: PosterImageProviding {}

// MARK: - ProfileImageProviding

extension TMDB.Person: ProfileImageProviding {}
extension TMDB.PopularPerson: ProfileImageProviding {}
extension TMDB.TrendingPerson: ProfileImageProviding {}
extension TMDB.SearchPerson: ProfileImageProviding {}
extension TMDB.CastMember: ProfileImageProviding {}
extension TMDB.CrewMember: ProfileImageProviding {}
extension TMDB.AggregateCastMember: ProfileImageProviding {}
extension TMDB.AggregateCrewMember: ProfileImageProviding {}
extension TMDB.TVSeries.Creator: ProfileImageProviding {}
extension TMDB.FindPerson: ProfileImageProviding {}

// TMDB.Credits.Person has profilePath: String (non-optional), which cannot satisfy
// the ProfileImageProviding requirement of String?. A direct extension method
// provides the same API surface.
public extension TMDB.Credits.Person {
    /// Constructs a full profile image URL from this person's `profilePath`.
    ///
    /// - Parameter size: The desired image size (e.g., `.setWidth(185)` or `.original`).
    /// - Returns: A fully-qualified image URL.
    /// - Throws: ``TMDBRequestError/imageConfigurationMissing`` if ``TMDB/initialize(configuration:)``
    ///   has not been called, or ``TMDBRequestError/unsupportedImageSize(requested:supported:)`` if
    ///   the size is not in ``TMDB/ImageConfiguration/profileSizes``.
    func profileImageURL(
        size: TMDB.Configuration.ImageSize,
    ) throws(TMDBRequestError) -> URL {
        guard let configuration = TMDB.imageConfiguration else {
            throw .imageConfigurationMissing
        }
        guard configuration.profileSizes.contains(size) else {
            throw .unsupportedImageSize(requested: size, supported: configuration.profileSizes)
        }
        return URL(string: configuration.secureBaseUrl.absoluteString + size.rawValue + profilePath)!
    }
}

// MARK: - LogoImageProviding

extension TMDB.ProductionCompany: LogoImageProviding {}
extension TMDB.SearchCompany: LogoImageProviding {}
extension TMDB.Network: LogoImageProviding {}
extension TMDB.Company: LogoImageProviding {}
extension TMDB.TVSeries.Network: LogoImageProviding {}

// MARK: - StillImageProviding

extension TMDB.TVEpisode: StillImageProviding {}
extension TMDB.GuestSession.RatedEpisode: StillImageProviding {}
extension TMDB.TVSeries.EpisodeOverview: StillImageProviding {}
extension TMDB.FindTVEpisode: StillImageProviding {}

// MARK: - ImageURLProviding

extension TMDB.ImageDetail: ImageURLProviding {}
extension TMDB.LogoDetail: ImageURLProviding {}

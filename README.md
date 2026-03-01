```
           ▗▄▄▖▄   ▄ ▄ ▗▞▀▀▘■      ▗▄▄▄▖▗▖  ▗▖▗▄▄▄  ▗▄▄▖
          ▐▌   █ ▄ █ ▄ ▐▌▗▄▟▙▄▖      █  ▐▛▚▞▜▌▐▌  █ ▐▌ ▐▌
           ▝▀▚▖█▄█▄█ █ ▐▛▀▘▐▌        █  ▐▌  ▐▌▐▌  █ ▐▛▀▚▖
          ▗▄▄▞▘      █ ▐▌  ▐▌        █  ▐▌  ▐▌▐▙▄▄▀ ▐▙▄▞▘
                           ▐▌

```

# `swift-tmdb`: A Modern TMDB Swift Package

A TMDB SDK that targets iOS/iPadOS 26 and uses Swift 6.2 and provides automatic mocked responses during unit testing
and in SwiftUI Previews.

[swift-tmdb Documentation](https://brettohland.github.io/swift-tmdb/documentation/tmdb/)

[See the Usage guide in the documentation](https://brettohland.github.io/swift-tmdb/documentation/tmdb/usage)

## Products

The package provides five targets across four library products:

| Product                | Targets                | Description                                                                                 |
| ---------------------- | ---------------------- | ------------------------------------------------------------------------------------------- |
| **`TMDB`**             | `TMDB` + `TMDBMocking` | Full experience with automatic mocked responses in tests and SwiftUI Previews               |
| **`TMDBCore`**         | `TMDB` only            | Smaller bundle without mock data. Use `withDependencies` to provide your own test doubles   |
| **`TMDBSwiftUI`**      | `TMDBSwiftUI`          | SwiftUI authentication view modifier (`.tmdbAuthentication(isPresented:onComplete:)`)       |
| **`TMDBUIKit`**        | `TMDBUIKit`            | UIKit authentication (`TMDB.authenticate(presentationAnchor:)`)                             |
| **`TMDBDependencies`** | `TMDBDependencies`     | [PointFree Dependencies](https://github.com/pointfreeco/swift-dependencies) client wrappers |

```swift
// Full experience (automatic mocking):
.product(name: "TMDB", package: "swift-tmdb")

// Smaller bundle (no mock data):
.product(name: "TMDBCore", package: "swift-tmdb")

// SwiftUI browser-based auth:
.product(name: "TMDBSwiftUI", package: "swift-tmdb")

// UIKit browser-based auth:
.product(name: "TMDBUIKit", package: "swift-tmdb")

// PointFree Dependencies integration:
.product(name: "TMDBDependencies", package: "swift-tmdb")
```

## Dependencies

Internally, the package uses [Point Free's Dependencies](https://github.com/pointfreeco/swift-dependencies) in order
to support the ability for the TMDB framework to provide real data when run in Testing or SwiftUI Preview environments.

## Advanced Usage

### Discovery Filters

The [Discover Movies](https://developer.themoviedb.org/reference/discover-movie) and [Discover TV](https://developer.themoviedb.org/reference/discover-tv)
endpoints include optional filters which allow for complex querying of data from the TMDB API.

These filters are first-class value types in framework and can be composited easily to replicate complex functionality.

- [Movie Filters Documentation](https://brettohland.github.io/swift-tmdb/documentation/tmdb/tmdb/discover/moviefilter)
- [TV Filters Documentation](https://brettohland.github.io/swift-tmdb/documentation/tmdb/tmdb/discover/tvfilter)

### Image URLs

Image configuration is cached automatically during initialization — no manual fetch needed. Response types that include image paths provide convenience methods:

```swift
let movie = try await TMDB.movieDetails(id: 550)
if let posterURL = try movie.posterImageURL(size: .setWidth(500)) {
    // Use posterURL to load the image
}
```

See the [Image URL Construction documentation](https://brettohland.github.io/swift-tmdb/documentation/tmdb/) for available protocols and sizes.

### Format Styles

Custom [Format Style](https://developer.apple.com/documentation/Foundation/FormatStyle) implementations which allow for
easy display of data coming from the TMDB API.

- [Runtime FormatStyle](https://brettohland.github.io/swift-tmdb/documentation/tmdb/runtime)

---

## Makefile

| Command                 | Description                                 |
| ----------------------- | ------------------------------------------- |
| `make test`             | Run unit tests (mock data, no network)      |
| `make integration-test` | Run integration tests against live TMDB API |
| `make docs`             | Generate static DocC site into `docs/`      |
| `make preview-docs`     | Preview documentation locally in browser    |
| `make format`           | Run SwiftFormat                             |

### Integration Tests

Integration tests require a `TMDB_API_KEY` environment variable. Tests skip gracefully when no API key is set.

```bash
TMDB_API_KEY=<your-key> make integration-test
```

Integration tests run weekly via GitHub Actions and can be triggered manually.

---

## Roadmap

| Feature                                              | Endpoints | Status |
| ---------------------------------------------------- | --------- | ------ |
| Configuration, Genres, Trending, Watch Providers     | 15        | Done   |
| Movies (details, credits, lists, images, etc.)       | 20        | Done   |
| Search, Find, Keywords, Collections                  | 12        | Done   |
| Language, Region & Query Parameter Support           | --        | Done   |
| TV Series, Seasons, Episodes, Episode Groups         | 41        | Done   |
| People, Companies, Networks                          | 12        | Done   |
| Auth & Session Infrastructure (v3 + v4)              | 5         | Done   |
| Account Read & Write (favorites, watchlist, ratings) | 15        | Done   |
| Lists v4 CRUD                                        | 9         | Done   |
| Guest Sessions                                       | 10        | Done   |
| Integration Test Suite                               | 102 tests | Done   |

---

## Supported Endpoints

### Account (Authenticated)

#### v4 Account Read

- [Account Lists](https://developer.themoviedb.org/reference/account-lists) — `accountLists(page:)`
- [Favorite Movies](https://developer.themoviedb.org/reference/account-favorite-movies) — `favoriteMovies(sortBy:page:language:)`
- [Favorite TV Series](https://developer.themoviedb.org/reference/account-favorite-tv) — `favoriteTVSeries(sortBy:page:language:)`
- [Rated Movies](https://developer.themoviedb.org/reference/account-rated-movies) — `ratedMovies(sortBy:page:language:)`
- [Rated TV Series](https://developer.themoviedb.org/reference/account-rated-tv) — `ratedTVSeries(sortBy:page:language:)`
- [Movie Recommendations](https://developer.themoviedb.org/reference/account-movie-recommendations) — `accountMovieRecommendations(page:language:)`
- [TV Recommendations](https://developer.themoviedb.org/reference/account-tv-recommendations) — `accountTVRecommendations(page:language:)`
- [Watchlist Movies](https://developer.themoviedb.org/reference/account-watchlist-movies) — `watchlistMovies(page:)`
- [Watchlist TV Series](https://developer.themoviedb.org/reference/account-watchlist-tv) — `watchlistTVSeries(page:)`

#### v3 Account Write

- [Set Favorite](https://developer.themoviedb.org/reference/account-add-favorite) — `setFavorite(mediaType:mediaID:favorite:)`
- [Set Watchlist](https://developer.themoviedb.org/reference/account-add-to-watchlist) — `setWatchlist(mediaType:mediaID:watchlist:)`
- [Rate Movie](https://developer.themoviedb.org/reference/movie-add-rating) — `rateMovie(id:rating:)`
- [Delete Movie Rating](https://developer.themoviedb.org/reference/movie-delete-rating) — `deleteMovieRating(id:)`
- [Rate TV Series](https://developer.themoviedb.org/reference/tv-series-add-rating) — `rateTVSeries(id:rating:)`
- [Delete TV Series Rating](https://developer.themoviedb.org/reference/tv-series-delete-rating) — `deleteTVSeriesRating(id:)`
- [Rate TV Episode](https://developer.themoviedb.org/reference/tv-episode-add-rating) — `rateTVEpisode(seriesID:seasonNumber:episodeNumber:rating:)`
- [Delete TV Episode Rating](https://developer.themoviedb.org/reference/tv-episode-delete-rating) — `deleteTVEpisodeRating(seriesID:seasonNumber:episodeNumber:)`

### Authentication

- [Create Request Token (v4)](https://developer.themoviedb.org/reference/auth-create-request-token) — `createRequestToken(redirectTo:)`
- [Create Access Token (v4)](https://developer.themoviedb.org/reference/auth-create-access-token) — `createAccessToken(requestToken:)`
- [Delete Access Token (v4)](https://developer.themoviedb.org/reference/auth-delete-access-token) — `deleteAccessToken(_:)`
- [Convert to v3 Session](https://developer.themoviedb.org/reference/authentication-create-session-from-v4-token) — `convertToV3Session(accessToken:)`
- [Delete v3 Session](https://developer.themoviedb.org/reference/authentication-delete-session) — `deleteV3Session(sessionID:)`

### Certifications

- [Movie Certifications](https://developer.themoviedb.org/reference/certification-movie-list) — `movieCertifications()`
- [TV Certifications](https://developer.themoviedb.org/reference/certification-tv-list) — `tvCertifications()`

### Collections

- [Collection Details](https://developer.themoviedb.org/reference/collection-details) — `collectionDetails(id:language:)`
- [Collection Images](https://developer.themoviedb.org/reference/collection-images) — `collectionImages(id:language:)`

### Companies

- [Company Details](https://developer.themoviedb.org/reference/company-details) — `companyDetails(id:)`
- [Company Images](https://developer.themoviedb.org/reference/company-images) — `companyImages(id:)`

### Configuration

- [Configuration Details](https://developer.themoviedb.org/reference/configuration-details) — `configurationDetails()`
- [Countries](https://developer.themoviedb.org/reference/configuration-countries) — `supportedCountries()`
- [Jobs](https://developer.themoviedb.org/reference/configuration-jobs) — `jobDepartments()`
- [Languages](https://developer.themoviedb.org/reference/configuration-languages) — `supportedLanguages()`
- [Primary Translations](https://developer.themoviedb.org/reference/configuration-primary-translations) — `primaryTranslations()`
- [Timezones](https://developer.themoviedb.org/reference/configuration-timezones) — `timezones()`

### Credits

- [Credit Details](https://developer.themoviedb.org/reference/credit-details) — `credits(forID:)`

### Discover

- [Discover Movies](https://developer.themoviedb.org/reference/discover-movie) — `discoverMovie(filters:)`
- [Discover TV](https://developer.themoviedb.org/reference/discover-tv) — `discoverTV(filters:)`

### Find

- [Find by External ID](https://developer.themoviedb.org/reference/find-by-id) — `find(externalID:source:language:)`

### Genres

- [Movie Genres](https://developer.themoviedb.org/reference/genre-movie-list) — `movieGenres(language:)`
- [TV Genres](https://developer.themoviedb.org/reference/genre-tv-list) — `tvGenres(language:)`

### Keywords

- [Keyword Details](https://developer.themoviedb.org/reference/keyword-details) — `keywordDetails(id:)`
- [Keyword Movies](https://developer.themoviedb.org/reference/keyword-movies) — `keywordMovies(id:page:includeAdult:language:region:)`

### Movies

- [Movie Details](https://developer.themoviedb.org/reference/movie-details) — `movieDetails(id:language:)`
- [Alternative Titles](https://developer.themoviedb.org/reference/movie-alternative-titles) — `alternativeMovieTitles(id:)`
- [Changes](https://developer.themoviedb.org/reference/movie-changes) — `movieChanges(id:startDate:endDate:page:)`
- [Credits](https://developer.themoviedb.org/reference/movie-credits) — `movieCredits(id:language:)`
- [External IDs](https://developer.themoviedb.org/reference/movie-external-ids) — `movieExternalIDs(id:)`
- [Images](https://developer.themoviedb.org/reference/movie-images) — `movieImages(id:language:)`
- [Keywords](https://developer.themoviedb.org/reference/movie-keywords) — `movieKeywords(id:)`
- [Latest](https://developer.themoviedb.org/reference/movie-latest-id) — `latestMovie(language:)`
- [Now Playing](https://developer.themoviedb.org/reference/movie-now-playing-list) — `moviesNowPlaying(page:language:region:)`
- [Popular](https://developer.themoviedb.org/reference/movie-popular-list) — `popularMovies(page:language:region:)`
- [Recommendations](https://developer.themoviedb.org/reference/movie-recommendations) — `movieRecommendations(id:page:language:)`
- [Release Dates](https://developer.themoviedb.org/reference/movie-release-dates) — `movieReleaseDates(id:)`
- [Reviews](https://developer.themoviedb.org/reference/movie-reviews) — `movieReviews(id:page:language:)`
- [Similar](https://developer.themoviedb.org/reference/movie-similar) — `similarMovies(id:page:language:)`
- [Top Rated](https://developer.themoviedb.org/reference/movie-top-rated-list) — `topRatedMovies(page:language:region:)`
- [Translations](https://developer.themoviedb.org/reference/movie-translations) — `movieTranslations(id:)`
- [Upcoming](https://developer.themoviedb.org/reference/movie-upcoming-list) — `upcomingMovies(page:language:region:)`
- [Videos](https://developer.themoviedb.org/reference/movie-videos) — `movieVideos(id:language:)`
- [Watch Providers](https://developer.themoviedb.org/reference/movie-watch-providers) — `movieWatchProviders(id:)`

### Networks

- [Network Details](https://developer.themoviedb.org/reference/network-details) — `networkDetails(id:)`
- [Network Images](https://developer.themoviedb.org/reference/network-images) — `networkImages(id:)`

### People

- [Person Details](https://developer.themoviedb.org/reference/person-details) — `personDetails(id:language:)`
- [Combined Credits](https://developer.themoviedb.org/reference/person-combined-credits) — `personCombinedCredits(id:language:)`
- [External IDs](https://developer.themoviedb.org/reference/person-external-ids) — `personExternalIDs(id:)`
- [Images](https://developer.themoviedb.org/reference/person-images) — `personImages(id:)`
- [Movie Credits](https://developer.themoviedb.org/reference/person-movie-credits) — `personMovieCredits(id:language:)`
- [Popular](https://developer.themoviedb.org/reference/person-popular-list) — `popularPeople(page:language:)`
- [Translations](https://developer.themoviedb.org/reference/person-translations) — `personTranslations(id:)`
- [TV Credits](https://developer.themoviedb.org/reference/person-tv-credits) — `personTVCredits(id:language:)`

### Reviews

- [Review Details](https://developer.themoviedb.org/reference/review-details) — `reviewDetails(id:)`

### Search

- [Search Collections](https://developer.themoviedb.org/reference/search-collection) — `searchCollections(query:page:includeAdult:language:region:)`
- [Search Companies](https://developer.themoviedb.org/reference/search-company) — `searchCompanies(query:page:)`
- [Search Keywords](https://developer.themoviedb.org/reference/search-keyword) — `searchKeywords(query:page:)`
- [Search Movies](https://developer.themoviedb.org/reference/search-movie) — `searchMovies(query:page:includeAdult:year:primaryReleaseYear:language:region:)`
- [Search Multi](https://developer.themoviedb.org/reference/search-multi) — `searchMulti(query:page:includeAdult:language:)`
- [Search People](https://developer.themoviedb.org/reference/search-person) — `searchPeople(query:page:includeAdult:language:)`
- [Search TV](https://developer.themoviedb.org/reference/search-tv) — `searchTV(query:page:includeAdult:firstAirDateYear:language:)`

### Trending

- [Trending All](https://developer.themoviedb.org/reference/trending-all) — `trendingAll(timeWindow:page:language:)`
- [Trending Movies](https://developer.themoviedb.org/reference/trending-movies) — `trendingMovies(timeWindow:page:language:)`
- [Trending People](https://developer.themoviedb.org/reference/trending-people) — `trendingPeople(timeWindow:page:language:)`
- [Trending TV](https://developer.themoviedb.org/reference/trending-tv) — `trendingTV(timeWindow:page:language:)`

### TV Series

- [TV Series Details](https://developer.themoviedb.org/reference/tv-series-details) — `tvSeriesDetails(id:language:)`
- [Aggregate Credits](https://developer.themoviedb.org/reference/tv-series-aggregate-credits) — `tvSeriesAggregateCredits(id:language:)`
- [Airing Today](https://developer.themoviedb.org/reference/tv-series-airing-today-list) — `tvSeriesAiringToday(page:language:)`
- [Alternative Titles](https://developer.themoviedb.org/reference/tv-series-alternative-titles) — `alternativeTVSeriesTitles(id:)`
- [Changes](https://developer.themoviedb.org/reference/tv-series-changes) — `tvSeriesChanges(id:startDate:endDate:page:)`
- [Content Ratings](https://developer.themoviedb.org/reference/tv-series-content-ratings) — `tvSeriesContentRatings(id:)`
- [Credits](https://developer.themoviedb.org/reference/tv-series-credits) — `tvSeriesCredits(id:language:)`
- [Episode Groups](https://developer.themoviedb.org/reference/tv-series-episode-groups) — `tvSeriesEpisodeGroups(id:)`
- [External IDs](https://developer.themoviedb.org/reference/tv-series-external-ids) — `tvSeriesExternalIDs(id:)`
- [Images](https://developer.themoviedb.org/reference/tv-series-images) — `tvSeriesImages(id:language:)`
- [Keywords](https://developer.themoviedb.org/reference/tv-series-keywords) — `tvSeriesKeywords(id:)`
- [Latest](https://developer.themoviedb.org/reference/tv-series-latest-id) — `latestTVSeries(language:)`
- [On The Air](https://developer.themoviedb.org/reference/tv-series-on-the-air-list) — `tvSeriesOnTheAir(page:language:)`
- [Popular](https://developer.themoviedb.org/reference/tv-series-popular-list) — `popularTVSeries(page:language:region:)`
- [Recommendations](https://developer.themoviedb.org/reference/tv-series-recommendations) — `tvSeriesRecommendations(id:page:language:)`
- [Reviews](https://developer.themoviedb.org/reference/tv-series-reviews) — `tvSeriesReviews(id:page:language:)`
- [Screened Theatrically](https://developer.themoviedb.org/reference/tv-series-screened-theatrically) — `tvSeriesScreenedTheatrically(id:)`
- [Similar](https://developer.themoviedb.org/reference/tv-series-similar) — `similarTVSeries(id:page:language:)`
- [Top Rated](https://developer.themoviedb.org/reference/tv-series-top-rated-list) — `topRatedTVSeries(page:language:)`
- [Translations](https://developer.themoviedb.org/reference/tv-series-translations) — `tvSeriesTranslations(id:)`
- [Watch Providers](https://developer.themoviedb.org/reference/tv-series-watch-providers) — `tvSeriesWatchProviders(id:)`

### TV Seasons

- [TV Season Details](https://developer.themoviedb.org/reference/tv-season-details) — `tvSeasonDetails(seriesID:seasonNumber:language:)`
- [Aggregate Credits](https://developer.themoviedb.org/reference/tv-season-aggregate-credits) — `tvSeasonAggregateCredits(seriesID:seasonNumber:language:)`
- [Changes](https://developer.themoviedb.org/reference/tv-season-changes) — `tvSeasonChanges(seasonID:startDate:endDate:page:)`
- [Credits](https://developer.themoviedb.org/reference/tv-season-credits) — `tvSeasonCredits(seriesID:seasonNumber:language:)`
- [External IDs](https://developer.themoviedb.org/reference/tv-season-external-ids) — `tvSeasonExternalIDs(seriesID:seasonNumber:)`
- [Images](https://developer.themoviedb.org/reference/tv-season-images) — `tvSeasonImages(seriesID:seasonNumber:language:)`
- [Translations](https://developer.themoviedb.org/reference/tv-season-translations) — `tvSeasonTranslations(seriesID:seasonNumber:)`
- [Videos](https://developer.themoviedb.org/reference/tv-season-videos) — `tvSeasonVideos(seriesID:seasonNumber:language:)`
- [Watch Providers](https://developer.themoviedb.org/reference/tv-season-watch-providers) — `tvSeasonWatchProviders(seriesID:seasonNumber:)`

### TV Episodes

- [TV Episode Details](https://developer.themoviedb.org/reference/tv-episode-details) — `tvEpisodeDetails(seriesID:seasonNumber:episodeNumber:language:)`
- [Changes](https://developer.themoviedb.org/reference/tv-episode-changes) — `tvEpisodeChanges(episodeID:startDate:endDate:page:)`
- [Credits](https://developer.themoviedb.org/reference/tv-episode-credits) — `tvEpisodeCredits(seriesID:seasonNumber:episodeNumber:language:)`
- [External IDs](https://developer.themoviedb.org/reference/tv-episode-external-ids) — `tvEpisodeExternalIDs(seriesID:seasonNumber:episodeNumber:)`
- [Images](https://developer.themoviedb.org/reference/tv-episode-images) — `tvEpisodeImages(seriesID:seasonNumber:episodeNumber:language:)`
- [Translations](https://developer.themoviedb.org/reference/tv-episode-translations) — `tvEpisodeTranslations(seriesID:seasonNumber:episodeNumber:)`
- [Videos](https://developer.themoviedb.org/reference/tv-episode-videos) — `tvEpisodeVideos(seriesID:seasonNumber:episodeNumber:language:)`

### TV Episode Groups

- [Episode Group Details](https://developer.themoviedb.org/reference/tv-episode-group-details) — `episodeGroupDetails(id:)`

### Watch Providers

- [Available Regions](https://developer.themoviedb.org/reference/watch-providers-available-regions) — `watchProviderRegions(language:)`
- [Movie Providers](https://developer.themoviedb.org/reference/watch-providers-movie-list) — `movieWatchProviders(language:)`
- [TV Providers](https://developer.themoviedb.org/reference/watch-provider-tv-list) — `tvWatchProviders(language:)`

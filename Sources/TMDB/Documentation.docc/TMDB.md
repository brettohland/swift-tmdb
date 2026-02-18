# ``TMDB``

A Swift 6.2 wrapper around the TMDB API. Engineered for simplicity.

## Overview

`swift-tmdb` provides type-safe access to [The Movie Database](https://www.themoviedb.org) API using async/await and typed throws. All endpoints return mock data automatically in unit tests and SwiftUI previews via [PointFree's Dependencies](https://github.com/pointfreeco/swift-dependencies).

Supports movies, TV series, seasons, episodes, search, discover, trending, and more. See <doc:Usage> to get started.

## Topics

### Getting Started

- <doc:Usage>
- ``TMDB``
- ``TMDBConfiguration``

### Movies

- ``TMDB/movieDetails(id:language:)``
- ``TMDB/movieCredits(id:language:)``
- ``TMDB/movieImages(id:language:)``
- ``TMDB/movieVideos(id:language:)``
- ``TMDB/movieReviews(id:page:language:)``
- ``TMDB/movieKeywords(id:)``
- ``TMDB/similarMovies(id:page:language:)``
- ``TMDB/movieRecommendations(id:page:language:)``
- ``TMDB/movieReleaseDates(id:)``
- ``TMDB/movieExternalIDs(id:)``
- ``TMDB/movieTranslations(id:)``
- ``TMDB/movieWatchProviders(id:)``
- ``TMDB/movieChanges(id:startDate:endDate:page:)``
- ``TMDB/alternativeMovieTitles(id:)``
- ``TMDB/alternativeMovieTitles(movie:)``
- ``TMDB/latestMovie(language:)``
- ``TMDB/moviesNowPlaying(page:language:region:)``
- ``TMDB/popularMovies(page:language:region:)``
- ``TMDB/topRatedMovies(page:language:region:)``
- ``TMDB/upcomingMovies(page:language:region:)``

### TV Series

- ``TMDB/tvSeriesDetails(id:)``
- ``TMDB/tvSeriesCredits(id:)``
- ``TMDB/tvSeriesAggregateCredits(id:)``
- ``TMDB/tvSeriesImages(id:)``
- ``TMDB/tvSeriesVideos(id:)``
- ``TMDB/tvSeriesReviews(id:page:language:)``
- ``TMDB/tvSeriesKeywords(id:)``
- ``TMDB/similarTVSeries(id:page:language:)``
- ``TMDB/tvSeriesRecommendations(id:page:language:)``
- ``TMDB/alternativeTVSeriesTitles(id:)``
- ``TMDB/tvSeriesContentRatings(id:)``
- ``TMDB/tvSeriesEpisodeGroups(id:)``
- ``TMDB/tvSeriesExternalIDs(id:)``
- ``TMDB/tvSeriesTranslations(id:)``
- ``TMDB/tvSeriesWatchProviders(id:)``
- ``TMDB/tvSeriesScreenedTheatrically(id:)``
- ``TMDB/tvSeriesChanges(id:startDate:endDate:page:)``
- ``TMDB/latestTVSeries(language:)``
- ``TMDB/tvSeriesAiringToday(page:language:region:)``
- ``TMDB/tvSeriesOnTheAir(page:language:region:)``
- ``TMDB/popularTVSeries(page:language:region:)``
- ``TMDB/topRatedTVSeries(page:language:region:)``

### TV Seasons

- ``TMDB/tvSeasonDetails(seriesID:seasonNumber:)``
- ``TMDB/tvSeasonCredits(seriesID:seasonNumber:)``
- ``TMDB/tvSeasonAggregateCredits(seriesID:seasonNumber:)``
- ``TMDB/tvSeasonExternalIDs(seriesID:seasonNumber:)``
- ``TMDB/tvSeasonImages(seriesID:seasonNumber:)``
- ``TMDB/tvSeasonTranslations(seriesID:seasonNumber:)``
- ``TMDB/tvSeasonVideos(seriesID:seasonNumber:)``
- ``TMDB/tvSeasonWatchProviders(seriesID:seasonNumber:)``
- ``TMDB/tvSeasonChanges(seasonID:startDate:endDate:page:)``

### TV Episodes

- ``TMDB/tvEpisodeDetails(seriesID:seasonNumber:episodeNumber:)``
- ``TMDB/tvEpisodeCredits(seriesID:seasonNumber:episodeNumber:)``
- ``TMDB/tvEpisodeExternalIDs(seriesID:seasonNumber:episodeNumber:)``
- ``TMDB/tvEpisodeImages(seriesID:seasonNumber:episodeNumber:)``
- ``TMDB/tvEpisodeTranslations(seriesID:seasonNumber:episodeNumber:)``
- ``TMDB/tvEpisodeVideos(seriesID:seasonNumber:episodeNumber:)``
- ``TMDB/tvEpisodeChanges(episodeID:startDate:endDate:page:)``
- ``TMDB/episodeGroupDetails(id:)``

### Search

- ``TMDB/searchMovies(query:page:includeAdult:year:primaryReleaseYear:language:region:)``
- ``TMDB/searchTV(query:page:includeAdult:firstAirDateYear:language:)``
- ``TMDB/searchPeople(query:page:includeAdult:language:)``
- ``TMDB/searchMulti(query:page:includeAdult:language:)``
- ``TMDB/searchCollections(query:page:includeAdult:language:region:)``
- ``TMDB/searchCompanies(query:page:)``
- ``TMDB/searchKeywords(query:page:)``

### Discover

- ``TMDB/discoverMovie(filters:)``
- ``TMDB/discoverMovie()``
- ``TMDB/discoverTV(filters:)``
- ``TMDB/discoverTV()``

### Trending

- ``TMDB/trendingAll(timeWindow:page:language:)``
- ``TMDB/trendingMovies(timeWindow:page:language:)``
- ``TMDB/trendingTV(timeWindow:page:language:)``
- ``TMDB/trendingPeople(timeWindow:page:language:)``

### Find

- ``TMDB/find(externalID:source:language:)``

### Collections

- ``TMDB/collectionDetails(id:language:)``
- ``TMDB/collectionImages(id:language:)``

### Keywords

- ``TMDB/keywordDetails(id:)``
- ``TMDB/keywordMovies(id:page:includeAdult:language:region:)``

### Reviews

- ``TMDB/reviewDetails(id:)``

### Credits

- ``TMDB/credits(forID:)``
- ``TMDB/credits(forMovie:)``

### Configuration

- ``TMDB/configurationDetails()``
- ``TMDB/supportedCountries()``
- ``TMDB/jobDepartments()``
- ``TMDB/supportedLanguages()``
- ``TMDB/primaryTranslations()``
- ``TMDB/timezones()``

### Certifications

- ``TMDB/movieCertifications()``
- ``TMDB/tvCertifications()``

### Genres

- ``TMDB/movieGenres(language:)``
- ``TMDB/tvGenres(language:)``

### Watch Providers

- ``TMDB/watchProviderRegions(language:)``
- ``TMDB/movieWatchProviders(language:)``
- ``TMDB/tvWatchProviders(language:)``

### Errors

- ``TMDBAPIError``
- ``TMDBInitializationError``
- ``TMDBRequestError``

### Movie Response Types

- ``TMDB/Movie``
- ``TMDB/MediaCredits``
- ``TMDB/ImageCollection``
- ``TMDB/VideoCollection``
- ``TMDB/AlternativeTitle``
- ``TMDB/Keyword``
- ``TMDB/ReleaseDateResult``
- ``TMDB/ExternalIDs``
- ``TMDB/TranslationCollection``
- ``TMDB/MediaWatchProviderResult``
- ``TMDB/ChangeCollection``
- ``TMDB/CastMember``
- ``TMDB/CrewMember``

### TV Response Types

- ``TMDB/TVSeries``
- ``TMDB/TVSeason``
- ``TMDB/TVEpisode``
- ``TMDB/AggregateCredits``
- ``TMDB/ContentRating``
- ``TMDB/EpisodeGroup``
- ``TMDB/EpisodeGroupDetails``
- ``TMDB/ScreenedTheatricallyResult``

### Search Response Types

- ``TMDB/MultiSearchResult``
- ``TMDB/SearchPerson``
- ``TMDB/SearchCollection``
- ``TMDB/SearchCompany``

### Trending Response Types

- ``TMDB/TrendingResult``
- ``TMDB/TrendingPerson``

### Pagination

- ``TMDB/Discover/PaginatedResponse``
- ``TMDB/Discover/DatedPaginatedResponse``
- ``Discoverable``

### Discover Filters

- ``TMDB/Discover/MovieFilter``
- ``TMDB/Discover/TVFilter``
- ``TMDB/Discover/SortOption``
- ``TMDB/Discover/SortOptionOrder``
- ``TMDB/Discover/LogicalOperator``
- ``TMDB/Discover/MonetizationType``
- ``TMDB/Discover/MediaReleaseType``
- ``TMDB/Discover/TVReleaseStatus``

### Discover Response Types

- ``TMDB/Discover/DiscoverMovie``
- ``TMDB/Discover/DiscoverTV``

### Configuration Response Types

- ``TMDB/ConfigurationResponse``
- ``TMDB/Configuration/ImageConfiguration``
- ``TMDB/Configuration/ImageSize``
- ``TMDB/Configuration/ChangeKey``
- ``TMDB/Configuration/JobDepartment``
- ``TMDB/Configuration/Language``
- ``TMDB/Configuration/Timezone``

### Other Response Types

- ``TMDB/Review``
- ``TMDB/FindResult``
- ``TMDB/Collection``
- ``TMDB/Genre``
- ``TMDB/GenreList``
- ``TMDB/Certification``
- ``TMDB/MovieCertifications``
- ``TMDB/TVCertifications``
- ``TMDB/WatchProvider``
- ``TMDB/WatchProviderRegion``
- ``TMDB/Credits/Details``
- ``TMDB/ProductionCompany``
- ``TMDB/TitleCollection``

### Supporting Types

- ``TMDB/TrendingTimeWindow``
- ``TMDB/ExternalSource``

### Codable Property Wrappers

- ``EmptyStringNullable``
- ``ISO8601YMD``
- ``LanguageArray``
- ``LanguageCode``
- ``Minutes``
- ``NilBoolean``
- ``NilCodableArray``
- ``NilInteger``
- ``RegionArray``
- ``RegionCode``

### Format Styles

- ``Runtime``

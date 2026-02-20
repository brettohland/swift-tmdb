# ``TMDB``

A Swift 6.2 wrapper around the TMDB API. Engineered for simplicity.

## Overview

`swift-tmdb` provides type-safe access to [The Movie Database](https://www.themoviedb.org) API using async/await and typed throws. All endpoints return mock data automatically in unit tests and SwiftUI previews via [PointFree's Dependencies](https://github.com/pointfreeco/swift-dependencies).

Supports movies, TV series, seasons, episodes, search, discover, trending, authentication, account management, lists, guest sessions, and more. See <doc:Usage> to get started.

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

- ``TMDB/tvSeriesDetails(id:language:)``
- ``TMDB/tvSeriesCredits(id:language:)``
- ``TMDB/tvSeriesAggregateCredits(id:language:)``
- ``TMDB/tvSeriesImages(id:language:)``
- ``TMDB/tvSeriesVideos(id:language:)``
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
- ``TMDB/tvSeriesAiringToday(page:language:)``
- ``TMDB/tvSeriesOnTheAir(page:language:)``
- ``TMDB/popularTVSeries(page:language:region:)``
- ``TMDB/topRatedTVSeries(page:language:)``

### TV Seasons

- ``TMDB/tvSeasonDetails(seriesID:seasonNumber:language:)``
- ``TMDB/tvSeasonCredits(seriesID:seasonNumber:language:)``
- ``TMDB/tvSeasonAggregateCredits(seriesID:seasonNumber:language:)``
- ``TMDB/tvSeasonExternalIDs(seriesID:seasonNumber:)``
- ``TMDB/tvSeasonImages(seriesID:seasonNumber:language:)``
- ``TMDB/tvSeasonTranslations(seriesID:seasonNumber:)``
- ``TMDB/tvSeasonVideos(seriesID:seasonNumber:language:)``
- ``TMDB/tvSeasonWatchProviders(seriesID:seasonNumber:)``
- ``TMDB/tvSeasonChanges(seasonID:startDate:endDate:page:)``

### TV Episodes

- ``TMDB/tvEpisodeDetails(seriesID:seasonNumber:episodeNumber:language:)``
- ``TMDB/tvEpisodeCredits(seriesID:seasonNumber:episodeNumber:language:)``
- ``TMDB/tvEpisodeExternalIDs(seriesID:seasonNumber:episodeNumber:)``
- ``TMDB/tvEpisodeImages(seriesID:seasonNumber:episodeNumber:language:)``
- ``TMDB/tvEpisodeTranslations(seriesID:seasonNumber:episodeNumber:)``
- ``TMDB/tvEpisodeVideos(seriesID:seasonNumber:episodeNumber:language:)``
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

### People

- ``TMDB/personDetails(id:language:)``
- ``TMDB/personMovieCredits(id:language:)``
- ``TMDB/personTVCredits(id:language:)``
- ``TMDB/personCombinedCredits(id:language:)``
- ``TMDB/personExternalIDs(id:)``
- ``TMDB/personImages(id:)``
- ``TMDB/personTranslations(id:)``
- ``TMDB/popularPeople(page:language:)``

### Companies

- ``TMDB/companyDetails(id:)``
- ``TMDB/companyImages(id:)``

### Networks

- ``TMDB/networkDetails(id:)``
- ``TMDB/networkImages(id:)``

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

### Authentication

- ``TMDB/createRequestToken(redirectTo:)``
- ``TMDB/createAccessToken(requestToken:)``
- ``TMDB/deleteAccessToken(_:)``
- ``TMDB/convertToV3Session(accessToken:)``
- ``TMDB/deleteV3Session(sessionID:)``
- ``TMDB/AuthenticationCoordinator``

### Account

- ``TMDB/accountLists(page:)``
- ``TMDB/favoriteMovies(sortBy:page:language:)``
- ``TMDB/favoriteTVSeries(sortBy:page:language:)``
- ``TMDB/ratedMovies(sortBy:page:language:)``
- ``TMDB/ratedTVSeries(sortBy:page:language:)``
- ``TMDB/accountMovieRecommendations(page:language:)``
- ``TMDB/accountTVRecommendations(page:language:)``
- ``TMDB/watchlistMovies(page:)``
- ``TMDB/watchlistTVSeries(page:)``
- ``TMDB/setFavorite(mediaType:mediaID:favorite:)``
- ``TMDB/setWatchlist(mediaType:mediaID:watchlist:)``
- ``TMDB/rateMovie(id:rating:)``
- ``TMDB/deleteMovieRating(id:)``
- ``TMDB/rateTVSeries(id:rating:)``
- ``TMDB/deleteTVSeriesRating(id:)``
- ``TMDB/rateTVEpisode(seriesID:seasonNumber:episodeNumber:rating:)``
- ``TMDB/deleteTVEpisodeRating(seriesID:seasonNumber:episodeNumber:)``

### Lists

- ``TMDB/listDetails(listID:page:sortBy:)``
- ``TMDB/listItemStatus(listID:mediaType:mediaID:)``
- ``TMDB/createList(name:description:languageCode:regionCode:isPublic:)``
- ``TMDB/updateList(listID:name:description:isPublic:sortBy:)``
- ``TMDB/deleteList(listID:)``
- ``TMDB/addItemsToList(listID:items:)``
- ``TMDB/updateListItems(listID:items:)``
- ``TMDB/removeItemsFromList(listID:items:)``
- ``TMDB/clearList(listID:)``

### Guest Sessions

- ``TMDB/createGuestSession()``
- ``TMDB/guestRatedMovies(sessionID:sortBy:page:language:)``
- ``TMDB/guestRatedTV(sessionID:sortBy:page:language:)``
- ``TMDB/guestRatedEpisodes(sessionID:sortBy:page:language:)``
- ``TMDB/guestRateMovie(id:rating:guestSessionID:)``
- ``TMDB/guestDeleteMovieRating(id:guestSessionID:)``
- ``TMDB/guestRateTVSeries(id:rating:guestSessionID:)``
- ``TMDB/guestDeleteTVSeriesRating(id:guestSessionID:)``
- ``TMDB/guestRateTVEpisode(seriesID:seasonNumber:episodeNumber:rating:guestSessionID:)``
- ``TMDB/guestDeleteTVEpisodeRating(seriesID:seasonNumber:episodeNumber:guestSessionID:)``

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

### People Response Types

- ``TMDB/Person``
- ``TMDB/Person/Gender``
- ``TMDB/PersonMovieCredits``
- ``TMDB/PersonTVCredits``
- ``TMDB/PersonCombinedCredits``
- ``TMDB/PersonImages``
- ``TMDB/PopularPerson``

### Company & Network Response Types

- ``TMDB/Company``
- ``TMDB/Network``
- ``TMDB/LogoCollection``

### Search Response Types

- ``TMDB/MultiSearchResult``
- ``TMDB/SearchPerson``
- ``TMDB/SearchCollection``
- ``TMDB/SearchCompany``

### Trending Response Types

- ``TMDB/TrendingResult``
- ``TMDB/TrendingPerson``

### Auth Response Types

- ``TMDB/Auth``
- ``TMDB/Auth/RequestToken``
- ``TMDB/Auth/AccessToken``
- ``TMDB/Auth/V3Session``
- ``TMDB/Auth/DeleteResult``
- ``TMDB/Auth/GuestSession``
- ``TMDB/AuthSession``

### Account Response Types

- ``TMDB/Account``
- ``TMDB/Account/SortOrder``
- ``TMDB/Account/MediaType``
- ``TMDB/Account/AccountList``
- ``TMDB/Account/RatedMovie``
- ``TMDB/Account/RatedTV``
- ``TMDB/Account/AccountRating``
- ``TMDB/Account/WriteResult``

### List Response Types

- ``TMDB/List``
- ``TMDB/List/Details``
- ``TMDB/List/Item``
- ``TMDB/List/Creator``
- ``TMDB/List/ItemStatus``
- ``TMDB/List/CreateResult``
- ``TMDB/List/ItemsResult``
- ``TMDB/List/ItemResult``

### Guest Session Response Types

- ``TMDB/GuestSession``
- ``TMDB/GuestSession/RatedMovie``
- ``TMDB/GuestSession/RatedTV``
- ``TMDB/GuestSession/RatedEpisode``

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
- ``TMDB/ImageConfiguration``
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

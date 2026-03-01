# Discover Filters

Build type-safe, composable queries for the TMDB Discover endpoint.

## Overview

The Discover endpoint supports complex filtering through ``TMDB/Discover/MovieFilter`` and ``TMDB/Discover/TVFilter``. Filters are passed as variadic arguments — combine as many as you need.

## Basic Usage

```swift
// Discover popular action movies
let results = try await TMDB.discoverMovie(
    filters:
    .withGenres([.and("28")]),
    .sortBy(.popularity, .descending)
)

// Discover no filters (returns default results)
let defaults = try await TMDB.discoverMovie()
```

## Logical Operators

Some filters accept arrays of ``TMDB/Discover/LogicalOperator`` values. Use `.and()` for "all of these" and `.or()` for "any of these".

```swift
// Movies in BOTH Action (28) AND Comedy (35) genres
// Query: with_genres=28,35
.withGenres([.and("28"), .and("35")])

// Movies in EITHER Action (28) OR Comedy (35)
// Query: with_genres=28|35
.withGenres([.or("28"), .or("35")])
```

## Movie Filters

All cases on ``TMDB/Discover/MovieFilter``:

| Category | Filters |
|----------|---------|
| **Sorting** | `sortBy` |
| **Pagination** | `page`, `language`, `region` |
| **Dates** | `primaryReleaseDateGreaterThan`, `primaryReleaseDateLessThan`, `releaseDateGreaterThan`, `releaseDateLessThan`, `primaryReleaseYear`, `year` |
| **Ratings** | `voteAverageGreaterThan`, `voteAverageLessThan`, `voteCountGreaterThan`, `voteCountLessThan` |
| **Genres** | `withGenres`, `withoutGenres` |
| **Keywords** | `withKeywords`, `withoutKeywords` |
| **Cast & Crew** | `withCast`, `withCrew`, `withPeople` |
| **Companies** | `withCompanies`, `withoutCompanies` |
| **Certification** | `certification`, `certificationCountry`, `certificationGreaterThan`, `certificationLessThan` |
| **Release Type** | `withReleaseType` |
| **Runtime** | `withRuntimeGreaterThan`, `withRuntimeLessThan` |
| **Watch** | `withWatchProviders`, `withWatchMonetizationTypes`, `watchRegion` |
| **Content** | `includeAdult`, `includeVideo` |
| **Origin** | `withOriginCountry`, `withOriginalLanguage` |

## TV Filters

All cases on ``TMDB/Discover/TVFilter``:

| Category | Filters |
|----------|---------|
| **Sorting** | `sortBy` |
| **Pagination** | `page`, `language` |
| **Air Dates** | `airDateGreaterThan`, `airDateLessThan`, `firstAirDateGreaterThan`, `firstAirDateLessThan`, `firstAirDateYear`, `includeNullFirstAirDates` |
| **Ratings** | `voteAverageGreaterThan`, `voteAverageLessThan`, `voteCountGreaterThan`, `voteCountLessThan` |
| **Genres** | `withGenres`, `withoutGenres` |
| **Keywords** | `withKeywords`, `withoutKeywords` |
| **Networks** | `withNetworks` |
| **Companies** | `withCompanies`, `withoutCompanies` |
| **Status** | `withStatus`, `withType` |
| **Runtime** | `withRuntimeGreaterThan`, `withRuntimeLessThan` |
| **Watch** | `withWatchProviders`, `withWatchMonetizationTypes`, `watchRegion` |
| **Content** | `includeAdult`, `screenedTheatrically` |
| **Origin** | `withOriginCountry`, `withOriginalLanguage`, `timezone` |

## Combining Filters

Build complex queries by combining multiple filters:

```swift
// Highly-rated sci-fi movies from 2024 with a runtime over 2 hours
let results = try await TMDB.discoverMovie(
    filters:
    .withGenres([.and("878")]),
    .primaryReleaseYear(2024),
    .voteAverageGreaterThan(7.0),
    .voteCountGreaterThan(100),
    .withRuntimeGreaterThan(120),
    .sortBy(.voteAverage, .descending)
)
```

```swift
// TV series currently airing with high ratings
let tvResults = try await TMDB.discoverTV(
    filters:
    .withStatus([.and(.returningSeries)]),
    .voteAverageGreaterThan(8.0),
    .sortBy(.popularity, .descending)
)
```

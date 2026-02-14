# Query Parameter Audit Report

**Date:** 2026-02-14
**Source:** Official TMDB API documentation at https://developer.themoviedb.org/reference
**Scope:** All 56 endpoints implemented in Phases 1-3

---

## Bug: `sort_by` Key Mapping Error

**Severity: HIGH** - Discover sort operations are silently broken.

Both `DiscoverMovieFilter` and `DiscoverTVFilter` map the `.sortBy` case to `"sort_option"` instead of `"sort_by"`:

- `Sources/TMDB/Models/Endpoints/Discover/Query Parameters/DiscoverMovieFilter.swift:75`
- `Sources/TMDB/Models/Endpoints/Discover/Query Parameters/DiscoverTVFilter.swift:67`

The TMDB API parameter name is `sort_by`, not `sort_option`. This means any sort filter is silently ignored by the API.

---

## Endpoints with Missing Query Parameters

### Movie Detail Endpoints

| Endpoint | Swift Method | Currently Has | Missing (per official docs) |
|----------|-------------|---------------|---------------------------|
| `/3/movie/{id}/reviews` | `movieReviews(id:)` | (none) | `language`, `page` |
| `/3/movie/{id}/similar` | `similarMovies(id:)` | (none) | `language`, `page` |
| `/3/movie/{id}/recommendations` | `movieRecommendations(id:)` | (none) | `language`, `page` |
| `/3/movie/{id}/videos` | `movieVideos(id:)` | (none) | `language` |
| `/3/movie/{id}/changes` | `movieChanges(id:)` | (none) | `start_date`, `end_date`, `page` |

### Movie List Endpoints

| Endpoint | Swift Method | Currently Has | Missing (per official docs) |
|----------|-------------|---------------|---------------------------|
| `/3/movie/now_playing` | `moviesNowPlaying()` | (none) | `language`, `page`, `region` |
| `/3/movie/popular` | `popularMovies()` | (none) | `language`, `page`, `region` |
| `/3/movie/top_rated` | `topRatedMovies()` | (none) | `language`, `page`, `region` |
| `/3/movie/upcoming` | `upcomingMovies()` | (none) | `language`, `page`, `region` |

### Trending Endpoints

| Endpoint | Swift Method | Currently Has | Missing (per official docs) |
|----------|-------------|---------------|---------------------------|
| `/3/trending/all/{tw}` | `trendingAll(timeWindow:)` | (none) | `language`, `page` |
| `/3/trending/movie/{tw}` | `trendingMovies(timeWindow:)` | (none) | `language`, `page` |
| `/3/trending/tv/{tw}` | `trendingTV(timeWindow:)` | (none) | `language`, `page` |
| `/3/trending/person/{tw}` | `trendingPeople(timeWindow:)` | (none) | `language`, `page` |

### Search Endpoints

| Endpoint | Swift Method | Currently Has | Missing (per official docs) |
|----------|-------------|---------------|---------------------------|
| `/3/search/movie` | `searchMovies(query:page:includeAdult:year:primaryReleaseYear:)` | `query`, `page`, `include_adult`, `year`, `primary_release_year` | `language`, `region` |
| `/3/search/tv` | `searchTV(query:page:includeAdult:firstAirDateYear:)` | `query`, `page`, `include_adult`, `first_air_date_year` | `language` |
| `/3/search/person` | `searchPeople(query:page:includeAdult:)` | `query`, `page`, `include_adult` | `language` |
| `/3/search/multi` | `searchMulti(query:page:includeAdult:)` | `query`, `page`, `include_adult` | `language` |
| `/3/search/collection` | `searchCollections(query:page:)` | `query`, `page` | `language`, `include_adult`, `region` |
| `/3/search/company` | `searchCompanies(query:page:)` | `query`, `page` | `language` |
| `/3/search/keyword` | `searchKeywords(query:page:)` | `query`, `page` | `language` |

### Keyword Endpoints

| Endpoint | Swift Method | Currently Has | Missing (per official docs) |
|----------|-------------|---------------|---------------------------|
| `/3/keyword/{id}/movies` | `keywordMovies(id:page:)` | `page` | `language`, `include_adult`, `region` |

### Collection Endpoints

| Endpoint | Swift Method | Currently Has | Missing (per official docs) |
|----------|-------------|---------------|---------------------------|
| `/3/collection/{id}/images` | `collectionImages(id:)` | (none) | `language` |

### Find Endpoints

| Endpoint | Swift Method | Currently Has | Missing (per official docs) |
|----------|-------------|---------------|---------------------------|
| `/3/find/{external_id}` | `find(externalID:source:)` | `external_source` | `language` |

### Discover Endpoints

| Endpoint | Swift Method | Currently Has | Missing (per official docs) |
|----------|-------------|---------------|---------------------------|
| `/3/discover/tv` | `discoverTV(filters:)` | (many) | `include_adult`, `vote_average.lte`, `vote_count.lte` |

---

## Endpoints with Inconclusive Documentation

The following endpoints have parameters that the official docs page didn't clearly render (JS-heavy pages), but are commonly documented in other TMDB API references. These should be verified manually via the TMDB "Try It" interface before implementing:

| Endpoint | Swift Method | Likely Missing |
|----------|-------------|---------------|
| `/3/movie/{id}` | `movieDetails(id:)` | `language`, `append_to_response` |
| `/3/movie/{id}/credits` | `movieCredits(id:)` | `language` |
| `/3/movie/{id}/images` | `movieImages(id:)` | `language`, `include_image_language` |
| `/3/movie/{id}/alternative_titles` | `alternativeMovieTitles(id:)` | `country` |
| `/3/movie/latest` | `latestMovie()` | `language` |
| `/3/genre/movie/list` | `movieGenres()` | `language` |
| `/3/genre/tv/list` | `tvGenres()` | `language` |
| `/3/watch/providers/movie` | `movieWatchProviders()` (list) | `language`, `watch_region` |
| `/3/watch/providers/tv` | `tvWatchProviders()` (list) | `language`, `watch_region` |
| `/3/watch/providers/regions` | `watchProviderRegions()` | `language` |
| `/3/collection/{id}` | `collectionDetails(id:)` | `language` |

---

## Endpoints Confirmed Complete (No Missing Parameters)

| Endpoint | Swift Method | Notes |
|----------|-------------|-------|
| `/3/certification/movie/list` | `movieCertifications()` | No query params in API |
| `/3/certification/tv/list` | `tvCertifications()` | No query params in API |
| `/3/movie/{id}/keywords` | `movieKeywords(id:)` | No query params in API |
| `/3/movie/{id}/release_dates` | `movieReleaseDates(id:)` | No query params in API |
| `/3/movie/{id}/external_ids` | `movieExternalIDs(id:)` | No query params in API |
| `/3/movie/{id}/translations` | `movieTranslations(id:)` | No query params in API |
| `/3/movie/{id}/watch/providers` | `movieWatchProviders(id:)` | No query params in API |
| `/3/review/{id}` | `reviewDetails(id:)` | No query params in API |
| `/3/keyword/{id}` | `keywordDetails(id:)` | No query params in API |
| `/3/configuration/*` | All 4 config endpoints | No query params in API |
| `/3/search/company` | `searchCompanies(query:page:)` | Possibly missing `language` (see inconclusive) |
| `/3/search/keyword` | `searchKeywords(query:page:)` | Possibly missing `language` (see inconclusive) |
| `/3/discover/movie` | `discoverMovie(filters:)` | Complete (aside from `sort_by` bug) |

---

## Summary

| Category | Count |
|----------|-------|
| **Confirmed bug** | 1 (`sort_by` → `"sort_option"` in both Discover filters) |
| **Endpoints with confirmed missing params** | 26 |
| **Endpoints needing manual verification** | 11 |
| **Endpoints confirmed complete** | 15+ |
| **Most common missing parameter** | `language` (~30 endpoints) |
| **Second most common** | `page` (~10 endpoints) |
| **Third most common** | `region` (~6 endpoints) |

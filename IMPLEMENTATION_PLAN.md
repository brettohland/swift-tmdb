# TMDB API v3 Read-Only Endpoints - Implementation Plan

**Status:** Phase 3.5 Complete ✅ | Phase 4 Next
**Last Updated:** 2026-02-18
**Target:** 110 total endpoints (9 existing + 101 new)

---

## Table of Contents
1. [Progress Overview](#progress-overview)
2. [Phase 1: Foundation & Configuration](#phase-1-foundation--configuration-complete-)
3. [Phase 2: Movies - Complete Coverage](#phase-2-movies---complete-coverage-complete-)
4. [Phase 3: Search & Discovery](#phase-3-search--discovery-complete-)
5. [Phase 3.5: Language, Region & Missing Query Parameters](#phase-35-language-region--missing-query-parameters)
6. [Phase 4: TV Shows - Complete Coverage](#phase-4-tv-shows---complete-coverage)
7. [Phase 5: People & Supporting Features](#phase-5-people--supporting-features)
8. [Implementation Patterns](#implementation-patterns)
9. [Lessons Learned](#lessons-learned)

---

## Progress Overview

| Phase | Endpoints | Status | Target Release |
|-------|-----------|--------|----------------|
| **Current** | 9 | ✅ Complete | v0.1.0 (shipped) |
| **Phase 1** | 15 | ✅ Complete | v0.2.0 (ready) |
| **Phase 2** | 20 | ✅ Complete | v0.3.0 (ready) |
| **Phase 3** | 12 | ✅ Complete | v0.4.0 (ready) |
| **Phase 3.5** | — | ✅ Complete | v0.4.1 (ready) |
| **Phase 4** | 41 | 📋 Next | v0.5.0 |
| **Phase 5** | 13 | ⏳ Planned | v0.6.0 |
| **Total** | **110** | **56/110 (51%)** | |

---

## Phase 1: Foundation & Configuration (COMPLETE ✅)

**Completed:** 2026-02-07
**Endpoints Implemented:** 15
**Tests Added:** 31 (all passing)

### Implemented Endpoints

#### Configuration (4 endpoints)
- ✅ `GET /3/configuration/jobs` → `TMDB.jobDepartments()`
- ✅ `GET /3/configuration/languages` → `TMDB.supportedLanguages()`
- ✅ `GET /3/configuration/primary_translations` → `TMDB.primaryTranslations()`
- ✅ `GET /3/configuration/timezones` → `TMDB.timezones()`

#### Certifications (2 endpoints)
- ✅ `GET /3/certification/movie/list` → `TMDB.movieCertifications()`
- ✅ `GET /3/certification/tv/list` → `TMDB.tvCertifications()`

#### Genres (2 endpoints)
- ✅ `GET /3/genre/movie/list` → `TMDB.movieGenres()`
- ✅ `GET /3/genre/tv/list` → `TMDB.tvGenres()`

#### Trending (4 endpoints)
- ✅ `GET /3/trending/all/{time_window}` → `TMDB.trendingAll(timeWindow:)`
- ✅ `GET /3/trending/movie/{time_window}` → `TMDB.trendingMovies(timeWindow:)`
- ✅ `GET /3/trending/tv/{time_window}` → `TMDB.trendingTV(timeWindow:)`
- ✅ `GET /3/trending/person/{time_window}` → `TMDB.trendingPeople(timeWindow:)`

#### Watch Providers (3 endpoints)
- ✅ `GET /3/watch/providers/regions` → `TMDB.watchProviderRegions()`
- ✅ `GET /3/watch/providers/movie` → `TMDB.movieWatchProviders()`
- ✅ `GET /3/watch/providers/tv` → `TMDB.tvWatchProviders()`

### Files Created

**Endpoints:** 4 files
```
Sources/TMDB/Models/Endpoints/
├── Certifications/CertificationEndpoint.swift
├── Genres/GenreEndpoint.swift
├── Trending/TrendingEndpoint.swift
└── WatchProviders/WatchProviderEndpoint.swift
```

**Response Models:** 12 files
```
Sources/TMDB/Models/Responses/Public/3/
├── Configuration/
│   ├── JobDepartment.swift
│   ├── Language.swift
│   └── Timezone.swift
├── Certification/
│   ├── Certification.swift
│   ├── MovieCertifications.swift
│   └── TVCertifications.swift
├── Trending/
│   ├── TrendingResult.swift
│   └── TrendingPerson.swift
├── WatchProvider/
│   ├── WatchProvider.swift
│   └── WatchProviderRegion.swift
└── GenreList.swift
```

**Mock Data:** 13 JSON files
```
Sources/TMDB/Services/MockingService/JSON/
├── Configuration/ (4 files)
├── Certification/ (2 files)
├── Genres/ (2 files)
├── Trending/ (4 files)
└── WatchProviders/ (3 files)
```

**Mock Conformances:** 5 files
```
Sources/TMDB/Services/MockingService/Extensions/
├── Certification+MockableResponse.swift
├── Genres+MockableResponse.swift
├── Trending+MockableResponse.swift
└── WatchProviders+MockableResponse.swift
```

**Tests:** 5 test files
```
Tests/TMDBTests/Endpoint Tests/
├── Certifications/CertificationEndpointTests.swift
├── Genres/GenreEndpointTests.swift
├── Trending/TrendingEndpointTests.swift
└── WatchProviders/WatchProviderEndpointTests.swift
```

### Key Accomplishments
- ✅ Extended Configuration endpoints from 2 to 6
- ✅ Established patterns for all remaining phases
- ✅ Fixed `RegionCode` property wrapper to be `Sendable`
- ✅ Implemented custom Codable for `TrendingResult` to handle optional dates
- ✅ All 31 tests passing
- ✅ Build successful with no warnings

---

## Phase 2: Movies - Complete Coverage (COMPLETE ✅)

**Completed:** 2026-02-08
**Endpoints Implemented:** 20
**Tests Added:** 19 (49 total, all passing)

### Implemented Endpoints

#### Movie Details (15 endpoints)
- ✅ `GET /3/movie/{id}/credits` → `TMDB.movieCredits(id:)`
- ✅ `GET /3/movie/{id}/images` → `TMDB.movieImages(id:)`
- ✅ `GET /3/movie/{id}/videos` → `TMDB.movieVideos(id:)`
- ✅ `GET /3/movie/{id}/reviews` → `TMDB.movieReviews(id:)`
- ✅ `GET /3/movie/{id}/keywords` → `TMDB.movieKeywords(id:)`
- ✅ `GET /3/movie/{id}/similar` → `TMDB.similarMovies(id:)`
- ✅ `GET /3/movie/{id}/recommendations` → `TMDB.movieRecommendations(id:)`
- ✅ `GET /3/movie/{id}/release_dates` → `TMDB.movieReleaseDates(id:)`
- ✅ `GET /3/movie/{id}/external_ids` → `TMDB.movieExternalIDs(id:)`
- ✅ `GET /3/movie/{id}/translations` → `TMDB.movieTranslations(id:)`
- ✅ `GET /3/movie/{id}/watch/providers` → `TMDB.movieWatchProviders(id:)`
- ✅ `GET /3/movie/{id}/changes` → `TMDB.movieChanges(id:)`
- ✅ `GET /3/movie/{id}/alternative_titles` → `TMDB.alternativeMovieTitles(id:)`
- ✅ `GET /3/movie/latest` → `TMDB.latestMovie()`

#### Movie Lists (4 endpoints)
- ✅ `GET /3/movie/now_playing` → `TMDB.moviesNowPlaying()`
- ✅ `GET /3/movie/popular` → `TMDB.popularMovies()`
- ✅ `GET /3/movie/top_rated` → `TMDB.topRatedMovies()`
- ✅ `GET /3/movie/upcoming` → `TMDB.upcomingMovies()`

#### Supporting (1 endpoint)
- ✅ `GET /3/review/{id}` → `TMDB.reviewDetails(id:)`

### Files Created

**Endpoints:** 2 files
```
Sources/TMDB/Models/Endpoints/
├── Movies/MovieEndpoints.swift
└── Reviews/ReviewEndpoint.swift
```

**Response Models:** 14 files
```
Sources/TMDB/Models/Responses/Public/3/
├── Movie/
│   ├── AlternativeTitle.swift
│   ├── CastMember.swift
│   ├── ChangeCollection.swift
│   ├── CrewMember.swift
│   ├── ExternalIDs.swift
│   ├── ImageCollection.swift
│   ├── Keyword.swift
│   ├── Movie.swift
│   ├── MovieCredits.swift
│   ├── MovieWatchProviderResult.swift
│   ├── ReleaseDateResult.swift
│   ├── TranslationCollection.swift
│   └── VideoCollection.swift
└── Review/
    └── Review.swift
```

**Mock Data:** 20 JSON files
```
Sources/TMDB/Services/MockingService/JSON/
├── Movie/ (19 files)
│   ├── AlternativeTitles.json
│   ├── MovieChanges.json
│   ├── MovieCredits.json
│   ├── MovieDetails.json
│   ├── MovieExternalIDs.json
│   ├── MovieImages.json
│   ├── MovieKeywords.json
│   ├── MovieLatest.json
│   ├── MovieRecommendations.json
│   ├── MovieReleaseDates.json
│   ├── MovieReviews.json
│   ├── MovieTranslations.json
│   ├── MovieVideos.json
│   ├── MovieWatchProviders.json
│   ├── MoviesNowPlaying.json
│   ├── PopularMovies.json
│   ├── SimilarMovies.json
│   ├── TopRatedMovies.json
│   └── UpcomingMovies.json
└── Review/
    └── ReviewDetails.json
```

**Mock Conformances:** 2 files
```
Sources/TMDB/Services/MockingService/Extensions/
├── MovieEndpoint+MovkableResponse.swift
└── Review+MockableResponse.swift
```

**Dependency Client:** 1 file
```
Sources/TMDBDependencies/Clients/
└── MoviesClient.swift
```

**Tests:** 2 test files
```
Tests/TMDBTests/Endpoint Tests/
├── Movies/MovieEndpointTests.swift
└── Reviews/ReviewEndpointTests.swift
```

### Key Accomplishments
- ✅ 17 new response models (shared models reusable for TV in Phase 4)
- ✅ Shared `ImageCollection`, `VideoCollection`, `Credits` models ready for reuse
- ✅ `PaginatedResponse<T>` and `DatedPaginatedResponse<T>` used for list endpoints
- ✅ `MoviesClient` dependency wrapper for PointFree Dependencies integration
- ✅ All 49 tests passing (18 movie + 1 review + 30 existing)
- ✅ Build successful with no warnings

---

## Phase 3: Search & Discovery (COMPLETE ✅)

**Completed:** 2026-02-09
**Endpoints Implemented:** 12
**Tests Added:** 12 (61 total, all passing)

### Implemented Endpoints

#### Search (7 endpoints)
- ✅ `GET /3/search/movie` → `TMDB.searchMovies(query:page:)`
- ✅ `GET /3/search/tv` → `TMDB.searchTV(query:page:)`
- ✅ `GET /3/search/person` → `TMDB.searchPeople(query:page:)`
- ✅ `GET /3/search/multi` → `TMDB.searchMulti(query:page:)`
- ✅ `GET /3/search/collection` → `TMDB.searchCollections(query:page:)`
- ✅ `GET /3/search/company` → `TMDB.searchCompanies(query:page:)`
- ✅ `GET /3/search/keyword` → `TMDB.searchKeywords(query:page:)`

#### Supporting (5 endpoints)
- ✅ `GET /3/find/{external_id}` → `TMDB.find(externalID:source:)`
- ✅ `GET /3/keyword/{id}` → `TMDB.keywordDetails(id:)`
- ✅ `GET /3/keyword/{id}/movies` → `TMDB.keywordMovies(id:page:)`
- ✅ `GET /3/collection/{id}` → `TMDB.collectionDetails(id:)`
- ✅ `GET /3/collection/{id}/images` → `TMDB.collectionImages(id:)`

### Files Created

**Endpoints:** 4 files
```
Sources/TMDB/Models/Endpoints/
├── Search/SearchEndpoint.swift
├── Find/FindEndpoint.swift
├── Keywords/KeywordEndpoint.swift
└── Collections/CollectionEndpoint.swift
```

**Response Models:** 6 new files + 1 modified
```
Sources/TMDB/Models/Responses/Public/3/
├── Search/
│   ├── MultiSearchResult.swift
│   ├── SearchPerson.swift
│   ├── SearchCollection.swift
│   └── SearchCompany.swift
├── Collection/
│   └── Collection.swift
├── Find/
│   └── FindResult.swift
└── Movie/
    └── Keyword.swift (modified: added Discoverable conformance)
```

**Mock Data:** 12 JSON files
```
Sources/TMDB/Services/MockingService/JSON/
├── Search/ (7 files)
│   ├── SearchMovies.json
│   ├── SearchTV.json
│   ├── SearchPerson.json
│   ├── SearchMulti.json
│   ├── SearchCollections.json
│   ├── SearchCompanies.json
│   └── SearchKeywords.json
├── Find/
│   └── FindByID.json
├── Keywords/
│   ├── KeywordDetails.json
│   └── KeywordMovies.json
└── Collections/
    ├── CollectionDetails.json
    └── CollectionImages.json
```

**Mock Conformances:** 3 files
```
Sources/TMDB/Services/MockingService/Extensions/
├── Search+MockableResponse.swift
├── Collection+MockableResponse.swift
└── Find+MockableResponse.swift
```

**Tests:** 4 test files
```
Tests/TMDBTests/Endpoint Tests/
├── Search/SearchEndpointTests.swift
├── Find/FindEndpointTests.swift
├── Keywords/KeywordEndpointTests.swift
└── Collections/CollectionEndpointTests.swift
```

### Key Accomplishments
- ✅ 6 new response models + `ExternalSource` enum
- ✅ `MultiSearchResult` with custom Codable for polymorphic results (same pattern as `TrendingResult`)
- ✅ `FindResult` with nested `FindPerson`, `FindTVEpisode`, `FindTVSeason` types
- ✅ Reused `DiscoverMovie`, `DiscoverTV`, `ImageCollection`, `PaginatedResponse<T>` from earlier phases
- ✅ Added `Discoverable` conformance to `Keyword` for use in `PaginatedResponse<Keyword>`
- ✅ All 61 tests passing (12 new + 49 existing)
- ✅ Build successful with no warnings

---

## Phase 3.5: Language, Region & Missing Query Parameters (COMPLETE ✅)

**Completed:** 2026-02-18
**Target Release:** v0.4.1 (ready)

### Infrastructure Changes

#### TMDBConfiguration Defaults
- Added `defaultLanguage: Locale?` and `defaultRegion: Locale.Region?` to `TMDBConfiguration`
- Both default to `nil` — TMDB's server-side default (`en-US`) applies when not set
- Users can configure globally at SDK init, then override per-request

#### EndpointFactory Protocol
- Added `supportsLanguage: Bool` (default: `true`) and `supportsRegion: Bool` (default: `false`)
- Endpoints opt out by overriding to `false`; region endpoints opt in by overriding to `true`

#### Auto-Injection in Endpoint.decodedResponse()
- After `makeURL()`, inspects the URL and appends `language`/`region` from `TMDBConfiguration` defaults
- Only injects if: (a) the endpoint supports the parameter, and (b) it isn't already present in the URL
- Per-request overrides passed through enum cases into `makeURL()` take precedence

#### Locale.queryValue Fix
- Fixed `Locale.queryValue` to replace underscores with hyphens (`en-US` not `en_US`)
- TMDB API expects hyphenated locale identifiers

### Endpoint Opt-Outs

| Endpoint | supportsLanguage | supportsRegion |
|----------|-----------------|----------------|
| Certifications (all) | `false` | `false` |
| Configuration (all) | `false` | `false` |
| Credits (all) | `false` | `false` |
| Reviews (all) | `false` | `false` |
| Discover (all) | `false` (uses own filter system) | `false` |
| Movies: keywords, releaseDates, externalIDs, watchProviders | `false` | `false` |
| Movies: nowPlaying, popular, topRated, upcoming | `true` | `true` |
| Keywords: details | `false` | `false` |
| Keywords: movies | `true` | `true` |
| Search: movie, collection | `true` | `true` |
| Search: tv, person, multi, company, keyword | `true` | `false` |

### Missing Query Parameters Added

**Movie Endpoints (13 updated):**
- `movieDetails(id:)` — added `language`
- `movieCredits(id:)` — added `language`
- `movieImages(id:)` — added `language`
- `movieVideos(id:)` — added `language`
- `movieReviews(id:)` — added `page`, `language`
- `similarMovies(id:)` — added `page`, `language`
- `movieRecommendations(id:)` — added `page`, `language`
- `movieChanges(id:)` — added `startDate`, `endDate`, `page`
- `latestMovie()` — added `language`
- `moviesNowPlaying()` — added `page`, `language`, `region`
- `popularMovies()` — added `page`, `language`, `region`
- `topRatedMovies()` — added `page`, `language`, `region`
- `upcomingMovies()` — added `page`, `language`, `region`

**Trending Endpoints (4 updated):**
- All 4 cases — added `page`, `language`

**Search Endpoints (5 updated):**
- `searchMovies` — added `language`, `region`
- `searchTV` — added `language`
- `searchPeople` — added `language`
- `searchMulti` — added `language`
- `searchCollections` — added `includeAdult`, `language`, `region`

**Other Endpoints (8 updated):**
- `keywordMovies(id:page:)` — added `includeAdult`, `language`, `region`
- `collectionDetails(id:)` — added `language`
- `collectionImages(id:)` — added `language`
- `find(externalID:source:)` — added `language`
- `movieGenres()` — added `language`
- `tvGenres()` — added `language`
- `watchProviderRegions()` — added `language`
- `movieWatchProviders()` / `tvWatchProviders()` — added `language`

**Discover TV Filter (3 new cases):**
- `.includeAdult(Bool)`, `.voteAverageLessThan(Double)`, `.voteCountLessThan(Int)`

**QueryItemKey (2 new keys):**
- `startDate = "start_date"`, `endDate = "end_date"`

### Key Design Decisions
- All new parameters have default values → fully source-compatible
- TMDB defaults to `en-US` server-side, so no SDK-side default is needed
- Discover endpoints handle language/region through their own filter system, not auto-injection
- Mock system is path-only (ignores query params), so no mock changes were needed

### Verification
- ✅ `swift build` — no errors
- ✅ `swift test` — all 108 tests pass
- ✅ `swiftformat` — clean

---

## Phase 4: TV Shows - Complete Coverage

**Priority:** HIGH
**Complexity:** MEDIUM-HIGH
**Target Release:** v0.5.0
**Endpoints:** 39 total across 4 endpoint enums

### Architecture

TV has a 3-level hierarchy (series > season > episode) that movies don't have, plus TV-unique concepts like aggregate credits, content ratings, and episode groups.

**4 endpoint enums**: `TVSeries` (22), `TVSeasons` (9), `TVEpisodes` (7), `TVEpisodeGroups` (1)

**3 sub-phases**: 4a (TV Series), 4b (TV Seasons), 4c (TV Episodes + Groups)

### Pre-Phase: Shared Type Refactoring

Before TV work, refactor these types for shared movie/TV use:

1. **`MovieCredits` → `MediaCredits`** — Rename struct and update all references
2. **`MovieWatchProviderResult` → `MediaWatchProviderResult`** — Rename struct and update all references
3. **`ExternalIDs`** — Add `tvdbID` and `tvrageID` optional fields
4. **`ImageCollection`** — Add `stills` field, make all arrays resilient with `decodeIfPresent ?? []`
5. **`TranslationData`** — Add `name` field (TV translations return `name` instead of `title`)

### Sub-Phase 4a: TV Series (22 endpoints)

#### New Models
```swift
TMDB.TVSeries                      // Full detail model with custom Codable
TMDB.TVSeries.Creator              // Created-by person
TMDB.TVSeries.Network              // Network info
TMDB.TVSeries.SeasonOverview       // Lightweight season in series response
TMDB.TVSeries.EpisodeOverview      // Last/next episode to air
TMDB.ContentRating                 // TV content rating per region
TMDB.AggregateCredits              // TV-unique aggregate credits
TMDB.AggregateCastMember           // Cast with roles across episodes
TMDB.AggregateCrewMember           // Crew with jobs across episodes
TMDB.EpisodeGroup                  // Episode group summary
TMDB.ScreenedTheatricallyResult    // Theatrically screened episodes
```

#### Endpoints (V3Endpoints.TVSeries)
```
⏳ GET /3/tv/{id}                      → TVSeries                              tvSeriesDetails(id:)
⏳ GET /3/tv/{id}/credits               → MediaCredits                          tvSeriesCredits(id:)
⏳ GET /3/tv/{id}/aggregate_credits     → AggregateCredits                      tvSeriesAggregateCredits(id:)
⏳ GET /3/tv/{id}/images                → ImageCollection                       tvSeriesImages(id:)
⏳ GET /3/tv/{id}/videos                → VideoCollection                       tvSeriesVideos(id:)
⏳ GET /3/tv/{id}/reviews               → PaginatedResponse<Review>             tvSeriesReviews(id:)
⏳ GET /3/tv/{id}/keywords              → [Keyword]                             tvSeriesKeywords(id:)
⏳ GET /3/tv/{id}/similar               → PaginatedResponse<DiscoverTV>         similarTVSeries(id:)
⏳ GET /3/tv/{id}/recommendations       → PaginatedResponse<DiscoverTV>         tvSeriesRecommendations(id:)
⏳ GET /3/tv/{id}/alternative_titles    → [AlternativeTitle]                    alternativeTVSeriesTitles(id:)
⏳ GET /3/tv/{id}/content_ratings       → [ContentRating]                       tvSeriesContentRatings(id:)
⏳ GET /3/tv/{id}/episode_groups        → [EpisodeGroup]                        tvSeriesEpisodeGroups(id:)
⏳ GET /3/tv/{id}/external_ids          → ExternalIDs                           tvSeriesExternalIDs(id:)
⏳ GET /3/tv/{id}/translations          → [Translation]                         tvSeriesTranslations(id:)
⏳ GET /3/tv/{id}/watch/providers       → MediaWatchProviderResult              tvSeriesWatchProviders(id:)
⏳ GET /3/tv/{id}/screened_theatrically → [ScreenedTheatricallyResult]          tvSeriesScreenedTheatrically(id:)
⏳ GET /3/tv/{id}/changes               → ChangeCollection                      tvSeriesChanges(id:)
⏳ GET /3/tv/latest                     → TVSeries                              latestTVSeries()
⏳ GET /3/tv/airing_today               → PaginatedResponse<DiscoverTV>         tvSeriesAiringToday()
⏳ GET /3/tv/on_the_air                 → PaginatedResponse<DiscoverTV>         tvSeriesOnTheAir()
⏳ GET /3/tv/popular                    → PaginatedResponse<DiscoverTV>         popularTVSeries()
⏳ GET /3/tv/top_rated                  → PaginatedResponse<DiscoverTV>         topRatedTVSeries()
```

#### Files
```
Sources/TMDB/Models/Responses/Public/3/TV/
├── TVSeries.swift
├── AggregateCredits.swift
├── ContentRating.swift
├── EpisodeGroup.swift
└── ScreenedTheatricallyResult.swift

Sources/TMDB/Models/Endpoints/TV/TVSeriesEndpoints.swift
Sources/TMDB/Models/Responses/Internal/TVSeriesKeywordsResponse.swift (+ others)
Sources/TMDB/Services/MockingService/Extensions/TVSeries+MockableResponse.swift
Sources/TMDBMocking/JSON/TV/ (22 JSON files)
Sources/TMDBDependencies/Clients/TVSeriesClient.swift
Tests/TMDBTests/Endpoint Tests/TV/TVSeriesEndpointTests.swift
```

### Sub-Phase 4b: TV Seasons (9 endpoints)

#### New Models
```swift
TMDB.TVSeason              // Full season detail with episodes array
TMDB.TVEpisode             // Full episode detail (reused in 4c)
```

#### Endpoints (V3Endpoints.TVSeasons)
```
⏳ GET /3/tv/{id}/season/{num}                      → TVSeason              tvSeasonDetails(seriesID:seasonNumber:)
⏳ GET /3/tv/{id}/season/{num}/credits               → MediaCredits          tvSeasonCredits(seriesID:seasonNumber:)
⏳ GET /3/tv/{id}/season/{num}/aggregate_credits     → AggregateCredits      tvSeasonAggregateCredits(seriesID:seasonNumber:)
⏳ GET /3/tv/{id}/season/{num}/external_ids          → ExternalIDs           tvSeasonExternalIDs(seriesID:seasonNumber:)
⏳ GET /3/tv/{id}/season/{num}/images                → ImageCollection       tvSeasonImages(seriesID:seasonNumber:)
⏳ GET /3/tv/{id}/season/{num}/translations          → [Translation]         tvSeasonTranslations(seriesID:seasonNumber:)
⏳ GET /3/tv/{id}/season/{num}/videos                → VideoCollection       tvSeasonVideos(seriesID:seasonNumber:)
⏳ GET /3/tv/{id}/season/{num}/watch/providers       → MediaWatchProviderResult tvSeasonWatchProviders(seriesID:seasonNumber:)
⏳ GET /3/tv/{id}/season/{num}/changes               → ChangeCollection      tvSeasonChanges(seriesID:seasonNumber:)
```

#### Files
```
Sources/TMDB/Models/Responses/Public/3/TV/
├── TVSeason.swift
└── TVEpisode.swift

Sources/TMDB/Models/Endpoints/TV/TVSeasonEndpoints.swift
Sources/TMDB/Services/MockingService/Extensions/TVSeason+MockableResponse.swift
Sources/TMDBMocking/JSON/TV/Season/ (9 JSON files)
Sources/TMDBDependencies/Clients/TVSeasonsClient.swift
Tests/TMDBTests/Endpoint Tests/TV/TVSeasonEndpointTests.swift
```

### Sub-Phase 4c: TV Episodes + Episode Groups (8 endpoints)

#### New Models
```swift
TMDB.EpisodeGroupDetails           // Full episode group with nested groups/episodes
```

#### Endpoints (V3Endpoints.TVEpisodes)
```
⏳ GET /3/tv/{id}/season/{num}/episode/{ep}                  → TVEpisode     tvEpisodeDetails(seriesID:seasonNumber:episodeNumber:)
⏳ GET /3/tv/{id}/season/{num}/episode/{ep}/credits           → MediaCredits  tvEpisodeCredits(seriesID:seasonNumber:episodeNumber:)
⏳ GET /3/tv/{id}/season/{num}/episode/{ep}/external_ids      → ExternalIDs   tvEpisodeExternalIDs(seriesID:seasonNumber:episodeNumber:)
⏳ GET /3/tv/{id}/season/{num}/episode/{ep}/images            → ImageCollection tvEpisodeImages(seriesID:seasonNumber:episodeNumber:)
⏳ GET /3/tv/{id}/season/{num}/episode/{ep}/translations      → [Translation] tvEpisodeTranslations(seriesID:seasonNumber:episodeNumber:)
⏳ GET /3/tv/{id}/season/{num}/episode/{ep}/videos            → VideoCollection tvEpisodeVideos(seriesID:seasonNumber:episodeNumber:)
⏳ GET /3/tv/{id}/season/{num}/episode/{ep}/changes           → ChangeCollection tvEpisodeChanges(seriesID:seasonNumber:episodeNumber:)
```

#### Endpoints (V3Endpoints.TVEpisodeGroups)
```
⏳ GET /3/tv/episode_group/{id}    → EpisodeGroupDetails    episodeGroupDetails(id: String)  ← String ID!
```

#### Mock Route Ordering (Critical)
TV routes must be ordered most-specific first:
1. `/3/tv/\d+/season/\d+/episode/\d+/sub_endpoint$` (episode sub-endpoints)
2. `/3/tv/\d+/season/\d+/episode/\d+$` (episode details)
3. `/3/tv/\d+/season/\d+/sub_endpoint$` (season sub-endpoints)
4. `/3/tv/\d+/season/\d+$` (season details)
5. `/3/tv/\d+/sub_endpoint$` (series sub-endpoints)
6. `/3/tv/\d+$` (series details)
7. `/3/tv/episode_group/[^/]+$` (episode group — string ID)
8. `/3/tv/latest$`, `/3/tv/airing_today$`, etc. (list endpoints)

#### Files
```
Sources/TMDB/Models/Responses/Public/3/TV/EpisodeGroupDetails.swift
Sources/TMDB/Models/Endpoints/TV/TVEpisodeEndpoints.swift
Sources/TMDB/Models/Endpoints/TV/TVEpisodeGroupEndpoints.swift
Sources/TMDB/Services/MockingService/Extensions/TVEpisode+MockableResponse.swift
Sources/TMDBMocking/JSON/TV/Episode/ (7 JSON files)
Sources/TMDBMocking/JSON/TV/EpisodeGroup/ (1 JSON file)
Sources/TMDBDependencies/Clients/TVEpisodesClient.swift
Tests/TMDBTests/Endpoint Tests/TV/TVEpisodeEndpointTests.swift
Tests/TMDBTests/Endpoint Tests/TV/TVEpisodeGroupEndpointTests.swift
```

### Verification

After each sub-phase:
1. `swift build` — no errors or warnings
2. `swift test` — all tests pass (existing + new)
3. `swiftformat --exclude docs Sources Tests` — code formatting

---

## Phase 5: People & Supporting Features

**Priority:** MEDIUM
**Complexity:** MEDIUM
**Estimated Effort:** 2-3 weeks
**Target Release:** v0.6.0

### Endpoints to Implement (13 total)

#### People (9 endpoints)
- ⏳ `GET /3/person/{id}` - Person details
- ⏳ `GET /3/person/{id}/movie_credits` - Movie credits
- ⏳ `GET /3/person/{id}/tv_credits` - TV credits
- ⏳ `GET /3/person/{id}/combined_credits` - All credits
- ⏳ `GET /3/person/{id}/external_ids` - External IDs
- ⏳ `GET /3/person/{id}/images` - Person images
- ⏳ `GET /3/person/{id}/tagged_images` - Tagged in images
- ⏳ `GET /3/person/{id}/translations` - Translations
- ⏳ `GET /3/person/popular` - Popular people

#### Companies (2 endpoints)
- ⏳ `GET /3/company/{id}` - Company details
- ⏳ `GET /3/company/{id}/images` - Company logos

#### Networks (2 endpoints)
- ⏳ `GET /3/network/{id}` - Network details
- ⏳ `GET /3/network/{id}/images` - Network logos

### Key Models
```swift
TMDB.Person
TMDB.PersonMovieCredits
TMDB.PersonTVCredits
TMDB.Company
TMDB.Network
```

---

## Implementation Patterns

### Naming Conventions (Swift API Design Guidelines)

When creating response models, follow these naming rules:

- **Booleans**: Use assertion form (`isAdult`, `isVideo`), map via CodingKeys (`case isAdult = "adult"`)
- **Acronyms**: Use uppercase (`genreIDs`, `imdbID`), map via CodingKeys (`case genreIDs = "genreIds"`)
- **ISO codes**: Use descriptive names (`regionCode`, `languageCode`), map via CodingKeys
- **Redundant prefixes**: Remove type name from properties (`id` not `providerId`)
- **Protocols**: Use `-able`/`-ible` suffixes for capability protocols (`Discoverable`)

**Important**: When adding CodingKeys to a struct with property wrappers, you MUST list ALL properties in the CodingKeys enum, not just the renamed ones.

### Standard Endpoint Implementation (9 Steps)

Follow this pattern for each new endpoint:

#### 1. Define Endpoint Enum Case
```swift
// In Sources/TMDB/Models/Endpoints/{Category}/{Category}Endpoint.swift
extension TMDB.V3Endpoints {
    enum Movies {
        case credits(id: Int)  // Add new case
    }
}
```

#### 2. Implement URL Factory
```swift
extension TMDB.V3Endpoints.Movies: EndpointFactory {
    func makeURL(baseURL: URL) -> URL {
        var paths: [any StringProtocol] = ["3", "movie"]
        switch self {
        case .credits(let id):
            paths += [String(id), "credits"]
        }
        return URLFactory.makeURL(baseURL: baseURL, appending: paths)
    }
}
```

#### 3. Create Response Model
```swift
// In Sources/TMDB/Models/Responses/Public/3/Movie/MovieCredits.swift
public extension TMDB {
    struct MovieCredits: Codable, Sendable {
        public let id: Int
        public let cast: [CastMember]
        public let crew: [CrewMember]
    }
}
```

#### 4. Add MockableResponse Conformance
```swift
// In Sources/TMDB/Services/MockingService/Extensions/Movie+MockableResponse.swift
extension TMDB.MovieCredits: MockableResponse {
    static var mockFilename: String {
        "MovieCredits"
    }
}
```

#### 5. Create Mock JSON File
```json
// In Sources/TMDB/Services/MockingService/JSON/Movie/MovieCredits.json
{
  "id": 550,
  "cast": [...],
  "crew": [...]
}
```

#### 6. Add Regex Pattern
```swift
// In Sources/TMDB/Services/PatternMatchingService/V3Endpoint+RegexComparable.swift
extension TMDB.V3Endpoints.Movies: RegexComparable {
    var patternString: String {
        switch self {
        case .credits:
            "^/3/movie/\\d+/credits$"
        }
    }
}
```

**IMPORTANT:** Use non-capturing groups `(?:)` instead of capturing groups `()` in regex:
- ✅ Correct: `"^/3/trending/all/(?:day|week)$"`
- ❌ Wrong: `"^/3/trending/all/(day|week)$"` (creates capture group, breaks type)

#### 7. Update PathMatchingService
```swift
// In Sources/TMDB/Services/PatternMatchingService/PathMatchingService.swift
static func handleV3Path(_ url: URL) throws -> Data {
    if try doesURLMatchPath(url, path: TMDB.V3Endpoints.Movies.credits(id: 0)) {
        return try TMDB.MovieCredits.mockData()
    }
}
```

**For endpoints with multiple mock files:**
```swift
// Use MockUtilities.jsonDataFromFile() directly:
if try doesURLMatchPath(url, path: TMDB.V3Endpoints.Genres.tvList) {
    return try MockUtilities.jsonDataFromFile("TVGenres")
}
```

#### 8. Create Public API Method
```swift
// In Sources/TMDB/Models/Endpoints/Movies/MovieEndpoints.swift
public extension TMDB {
    /// `/3/movie/{id}/credits`
    /// [API Documentation](https://developer.themoviedb.org/reference/movie-credits)
    /// - Parameter id: Movie ID
    /// - Returns: Movie cast and crew
    /// - Throws: ``TMDBRequestError``
    static func movieCredits(id: Int) async throws(TMDBRequestError) -> MovieCredits {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, MovieCredits>(
            endpoint: V3Endpoints.Movies.credits(id: id),
            httpMethod: .get
        )
        do {
            return try await endpoint.decodedResponse()
        } catch {
            throw .systemError(error)
        }
    }
}
```

#### 9. Write Tests
```swift
// In Tests/TMDBTests/Endpoint Tests/Movies/MovieEndpointTests.swift
struct MovieEndpointTests {
    @Test func movieCredits() async throws {
        let credits = try await TMDB.movieCredits(id: 550)
        #expect(!credits.cast.isEmpty)
    }
}
```

### Property Wrapper Notes

**Sendable Conformance Required:**
- All property wrappers must conform to `Sendable` for Swift 6
- ✅ `RegionCode`, `LanguageCode`, `ISO8601YMD` - already Sendable

**Handling Optional Dates:**
- `@ISO8601YMD` doesn't handle missing keys in JSON
- For models with optional dates that might be missing:
  - Either: Implement custom `Codable` conformance (see `TrendingResult`)
  - Or: Omit the key from JSON entirely (don't use `null`)

**Example Custom Codable:**
```swift
// See TrendingResult.swift for full example
public init(from decoder: Decoder) throws {
    if let dateString = try container.decodeIfPresent(String.self, forKey: .date) {
        date = try? Date(dateString, strategy: .iso8601.year().month().day())
    } else {
        date = nil
    }
}
```

---

## Lessons Learned

### Phase 1 Insights

1. **Regex Patterns Must Use Non-Capturing Groups**
   - ❌ `(day|week)` creates capture groups → type mismatch
   - ✅ `(?:day|week)` non-capturing → correct type

2. **Property Wrappers and Optional Fields**
   - `@ISO8601YMD` can't decode missing keys
   - Solution: Custom Codable or omit keys from JSON

3. **Mock Data Strategy**
   - Types with one mock: Use `MockableResponse` static filename
   - Types with multiple mocks: Use `MockUtilities.jsonDataFromFile()`
   - Paginated responses: Load full JSON structure, don't construct manually

4. **Sendable Conformance**
   - Swift 6 requires all property wrappers to be `Sendable`
   - Added to `RegionCode` in Phase 1

5. **Test Organization**
   - One test file per endpoint category
   - Minimum one test per endpoint
   - Use `#expect()` assertions with meaningful checks

### Phase 2 Insights

1. **Table-Driven Mock Route Registry**
   - Refactored `PathMatchingService` from long if/else chains to a table-driven approach
   - Each endpoint category registers its routes as an array of `(pattern, data)` tuples

2. **DatedPaginatedResponse**
   - Movie lists like now playing and upcoming use `DatedPaginatedResponse<T>` which includes date range metadata alongside pagination

3. **Shared Models for Reuse**
   - `ImageCollection`, `VideoCollection`, `TranslationCollection`, `ExternalIDs`, `ChangeCollection` designed for reuse in TV endpoints (Phase 4)
   - `CastMember`, `CrewMember` shared across credit types

4. **Swift API Design Guidelines Applied Broadly**
   - Renamed boolean properties (`isAdult`, `isVideo`), acronyms (`genreIDs`, `imdbID`), ISO codes (`regionCode`, `languageCode`)
   - CodingKeys required for all properties when any property is renamed

### Phase 3 Insights

1. **Type Reuse Maximized**
   - `DiscoverMovie`, `DiscoverTV`, `ImageCollection`, `PaginatedResponse<T>` all reused from earlier phases
   - Only needed to add `Discoverable` conformance to existing `Keyword` type

2. **Polymorphic Decoding Pattern**
   - `MultiSearchResult` uses the same flat-struct-with-optional-fields pattern as `TrendingResult`
   - Custom Codable handles optional date fields that may be missing entirely from JSON

3. **ExternalSource Enum**
   - `ExternalSource` uses raw string values matching TMDB API parameters (e.g., `imdb_id`, `tvdb_id`)
   - Passed as query parameter on the find endpoint

4. **Nested Types for Find**
   - `FindPerson`, `FindTVEpisode`, `FindTVSeason` are lightweight types specific to the find response
   - Differ from full person/episode/season models that will be created in later phases

### Phase 3.5 Insights

1. **Auto-Injection via Protocol Properties**
   - `EndpointFactory.supportsLanguage`/`supportsRegion` with default implementations is a clean opt-in/opt-out pattern
   - `Endpoint.decodedResponse()` inspects the URL after `makeURL()` to avoid duplicating parameters already set per-request

2. **Locale.queryValue Must Use Hyphens**
   - TMDB expects `en-US` (hyphen), but Swift's `Locale.identifier` returns `en_US` (underscore)
   - Fixed by replacing `_` with `-` in `Locale.queryValue`

3. **Discover Endpoints Are Special**
   - Discover handles language/region through its own filter system (`.language()`, `.watchRegion()`)
   - Must opt out of auto-injection with `supportsLanguage: false`

4. **No Mock Changes Needed for Query Params**
   - `MockRouteResolver` matches on URL path only, ignoring query parameters
   - Adding query parameters to endpoints requires no mock data changes

### Build & Test Commands

```bash
# Build
swift build

# Run all tests
swift test

# Run specific test suite
swift test --filter MovieEndpointTests

# Run single test
swift test --filter MovieEndpointTests/movieCredits
```

---

## Next Steps

### Immediate (Phase 4 - TV Shows)

1. **Pre-phase shared type refactoring** — MediaCredits, MediaWatchProviderResult, ExternalIDs, ImageCollection, TranslationData
2. **Sub-Phase 4a: TV Series Endpoints** (22 endpoints)
3. **Sub-Phase 4b: TV Seasons** (9 endpoints)
4. **Sub-Phase 4c: TV Episodes + Groups** (8 endpoints)
5. **Release v0.5.0**

### Then (Phase 5 - People & Supporting Features)

1. **People endpoints** (9 endpoints)
2. **Company endpoints** (2 endpoints)
3. **Network endpoints** (2 endpoints)
4. **Release v0.6.0**

---

## Release Strategy

| Version | Content | Status |
|---------|---------|--------|
| v0.1.0 | Initial 9 endpoints | ✅ Shipped |
| v0.2.0 | Phase 1 - Foundation (15) | ✅ Ready |
| v0.3.0 | Phase 2 - Movies (20) | ✅ Ready |
| v0.4.0 | Phase 3 - Search (12) | ✅ Ready |
| v0.4.1 | Phase 3.5 - Language/Region & Query Params | ✅ Ready |
| v0.5.0 | Phase 4 - TV (41) | 📋 Next |
| v0.6.0 | Phase 5 - People (13) | ⏳ Planned |
| v1.0.0 | Auth + Account (future) | 💡 Deferred |

---

## Deferred Features (v1.0+)

Not included in current plan:

- Authentication endpoints (7)
- Account endpoints (11)
- Guest sessions (3)
- Lists CRUD (7)
- Rating POST/DELETE operations
- Total: ~30 endpoints requiring auth

Requires:
- Session management infrastructure
- Secure token storage
- Request body handling for POST/DELETE
- Different testing strategy

---

**Document Version:** 1.4
**Last Updated:** 2026-02-18
**Next Review:** Start of Phase 4

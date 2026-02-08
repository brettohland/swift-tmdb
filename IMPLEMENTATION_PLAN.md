# TMDB API v3 Read-Only Endpoints - Implementation Plan

**Status:** Phase 1 Complete ✅ | Phase 2 Next
**Last Updated:** 2026-02-07
**Target:** 110 total endpoints (9 existing + 101 new)

---

## Table of Contents
1. [Progress Overview](#progress-overview)
2. [Phase 1: Foundation & Configuration](#phase-1-foundation--configuration-complete-)
3. [Phase 2: Movies - Complete Coverage](#phase-2-movies---complete-coverage-next)
4. [Phase 3: Search & Discovery](#phase-3-search--discovery)
5. [Phase 4: TV Shows - Complete Coverage](#phase-4-tv-shows---complete-coverage)
6. [Phase 5: People & Supporting Features](#phase-5-people--supporting-features)
7. [Implementation Patterns](#implementation-patterns)
8. [Lessons Learned](#lessons-learned)

---

## Progress Overview

| Phase | Endpoints | Status | Target Release |
|-------|-----------|--------|----------------|
| **Current** | 9 | ✅ Complete | v0.1.0 (shipped) |
| **Phase 1** | 15 | ✅ Complete | v0.2.0 (ready) |
| **Phase 2** | 20 | 📋 Next | v0.3.0 |
| **Phase 3** | 12 | ⏳ Planned | v0.4.0 |
| **Phase 4** | 41 | ⏳ Planned | v0.5.0 |
| **Phase 5** | 13 | ⏳ Planned | v0.6.0 |
| **Total** | **110** | **24/110 (22%)** | |

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

## Phase 2: Movies - Complete Coverage (NEXT)

**Priority:** HIGH
**Complexity:** MEDIUM
**Estimated Effort:** 3-4 weeks
**Target Release:** v0.3.0

### Goals
- Complete all read-only movie endpoints
- Implement shared response models (Images, Videos, Credits)
- Add movie list endpoints (now playing, popular, etc.)

### Endpoints to Implement (20 total)

#### Movie Details (15 endpoints)
- ⏳ `GET /3/movie/{id}/credits` - Cast and crew
- ⏳ `GET /3/movie/{id}/images` - Posters, backdrops, logos
- ⏳ `GET /3/movie/{id}/videos` - Trailers, clips, teasers
- ⏳ `GET /3/movie/{id}/reviews` - User reviews
- ⏳ `GET /3/movie/{id}/keywords` - Associated keywords
- ⏳ `GET /3/movie/{id}/similar` - Similar movies
- ⏳ `GET /3/movie/{id}/recommendations` - Recommended movies
- ⏳ `GET /3/movie/{id}/release_dates` - Release dates by country
- ⏳ `GET /3/movie/{id}/external_ids` - IMDb, Facebook, Instagram IDs
- ⏳ `GET /3/movie/{id}/translations` - Available translations
- ⏳ `GET /3/movie/{id}/watch/providers` - Streaming availability
- ⏳ `GET /3/movie/{id}/changes` - Change log
- ⏳ `GET /3/movie/latest` - Latest added movie

#### Movie Lists (4 endpoints)
- ⏳ `GET /3/movie/now_playing` - Currently in theaters
- ⏳ `GET /3/movie/popular` - Popular movies
- ⏳ `GET /3/movie/top_rated` - Top rated movies
- ⏳ `GET /3/movie/upcoming` - Upcoming releases

#### Supporting (1 endpoint)
- ⏳ `GET /3/review/{id}` - Individual review details

### Key Models to Create

**Shared Models** (reusable for TV in Phase 4):
```swift
TMDB.ImageCollection
TMDB.ImageDetails
TMDB.VideoCollection
TMDB.VideoDetails
TMDB.MovieCredits
TMDB.CastMember
TMDB.CrewMember
TMDB.Review
TMDB.ExternalIDs
TMDB.Translation
```

### Implementation Notes
- Reuse `PaginatedResponse<T>` for movie lists
- Share `ImageCollection`, `VideoCollection`, `Credits` models with TV endpoints
- Use existing `@ISO8601YMD` property wrapper for dates
- Movie lists return paginated `Movie` objects

---

## Phase 3: Search & Discovery

**Priority:** HIGH
**Complexity:** MEDIUM
**Estimated Effort:** 2-3 weeks
**Target Release:** v0.4.0

### Endpoints to Implement (12 total)

#### Search (7 endpoints)
- ⏳ `GET /3/search/movie` - Search movies
- ⏳ `GET /3/search/tv` - Search TV shows
- ⏳ `GET /3/search/person` - Search people
- ⏳ `GET /3/search/multi` - Search all types
- ⏳ `GET /3/search/collection` - Search collections
- ⏳ `GET /3/search/company` - Search companies
- ⏳ `GET /3/search/keyword` - Search keywords

#### Supporting (5 endpoints)
- ⏳ `GET /3/find/{external_id}` - Find by IMDb/TVDB ID
- ⏳ `GET /3/keyword/{id}` - Keyword details
- ⏳ `GET /3/keyword/{id}/movies` - Movies with keyword
- ⏳ `GET /3/collection/{id}` - Collection details
- ⏳ `GET /3/collection/{id}/images` - Collection images

### Key Models
```swift
TMDB.Search.SearchFilter (query parameters)
TMDB.Search.MultiResult
TMDB.Collection
TMDB.Keyword
TMDB.FindResult
```

---

## Phase 4: TV Shows - Complete Coverage

**Priority:** HIGH
**Complexity:** MEDIUM-HIGH
**Estimated Effort:** 4-5 weeks
**Target Release:** v0.5.0

### Endpoints to Implement (41 total)

#### TV Series (18 endpoints)
- TV series details, credits, aggregate credits
- Images, videos, reviews, keywords
- Similar shows, recommendations
- Alternative titles, content ratings, episode groups
- External IDs, translations, watch providers
- Screened theatrically, changes, latest

#### TV Series Lists (4 endpoints)
- Airing today, on the air, popular, top rated

#### TV Seasons (9 endpoints)
- Season details, credits, external IDs, images
- Translations, videos, watch providers, changes

#### TV Episodes (9 endpoints)
- Episode details, credits, external IDs, images
- Translations, videos, changes

#### TV Episode Groups (1 endpoint)
- Episode group details

### Key Models
```swift
TMDB.TVSeries
TMDB.TVSeason
TMDB.TVEpisode
TMDB.ContentRating
TMDB.EpisodeGroup
```

**Note:** Reuse ImageCollection, VideoCollection, Credits from Phase 2

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

### Immediate (Phase 2 - Movies)

1. **Start with Shared Models** (needed by multiple endpoints):
   - `ImageCollection` / `ImageDetails`
   - `VideoCollection` / `VideoDetails`
   - `MovieCredits` / `CastMember` / `CrewMember`
   - `Review`
   - `ExternalIDs`
   - `Translation`

2. **Implement Movie Detail Endpoints** (15 endpoints)
   - Follow 9-step pattern for each
   - Reuse shared models

3. **Implement Movie List Endpoints** (4 endpoints)
   - Use `PaginatedResponse<Movie>`

4. **Add Review Endpoint** (1 endpoint)

5. **Test & Release v0.3.0**

### Timeline Estimate

- **Phase 2:** 3-4 weeks (20 endpoints)
- **Phase 3:** 2-3 weeks (12 endpoints)
- **Phase 4:** 4-5 weeks (41 endpoints)
- **Phase 5:** 2-3 weeks (13 endpoints)
- **Total:** 14-18 weeks for 101 new endpoints

---

## Release Strategy

| Version | Content | Status |
|---------|---------|--------|
| v0.1.0 | Initial 9 endpoints | ✅ Shipped |
| v0.2.0 | Phase 1 - Foundation (15) | ✅ Ready |
| v0.3.0 | Phase 2 - Movies (20) | 📋 Next |
| v0.4.0 | Phase 3 - Search (12) | ⏳ Planned |
| v0.5.0 | Phase 4 - TV (41) | ⏳ Planned |
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

**Document Version:** 1.0
**Last Updated:** 2026-02-07
**Next Review:** Start of Phase 2

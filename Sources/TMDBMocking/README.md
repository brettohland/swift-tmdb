# TMDBMocking

Mock data module for `swift-tmdb`. Provides automatic mock responses during unit tests and SwiftUI previews with zero setup required.

## How It Works

Mock routing uses a **data-driven architecture** with three components:

1. **`MockRoutes.json`** — A manifest in `JSON/` that maps regex patterns to JSON filenames. Each entry has a `pattern` (matched against the URL path) and a `file` (the JSON resource name without extension):

   ```json
   { "pattern": "^/3/movie/\\d+$", "file": "MovieDetails" }
   ```

2. **`MockRouteResolver`** (in the TMDB target) — Discovers this bundle at runtime using SPM's naming convention (`*_TMDBMocking.bundle`), loads and compiles the route manifest once, then matches incoming `URLRequest` paths against the patterns to return the corresponding mock JSON data.

3. **`HTTPClient.testValue` / `previewValue`** — The Dependencies framework's test and preview values call `MockRouteResolver.data(for:)` directly. No registration or import is needed from test code.

### Request Flow

```
Test calls TMDB.movieDetails(id: 550)
  -> HTTPClient.testValue
    -> MockRouteResolver.data(for: request)
      -> Matches "/3/movie/550" against "^/3/movie/\\d+$"
      -> Loads MovieDetails.json from this bundle
    -> Returns Data to HTTPClient
  -> Endpoint decodes Data into Movie
```

## Adding a New Mock Route

1. Add the mock JSON file to the appropriate subdirectory under `JSON/`
2. Add an entry to `JSON/MockRoutes.json` with the regex pattern and filename
3. (Optional) Add a `MockableResponse` conformance in `Extensions/` to provide `mock()` and `mockData()` convenience methods

### Pattern Ordering

More specific patterns must appear before general ones in `MockRoutes.json`. For example, sub-resource patterns like `^/3/movie/\\d+/credits$` must come before the details pattern `^/3/movie/\\d+$`, since the resolver uses first-match.

## Directory Structure

```
TMDBMocking/
├── TMDBMocking.swift           # TMDBMockData enum (register() is a deprecated no-op)
├── MockableResponse.swift      # Protocol providing mock()/mockData() convenience methods
├── MockUtilities.swift         # JSON file loading helpers using Bundle.module
├── MockResponseError.swift     # Error types for mock data loading
├── Extensions/                 # MockableResponse conformances per endpoint group
│   ├── MovieEndpoint+MockableResponse.swift
│   ├── TVSeries+MockableResponse.swift
│   └── ...
└── JSON/                       # Mock JSON response files
    ├── MockRoutes.json         # Route manifest (pattern -> filename)
    ├── Movie/
    │   ├── MovieDetails.json
    │   ├── MovieCredits.json
    │   └── ...
    ├── TV/
    │   ├── TVSeriesDetails.json
    │   ├── Season/
    │   │   └── TVSeasonDetails.json
    │   └── Episode/
    │       └── TVEpisodeDetails.json
    ├── Discover/
    ├── Search/
    └── ...
```

## MockableResponse Protocol

Types conforming to `MockableResponse` get `mock()` and `mockData()` class methods for use in tests and previews:

```swift
// In Extensions/MovieEndpoint+MockableResponse.swift
extension TMDB.Movie: MockableResponse {
    static var mockFilename: String { "MovieDetails" }
}

// Usage in tests (requires `import TMDBMocking`)
let movie = try TMDB.Movie.mock()
```

Most tests don't need these convenience methods — they simply call the `TMDB.*` API methods and get mock data automatically.

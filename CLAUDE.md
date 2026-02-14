# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## General Guidelines

When asked to do X, do exactly X. Do not expand scope beyond what was requested. If the user asks for a plan, deliver the plan. If they ask for implementation, implement. Ask before doing additional work.

## Workflow Conventions

When asked to create a plan, always write it to a file on disk (e.g., `PLAN.md` or `.claude/plans/<name>.md`) unless explicitly told otherwise.

## TMDB API Reference

The official TMDB API documentation at https://developer.themoviedb.org/reference is the **sole source of truth** for all questions about the TMDB API — including available endpoints, query parameters, response schemas, and expected behavior. Do not rely on third-party API wrappers, community wikis, or other unofficial sources when determining what the API supports.

## Project Overview

`swift-tmdb` is a modern Swift package providing a type-safe wrapper around the TMDB API (The Movie Database). It targets iOS/iPadOS 26+ and uses Swift 6.2 with strict concurrency enabled. The package is designed to automatically provide mocked responses during unit testing and SwiftUI previews using PointFree's Dependencies framework.

## Important Notes

- **Ignore the `docs/` folder** - It contains a generated DocC static site for GitHub Pages. Do not modify, search, or include in any work.
- **Run SwiftFormat after modifying Swift files** - Run `swiftformat --exclude docs Sources Tests` before finishing work to ensure code conforms to the project's `.swiftformat` configuration.
- **Use `let` for all properties in decoded structs** - The only exception is properties using property wrappers (`@NilBoolean`, `@ISO8601YMD`, `@LanguageCode`, `@RegionCode`, `@Minutes`, etc.) which require `var` per Swift's rules.
- **Never use `Bool?` in decoded structs** - Always use the `@NilBoolean` property wrapper instead, which decodes missing or null values as `false`. In custom Codable implementations, decode via `_propertyName = try container.decodeIfPresent(NilBoolean.self, forKey: .key) ?? NilBoolean(wrappedValue: false)` and encode via `try container.encode(_propertyName, forKey: .key)`.
- **Define each enum case on its own line** - Never use comma-separated case lists (e.g., `case a, b, c`). Each case must be on a separate line.
- **Use `URL` or `URL?` for image path properties** - Properties like `posterPath`, `backdropPath`, `profilePath`, `logoPath`, `filePath`, and `stillPath` are typed as `URL`/`URL?`, not `String`/`String?`.
- **Use typed throws on all public API methods** - All public static methods on `TMDB` use `async throws(TMDBRequestError)` with a `do/catch` wrapper that converts errors via `throw .systemError(error)`.
- **Forward all public method parameters to the endpoint enum** - Every parameter on a public `TMDB` static method (e.g., `page`, `query`) must be captured in the corresponding `V3Endpoints` enum case and used in `makeURL(baseURL:)`. Do not accept parameters in the public API signature that are silently ignored.
- **Use `[URLQueryItem]` helpers for query parameters** - When building query items in `makeURL(baseURL:)`, use the helpers from `URLQueryItem+Helpers.swift` instead of constructing `URLQueryItem` directly. These leverage the `QueryValueRepresentable` protocol (which `String`, `Int`, `Bool`, `Double`, `Date`, `Locale`, etc. already conform to) to handle value conversion automatically. Prefer the `QueryItemKey` enum overloads for common/shared keys; use the `String` overloads for endpoint-specific keys not yet in the enum:
  - `queryItems.append(.page, value: page)` — appends a required parameter using `QueryItemKey`
  - `queryItems.appendIfPresent(.year, value: year)` — appends only if non-nil
  - `queryItems.appendIfTrue(.includeAdult, value: includeAdult)` — appends only if `true`
  - `queryItems.append("external_source", value: source.rawValue)` — `String` fallback for keys not in `QueryItemKey`
- **Add shared query keys to `V3Endpoints.QueryItemKey`** - The `QueryItemKey` enum in `V3Endpoints+QueryItemKey.swift` maps Swift case names to their JSON query parameter names (e.g., `case includeAdult = "include_adult"`). When adding a new endpoint that uses a query parameter already in the enum, use the enum case. When a parameter is used by multiple endpoints but not yet in the enum, add it there rather than using raw strings.
- **Always add a public memberwise initializer to public response structs** - Swift only auto-generates internal memberwise initializers, so every public struct in `Sources/TMDB/Models/Responses/Public/` must have an explicit `public init(...)`. For `let` properties use `self.prop = prop`. For property wrappers use the underscore form: `_prop = Wrapper(wrappedValue: val)` (e.g., `_isAdult = NilBoolean(wrappedValue: isAdult)`, `_releaseDate = ISO8601YMD(wrappedValue: releaseDate)`). Place the initializer after the last property declaration, before any `CodingKeys` enum or Codable conformance.

## Swift API Design Guidelines

This project follows the [Swift API Design Guidelines](https://www.swift.org/documentation/api-design-guidelines/) for all public-facing names:
- **Boolean properties** use assertion form: `isAdult`, `isVideo` (not `adult`, `video`)
- **Acronyms** are uniformly uppercased: `genreIDs`, `imdbID` (not `genreIds`, `imdbId`)
- **ISO code properties** use descriptive role names: `regionCode`, `languageCode` (not `iso31661`, `iso6391`)
- **Redundant type prefixes** are removed: `WatchProvider.id` (not `providerId`), `Credits.Details.type` (not `creditType`)
- **Protocols** describing capability use `-able` suffix: `Discoverable` (not `DiscoverType`)
- When renaming a decoded property, add a `CodingKeys` enum mapping the new name to the original JSON key. If any property wrapper is present on the struct, ALL properties must appear in `CodingKeys` — even if the project uses `.convertFromSnakeCase` key decoding and the names happen to match.

## Build and Test Commands

### Building
```bash
swift build
```

### Running Tests
```bash
swift test
```

### Running a Single Test
```bash
swift test --filter <TestName>
```

Example:
```bash
swift test --filter DiscoverTests
```

### Generating Documentation
The project uses Swift-DocC for documentation. Documentation is hosted at:
https://brettohland.github.io/swift-tmdb/documentation/tmdb/

To build documentation locally:
```bash
swift package --disable-sandbox preview-documentation --target TMDB
```

## Architecture

### Three-Target Structure

1. **TMDB** (Core Module)
   - Contains all API request logic, models, and response types
   - Uses static methods on the `TMDB` enum for making API calls

2. **TMDBMocking** (Mock Data Module)
   - Contains all mock JSON response files, mock routing logic, `MockableResponse` protocol, and route definitions
   - Requires explicit registration via `TMDBMockData.register()` in test `init()` or before SwiftUI previews
   - The `TMDB` library product bundles both `TMDB` + `TMDBMocking` targets
   - The `TMDBCore` library product provides `TMDB` without mocking (for apps that don't need it)

3. **TMDBDependencies** (Optional Wrapper Module)
   - Provides `@Dependency`-based clients for use with PointFree's Dependencies
   - Re-exports the Dependencies module
   - Example: `MoviesClient` wraps `TMDB.movieDetails(id:)` for dependency injection

### Initialization

The framework requires initialization with a TMDB API key before use:

```swift
try await TMDB.initialize(apiKey: "YOUR_API_KEY")
```

This should be done once at app startup. The API key is stored using Dependencies and accessed via `sdkConfigurationStore`.

### Service Layer Architecture

The codebase uses a service-oriented architecture with several internal services:

#### RequestService
- **HTTPClient**: Core networking client that wraps URLSession
- **Endpoint**: Generic struct that handles request/response lifecycle
- **EndpointFactory**: Protocol for endpoint URL generation
- **URLFactory**: Utility for constructing endpoint URLs

#### MockingService
- **MockDataHandler**: Thin closure bridge (`TMDB.mockDataHandler`) that TMDBMocking registers to connect mock data to the core framework
- Mock routing, `PathMatchingService`, `MockableResponse` protocol, and route definitions all live in TMDBMocking
- Mock JSON responses stored in `Sources/TMDBMocking/JSON/`

#### LoggingService
- **LoggingDependencyClient**: Abstraction for logging
- **OSLoggingService**: Production implementation using OSLog
- **ConsoleLogger**: Development implementation using print

### Endpoint Pattern

All TMDB API endpoints follow this structure:

1. Define endpoint enum in `TMDB.V3Endpoints` namespace (e.g., `TMDB.V3Endpoints.Movies`)
2. Implement `EndpointFactory.makeURL(baseURL:)` to construct the URL path
3. Create public static methods on `TMDB` that:
   - Create an `Endpoint<RequestBody, ResponseBody>` instance
   - Call `endpoint.decodedResponse()` to execute the request
   - Return the decoded response

Example structure:
```swift
// Endpoint definition
extension TMDB.V3Endpoints {
    enum Movies {
        case details(id: Int)
    }
}

// URL factory implementation
extension TMDB.V3Endpoints.Movies: EndpointFactory {
    func makeURL(baseURL: URL) -> URL {
        // Build URL path components
    }
}

// Public API
public extension TMDB {
    static func movieDetails(id: Int) async throws(TMDBRequestError) -> Movie {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, Movie>(...)
        do {
            return try await endpoint.decodedResponse()
        } catch {
            throw .systemError(error)
        }
    }
}
```

### Dependencies Integration

The framework uses PointFree's Dependencies for:
- **Testability**: Automatic mock data in `XCTest` and SwiftUI previews
- **Dependency Injection**: `HTTPClient`, logging, and configuration are all injected dependencies
- **Context Awareness**: The `HTTPClient` automatically switches to mock mode in test/preview contexts via `TMDB.mockDataHandler`:
  - `liveValue`: Uses real URLSession
  - `testValue`: Calls `mockDataHandler` with instant responses
  - `previewValue`: Calls `mockDataHandler` with 2-second delay for realistic previews

### Directory Structure

```
Sources/
├── TMDB/
│   ├── TMDB.swift                     # Top-level namespace and initialization
│   ├── Models/
│   │   ├── Endpoints/                 # Endpoint definitions grouped by API section
│   │   ├── Responses/                 # Response model types
│   │   ├── Errors/                    # Error types
│   │   └── Codable Property Wrappers/ # Custom property wrappers for encoding/decoding
│   ├── Services/
│   │   ├── RequestService/            # Core networking
│   │   ├── MockingService/            # MockDataHandler closure bridge
│   │   └── LoggingService/            # Logging abstractions
│   ├── Format Styles/                 # Swift FormatStyle implementations
│   └── Documentation.docc/            # DocC documentation
├── TMDBMocking/
│   ├── TMDBMocking.swift              # TMDBMockData.register() entry point
│   ├── PathMatchingService.swift      # URL pattern matching and mock routing
│   ├── MockableResponse.swift         # Protocol for types providing mock data
│   ├── MockUtilities.swift            # JSON file loading helpers
│   ├── Extensions/                    # MockableResponse conformances per endpoint group
│   ├── Routes/                        # MockRoute definitions per endpoint group
│   └── JSON/                          # Mock JSON response files
└── TMDBDependencies/
    └── Clients/                       # Dependency-based client wrappers
```

## Swift 6 Features

This codebase uses several upcoming Swift features:
- `NonisolatedNonsendingByDefault`
- `InferIsolatedConformances`
- `FullTypedThrows`

The `@MainActor` annotation on the `TMDB` enum ensures initialization happens on the main thread.

## Codable Property Wrappers

The codebase includes custom property wrappers for handling TMDB API quirks:
- `@ISO8601YMD`: Dates in "YYYY-MM-DD" format
- `@LanguageCode`: Language codes (e.g., "en-US")
- `@RegionCode`: Region codes (e.g., "US")
- `@Minutes`: Runtime values in minutes
- `@NilBoolean`, `@NilInteger`, `@NilCodableArray`: Handle null values gracefully

## Adding New Endpoints

To add a new TMDB API endpoint:

1. Create endpoint case in appropriate `TMDB.V3Endpoints` enum (or create new enum)
2. Implement `makeURL(baseURL:)` in `EndpointFactory` conformance
3. Define response model types in `Sources/TMDB/Models/Responses/`
4. Create public static method on `TMDB` to execute the request
5. Add mock JSON response in `Sources/TMDBMocking/JSON/`
6. Add a route file in `Sources/TMDBMocking/Routes/` and register it in `PathMatchingService.v3Routes`
7. Create `MockableResponse` conformance in `Sources/TMDBMocking/Extensions/`
8. Write tests in `Tests/TMDBTests/`
9. (Optional) Add client wrapper in `TMDBDependencies/Clients/`

## Code Review Guidelines

When reviewing code, do not flag optional URL properties (e.g., `URL? backdropPath`) as bugs — these are intentionally optional in the TMDB API models.

- **Doc comments must match the actual URL path** - The `/// /3/...` doc comment on each public method must reflect the URL that `makeURL(baseURL:)` actually produces, not the TMDB docs page name.

## Testing

This is a Swift Package Manager project. Tests use mock JSON fixtures and the PointFree Dependencies framework — they do NOT make live API requests. When debugging test failures, check mock data and dependency overrides before assuming network issues.

After completing implementation tasks, always run `swift build` and `swift test` to verify before committing. If tests fail, debug and fix before presenting results as complete.

Tests use Swift Testing framework (not XCTest). The `@testable import TMDB` gives access to internal types. Tests must call `TMDBMockData.register()` in their struct `init()` to connect mock data before any TMDB API calls.

Test files are organized by feature:
- `DiscoverFilterTests.swift`: Tests for Discover filter types
- `EndpointFactoryTests.swift`: Tests for URL generation
- `Endpoint Tests/`: Directory with tests organized by API section

## Discovery Filters

The Discover endpoints support complex filtering via composable value types:
- `TMDB.Discover.MovieFilter`: Filters for movie discovery
- `TMDB.Discover.TVFilter`: Filters for TV show discovery

These are first-class types that can be combined to create complex queries without string concatenation.

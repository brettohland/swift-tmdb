# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## General Guidelines

When asked to do X, do exactly X. Do not expand scope beyond what was requested. If the user asks for a plan, deliver the plan. If they ask for implementation, implement. Ask before doing additional work.

## Workflow Conventions

When asked to create a plan, always write it to a file on disk (e.g., `PLAN.md` or `.claude/plans/<name>.md`) unless explicitly told otherwise.

After completing each implementation phase, update both `CLAUDE.md` (with any new patterns, conventions, or findings from the phase) and `IMPLEMENTATION_PLAN.md` (to reflect the completed work, mark endpoints as done, and record lessons learned).

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
- **Forward all public method parameters to the endpoint enum** - Every parameter on a public `TMDB` static method (e.g., `page`, `query`) must be captured in the corresponding `V3Endpoints` or `V4Endpoints` enum case and used in `makeURL(baseURL:)`. Do not accept parameters in the public API signature that are silently ignored.
- **POST/DELETE endpoints use `requestBody:` parameter** - When an endpoint requires a JSON request body, pass a specific `Encodable` type as `RequestBody` (not `HTTP.EmptyRequestBody`) and supply it via `Endpoint(endpoint:httpMethod:requestBody:)`. The `Endpoint` struct automatically encodes the body and sets `Content-Type: application/json`. Internal request body types live in `Sources/TMDB/Models/Responses/Internal/Auth/`.
- **Use `[URLQueryItem]` helpers for query parameters** - When building query items in `makeURL(baseURL:)`, use the helpers from `URLQueryItem+Helpers.swift` instead of constructing `URLQueryItem` directly. These leverage the `QueryValueRepresentable` protocol (which `String`, `Int`, `Bool`, `Double`, `Date`, `Locale`, etc. already conform to) to handle value conversion automatically. Prefer the `QueryItemKey` enum overloads for common/shared keys; use the `String` overloads for endpoint-specific keys not yet in the enum:
  - `queryItems.append(.page, value: page)` — appends a required parameter using `QueryItemKey`
  - `queryItems.appendIfPresent(.year, value: year)` — appends only if non-nil
  - `queryItems.appendIfTrue(.includeAdult, value: includeAdult)` — appends only if `true`
  - `queryItems.append("external_source", value: source.rawValue)` — `String` fallback for keys not in `QueryItemKey`
- **Add shared query keys to `V3Endpoints.QueryItemKey`** - The `QueryItemKey` enum in `V3Endpoints+QueryItemKey.swift` maps Swift case names to their JSON query parameter names (e.g., `case includeAdult = "include_adult"`). When adding a new endpoint that uses a query parameter already in the enum, use the enum case. When a parameter is used by multiple endpoints but not yet in the enum, add it there rather than using raw strings.
- **New endpoints must set `supportsLanguage`/`supportsRegion` correctly** - The `EndpointFactory` protocol has `supportsLanguage: Bool` (default `true`) and `supportsRegion: Bool` (default `false`). Override to `false` for endpoints that don't accept a `language` query parameter (e.g., certifications, configuration, credits, reviews). Override `supportsRegion` to `true` for endpoints that accept a `region` parameter. For per-case control, use a `switch self` computed property. Discover endpoints must set `supportsLanguage: false` because they handle language/region through their own filter system. **Do not assume all endpoints in a category share the same parameter support** — always verify each endpoint individually in the TMDB API docs. For example, among TV list endpoints only `GET /3/tv/popular` accepts `region`; `airing_today`, `on_the_air`, and `top_rated` do not.
- **Always add a public memberwise initializer to public response structs** - Swift only auto-generates internal memberwise initializers, so every public struct in `Sources/TMDB/Models/Responses/Public/` must have an explicit `public init(...)`. For `let` properties use `self.prop = prop`. For property wrappers use the underscore form: `_prop = Wrapper(wrappedValue: val)` (e.g., `_isAdult = NilBoolean(wrappedValue: isAdult)`, `_releaseDate = ISO8601YMD(wrappedValue: releaseDate)`). Place the initializer after the last property declaration, before any `CodingKeys` enum or Codable conformance.
- **Swift source filenames must be unique across the entire target** - Two files named `Foo.swift` in different subdirectories of the same Swift target (e.g., `Credits/Person.swift` and `Person/Person.swift`) produce the same `Foo.swift.o` object file and cause a build error: "multiple producers". Use distinct filenames (e.g., `PersonDetails.swift`) rather than relying on directory hierarchy to disambiguate.
- **Paginated list responses use `Discover.PaginatedResponse<T>` and require `Discoverable`** - The full type is `TMDB.Discover.PaginatedResponse<T>` where `T` must conform to `Discoverable` (defined in `Sources/TMDB/Models/Responses/Public/3/Discover/Discoverable.swift` as `public protocol Discoverable: Codable, Sendable {}`). When adding a new type as the element of a paginated list endpoint, add `extension MyType: Discoverable {}`.
- **Dependency client files must use `internal import DependenciesMacros`** - All files in `TMDBDependencies/Clients/` use `@_exported public import Dependencies` and `internal import DependenciesMacros`. Using a plain `import DependenciesMacros` causes an "ambiguous implicit access level" build error because another file in the target already imports it as `internal`.

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

### Five-Target Structure

1. **TMDB** (Core Module)
   - Contains all API request logic, models, and response types
   - Uses static methods on the `TMDB` enum for making API calls

2. **TMDBMocking** (Mock Data Module)
   - Contains all mock JSON response files, `MockRoutes.json` manifest, `MockableResponse` protocol, and `mock()` convenience methods
   - Mock data is discovered automatically at runtime — no registration needed
   - The `TMDB` library product bundles both `TMDB` + `TMDBMocking` targets
   - The `TMDBCore` library product provides `TMDB` without mocking (for apps that don't need it)

3. **TMDBDependencies** (Optional Wrapper Module)
   - Provides `@Dependency`-based clients for use with PointFree's Dependencies
   - Re-exports the Dependencies module
   - Example: `MoviesClient` wraps `TMDB.movieDetails(id:)` for dependency injection

4. **TMDBSwiftUI** (Browser Auth for SwiftUI)
   - Provides `.tmdbAuthentication(isPresented:onComplete:)` view modifier
   - Uses `@Environment(\.webAuthenticationSession)` for browser-based OAuth
   - Re-exports `TMDB` via `@_exported import TMDB`

5. **TMDBUIKit** (Browser Auth for UIKit)
   - Provides `TMDB.authenticate(presentationAnchor:)` for UIKit apps
   - Uses `ASWebAuthenticationSession` with explicit presentation anchor
   - Re-exports `TMDB` via `@_exported import TMDB`

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
- **Endpoint**: Generic struct that handles request/response lifecycle; auto-injects `language`/`region` defaults from `TMDBConfiguration` after `makeURL()` if the endpoint supports them
- **EndpointFactory**: Protocol for endpoint URL generation with `supportsLanguage`/`supportsRegion` opt-in/opt-out properties
- **URLFactory**: Utility for constructing endpoint URLs

#### MockingService
- **MockRouteResolver**: Discovers the TMDBMocking resource bundle at runtime, loads `MockRoutes.json` (a manifest mapping regex patterns to JSON filenames), and resolves mock data for URL requests
- `MockableResponse` protocol and `mock()` convenience methods live in TMDBMocking
- Mock JSON responses stored in `Sources/TMDBMocking/JSON/`

#### AuthService
- **AuthSession**: Public model storing `accessToken`, `accountID`, `sessionID`
- **AuthSessionStore**: Keychain-backed dependency (`liveValue` uses Security framework, `testValue` is in-memory, `previewValue` returns mock session)
- **AuthenticationCoordinator**: Public actor orchestrating the full OAuth flow (token request → browser approval → token exchange → session conversion → keychain storage)

#### LoggingService
- **LoggingDependencyClient**: Abstraction for logging
- **OSLoggingService**: Production implementation using OSLog
- **ConsoleLogger**: Development implementation using print

### Endpoint Pattern

All TMDB API endpoints follow this structure:

1. Define endpoint enum in `TMDB.V3Endpoints` or `TMDB.V4Endpoints` namespace (e.g., `TMDB.V3Endpoints.Movies`, `TMDB.V4Endpoints.Auth`)
2. Implement `EndpointFactory.makeURL(baseURL:)` to construct the URL path (v3 paths start with `"3"`, v4 paths start with `"4"`)
3. Create public static methods on `TMDB` that:
   - Create an `Endpoint<RequestBody, ResponseBody>` instance
   - Call `endpoint.decodedResponse()` to execute the request
   - Return the decoded response

Example structure (GET):
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

Example structure (POST with request body):
```swift
public extension TMDB {
    static func createAccessToken(requestToken: String) async throws(TMDBRequestError) -> Auth.AccessToken {
        let endpoint = Endpoint<AccessTokenBody, Auth.AccessToken>(
            endpoint: V4Endpoints.Auth.createAccessToken(requestToken: requestToken),
            httpMethod: .post,
            requestBody: AccessTokenBody(requestToken: requestToken),
        )
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
- **Context Awareness**: The `HTTPClient` automatically switches to mock mode in test/preview contexts via `MockRouteResolver`:
  - `liveValue`: Uses real URLSession
  - `testValue`: Calls `MockRouteResolver` with instant responses
  - `previewValue`: Calls `MockRouteResolver` with 2-second delay for realistic previews

### Directory Structure

```
Sources/
├── TMDB/
│   ├── TMDB.swift                     # Top-level namespace and initialization
│   ├── Models/
│   │   ├── Endpoints/                 # Endpoint definitions grouped by API section
│   │   │   ├── Auth/                  # V3 + V4 auth endpoints
│   │   │   └── ...                    # Movies, TV, Search, etc.
│   │   ├── Responses/
│   │   │   ├── Public/3/              # v3 response models
│   │   │   ├── Public/4/Auth/         # v4 auth response models
│   │   │   └── Internal/Auth/         # Request body types (not public)
│   │   ├── Errors/                    # Error types
│   │   └── Codable Property Wrappers/ # Custom property wrappers for encoding/decoding
│   ├── Services/
│   │   ├── RequestService/            # Core networking
│   │   ├── AuthService/               # Auth session, keychain store, coordinator
│   │   ├── MockingService/            # MockRouteResolver for runtime bundle discovery
│   │   └── LoggingService/            # Logging abstractions
│   ├── Format Styles/                 # Swift FormatStyle implementations
│   └── Documentation.docc/            # DocC documentation
├── TMDBMocking/
│   ├── TMDBMocking.swift              # TMDBMockData enum (register() is a deprecated no-op)
│   ├── MockableResponse.swift         # Protocol for types providing mock data
│   ├── MockUtilities.swift            # JSON file loading helpers
│   ├── Extensions/                    # MockableResponse conformances per endpoint group
│   └── JSON/                          # Mock JSON response files + MockRoutes.json manifest
├── TMDBSwiftUI/                       # SwiftUI auth modifier (.tmdbAuthentication)
├── TMDBUIKit/                         # UIKit auth extension (TMDB.authenticate)
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

1. Create endpoint case in appropriate `TMDB.V3Endpoints` or `TMDB.V4Endpoints` enum (or create new enum)
2. Implement `makeURL(baseURL:)` in `EndpointFactory` conformance
3. Set `supportsLanguage`/`supportsRegion` overrides if the defaults (`true`/`false`) don't match the TMDB API docs for this endpoint
4. Define response model types in `Sources/TMDB/Models/Responses/`
5. Create public static method on `TMDB` to execute the request (include `language: Locale? = nil` and/or `region: Locale.Region? = nil` parameters where the TMDB API supports them, forwarding to the enum case and into `makeURL`)
6. Add mock JSON response in `Sources/TMDBMocking/JSON/`
7. Add a route entry in `Sources/TMDBMocking/JSON/MockRoutes.json` mapping the URL pattern to the JSON filename
8. Create `MockableResponse` conformance in `Sources/TMDBMocking/Extensions/`
9. Write tests in `Tests/TMDBTests/`
10. (Optional) Add client wrapper in `TMDBDependencies/Clients/`

## Code Review Guidelines

When reviewing code, do not flag optional URL properties (e.g., `URL? backdropPath`) as bugs — these are intentionally optional in the TMDB API models.

- **Doc comments must match the actual URL path** - The `/// /3/...` doc comment on each public method must reflect the URL that `makeURL(baseURL:)` actually produces, not the TMDB docs page name.

## Testing

This is a Swift Package Manager project. Tests use mock JSON fixtures and the PointFree Dependencies framework — they do NOT make live API requests. When debugging test failures, check mock data and dependency overrides before assuming network issues.

After completing implementation tasks, always run `swift build` and `swift test` to verify before committing. If tests fail, debug and fix before presenting results as complete.

Tests use Swift Testing framework (not XCTest). The `@testable import TMDB` gives access to internal types. Mock data is discovered automatically at runtime — no `TMDBMockData.register()` call or `import TMDBMocking` is needed (unless the test uses `.mock()` convenience methods from TMDBMocking).

Test files are organized by feature:
- `DiscoverFilterTests.swift`: Tests for Discover filter types
- `EndpointFactoryTests.swift`: Tests for URL generation
- `Endpoint Tests/`: Directory with tests organized by API section

## TMDB API Quirks

Known deviations from the TMDB API's general URL patterns:

- **TV season and episode changes use direct IDs, not hierarchical paths** - Unlike other TV sub-resource endpoints (which follow `/3/tv/{series_id}/season/{season_number}/...`), the changes endpoints take a direct resource ID: `GET /3/tv/season/{season_id}/changes` and `GET /3/tv/episode/{episode_id}/changes`. The same pattern applies to `GET /3/tv/{series_id}/changes` (uses series ID, not a sub-path). Model the endpoint enum cases with a direct ID parameter rather than the full hierarchy.

## Discovery Filters

The Discover endpoints support complex filtering via composable value types:
- `TMDB.Discover.MovieFilter`: Filters for movie discovery
- `TMDB.Discover.TVFilter`: Filters for TV show discovery

These are first-class types that can be combined to create complex queries without string concatenation.

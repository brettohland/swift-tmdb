# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

`swift-tmdb` is a modern Swift package providing a type-safe wrapper around the TMDB API (The Movie Database). It targets iOS/iPadOS 26+ and uses Swift 6.2 with strict concurrency enabled. The package is designed to automatically provide mocked responses during unit testing and SwiftUI previews using PointFree's Dependencies framework.

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

### Two-Module Structure

1. **TMDB** (Core Module)
   - Contains all API request logic, models, and response types
   - Uses static methods on the `TMDB` enum for making API calls
   - Automatically provides mock data in test and preview contexts

2. **TMDBDependencies** (Optional Wrapper Module)
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
- **PathMatchingService**: Routes incoming test requests to appropriate mock data
- Uses regex pattern matching to identify endpoints in test contexts
- Mock JSON responses stored in `Sources/TMDB/Services/MockingService/JSON/`
- **MockableResponse**: Protocol for types that can provide mock data

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
    static func movieDetails(id: Int) async throws -> Movie {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, Movie>(...)
        return try await endpoint.decodedResponse()
    }
}
```

### Dependencies Integration

The framework uses PointFree's Dependencies for:
- **Testability**: Automatic mock data in `XCTest` and SwiftUI previews
- **Dependency Injection**: `HTTPClient`, logging, and configuration are all injected dependencies
- **Context Awareness**: The `HTTPClient` automatically switches to mock mode in test/preview contexts:
  - `liveValue`: Uses real URLSession
  - `testValue`: Uses PathMatchingService with instant responses
  - `previewValue`: Uses PathMatchingService with 2-second delay for realistic previews

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
│   │   ├── MockingService/            # Test/preview mocking
│   │   ├── LoggingService/            # Logging abstractions
│   │   └── PatternMatchingService/    # URL pattern matching for mocks
│   ├── Format Styles/                 # Swift FormatStyle implementations
│   └── Documentation.docc/            # DocC documentation
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
5. Add mock JSON response in `Sources/TMDB/Services/MockingService/JSON/`
6. Update `PathMatchingService.handleV3Path()` to route to mock data
7. Create conformance to `MockableResponse` protocol for the response type
8. Write tests in `Tests/TMDBTests/`
9. (Optional) Add client wrapper in `TMDBDependencies/Clients/`

## Testing

Tests use Swift Testing framework (not XCTest). The `@testable import TMDB` gives access to internal types. Tests automatically receive mock data without additional setup due to the Dependencies framework integration.

Test files are organized by feature:
- `DiscoverFilterTests.swift`: Tests for Discover filter types
- `EndpointFactoryTests.swift`: Tests for URL generation
- `Endpoint Tests/`: Directory with tests organized by API section

## Discovery Filters

The Discover endpoints support complex filtering via composable value types:
- `TMDB.Discover.MovieFilter`: Filters for movie discovery
- `TMDB.Discover.TVFilter`: Filters for TV show discovery

These are first-class types that can be combined to create complex queries without string concatenation.

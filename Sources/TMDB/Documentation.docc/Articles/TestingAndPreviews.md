# Testing and Previews

Use automatic mock data in unit tests and SwiftUI previews with zero configuration.

## Overview

`swift-tmdb` provides mock data automatically in test and preview contexts using [PointFree's Dependencies](https://github.com/pointfreeco/swift-dependencies). No setup or registration is needed — just call TMDB methods as normal.

## Unit Test Example

Tests can call any TMDB method directly. Mock data is returned instantly.

```swift
import Testing
@testable import TMDB

struct MovieTests {
    @Test func movieDetailsReturnsValidData() async throws {
        let movie = try await TMDB.movieDetails(id: 550)
        #expect(movie.title == "Fight Club")
        #expect(movie.id == 550)
    }
}
```

## Using MockableResponse

For direct access to mock models without making an API call, import `TMDBMocking` and use the `mock()` convenience method.

```swift
import Testing
import TMDB
import TMDBMocking

struct ModelTests {
    @Test func movieMockHasExpectedValues() {
        let movie = TMDB.Movie.mock()
        #expect(!movie.title.isEmpty)
    }
}
```

## SwiftUI Previews

Previews work identically to production code. Mock data is returned automatically with a 2-second delay to simulate realistic loading.

```swift
import SwiftUI
import TMDB

#Preview {
    MovieListView()
}

struct MovieListView: View {
    @State private var movies: [TMDB.Discover.DiscoverMovie] = []

    var body: some View {
        List(movies, id: \.id) { movie in
            Text(movie.title)
        }
        .task {
            let results = try? await TMDB.searchMovies(query: "Matrix")
            movies = results?.results ?? []
        }
    }
}
```

## Dependency Overrides

For custom test doubles, use `withDependencies` to override the HTTP client or other internals.

```swift
import Testing
import Dependencies
@testable import TMDB

struct CustomMockTests {
    @Test func customOverride() async throws {
        try await withDependencies {
            $0.httpClient = .init(
                data: { _ in
                    // Return custom mock data
                    (customJSON, HTTPURLResponse())
                }
            )
        } operation: {
            let movie = try await TMDB.movieDetails(id: 1)
            #expect(movie.title == "Custom Title")
        }
    }
}
```

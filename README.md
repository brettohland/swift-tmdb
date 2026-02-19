```
 ▗▄▄▖▄   ▄ ▄ ▗▞▀▀▘■      ▗▄▄▄▖▗▖  ▗▖▗▄▄▄  ▗▄▄▖ 
▐▌   █ ▄ █ ▄ ▐▌▗▄▟▙▄▖      █  ▐▛▚▞▜▌▐▌  █ ▐▌ ▐▌
 ▝▀▚▖█▄█▄█ █ ▐▛▀▘▐▌        █  ▐▌  ▐▌▐▌  █ ▐▛▀▚▖
▗▄▄▞▘      █ ▐▌  ▐▌        █  ▐▌  ▐▌▐▙▄▄▀ ▐▙▄▞▘
                 ▐▌                            

```
# `swift-tmdb`: A Modern TMDB Swift Package

A TMDB SDK that targets iOS/iPadOS 26 and uses Swift 6.2 and provides automatic mocked responses during unit testing
and in SwiftUI Previews.

[swift-tmdb Documentation](https://brettohland.github.io/swift-tmdb/documentation/tmdb/)

[See the Usage guide in the documentation](https://brettohland.github.io/swift-tmdb/documentation/tmdb/usage)

## Products

The package provides two library products:

- **`TMDB`** (default) includes mock JSON data for automatic mocked responses in tests and SwiftUI Previews.
- **`TMDBCore`** excludes the mock JSON data for smaller production bundles. Use `withDependencies` to provide your own test doubles.

```swift
// Full experience (automatic mocking):
.product(name: "TMDB", package: "swift-tmdb")

// Smaller bundle (no mock data):
.product(name: "TMDBCore", package: "swift-tmdb")
```

## Dependencies

Internally, the package uses [Point Free's Dependencies](https://github.com/pointfreeco/swift-dependencies) in order
to support the ability for the TMDB framework to provide real data when run in Testing or SwiftUI Preview environments.

## Advanced Usage

### Discovery Filters

The [Discover Movies](https://developer.themoviedb.org/reference/discover-movie) and [Discover TV](https://developer.themoviedb.org/reference/discover-tv)
endpoints include optional filters which allow for complex querying of data from the TMDB API.

These filters are first-class value types in framework and can be composited easily to replicate complex functionality.

- [Movie Filters Documentation](https://brettohland.github.io/swift-tmdb/documentation/tmdb/tmdb/discover/moviefilter)
- [TV Filters Documentation](https://brettohland.github.io/swift-tmdb/documentation/tmdb/tmdb/discover/tvfilter)

### Format Styles

Custom [Format Style](https://developer.apple.com/documentation/Foundation/FormatStyle) implementations which allow for
easy display of data coming from the TMDB API.

- [Runtime FormatStyle](https://brettohland.github.io/swift-tmdb/documentation/tmdb/runtime)

---

## Supported Endpoints

### V3

- Configuration
    - [Configuration Details](https://developer.themoviedb.org/reference/configuration-details)
    - [Countries](https://developer.themoviedb.org/reference/configuration-countries)
- Credits
    - [Credit Details](https://developer.themoviedb.org/reference/credit-details)
- Discover
    - [Movies](https://developer.themoviedb.org/reference/discover-movie)
    - [TV](https://developer.themoviedb.org/reference/discover-tv)
- Movies
    - [Movie Details](https://developer.themoviedb.org/reference/movie-details)
    - [Alternative Titles](https://developer.themoviedb.org/reference/movie-alternative-titles)

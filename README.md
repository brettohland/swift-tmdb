# TMDBSwifty: A Modern TMDB SDK

A TMDB SDK that targets iOS/iPadOS 26 and uses Swift 6.2.

Additionally, with the use of PointFree's Dependencies framework, there's in-built support for Testing and
SwiftUI Previews.

## Dependencies

Internally, the package uses [Point Free's Dependencies](https://github.com/pointfreeco/swift-dependencies) in order
to support the ability for the TMDBSwifty SDK to provide real data when run in Testing or SwiftUI Preview environments.

## Quick Start

### Get Your API Key
All requests to the TMDB API requires an API Key. Follow TMDB's [Getting Started](https://developer.themoviedb.org/docs/getting-started)
guide to get one.

### Initialize TMDBSwifty

Initialize the TMDB client with your TMDB API Key. This only needs to be done once, and it'd be best to do it as early
in your app's lifecycle as possible.

For example, if you're using the SwiftUI app lifecycle:

```swift
import SwiftUI
import TMDB

@main
struct TMDBSwifty_IntegrationApp: App {
    init() {
        initializeTMDB()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }

    private func initializeTMDB() {
        Task {
            do {
                try await TMDB.initialize(apiKey: "APIKEYHERE")
            } catch {
                print("Unable to initialize", error)
            }
        }
    }
}

```

### Getting Data

After initialization, there are two ways to use the TMDBSwifty module to request data from the TMDB API.

#### Using Static Methods

As an example, you can request a movie's details by calling the static `movieDetails` method on the `TMDB` enum:

```swift
import SwiftUI
import TMDB

struct MovieDetails: View {
    @State private var movie: TMDB.Movie?

    var body: some View {
        VStack {
            if let movie {
                Text(movie.title)
                    .font(.title)
                Text(movie.runtime, format: .runtime)
            } else {
                Text("Loading movie details")
                ProgressView()
            }
        }
        .padding()
        .task {
            do {
                let movie = try await TMDB.movieDetails(id: 278)
                withAnimation {
                    self.movie = movie
                }
            } catch {
                print(error)
            }
        }
    }
}
```

This view will show the details of

#### (Optional) Using Dependency Clients

TMDBSwifty also exposes a `DependencyClient` via PointFree's [https://github.com/pointfreeco/swift-dependencies] package.
To use the client, you'll need to import the `TMDBDependencies` as well as the `TMDB` module.

```swift
import SwiftUI
import TMDB
import TMDBDependencies

struct MovieDetails: View {
    @Dependency(\.tmdbMovies.movieDetails) var movieDetails

    @State private var movie: TMDB.Movie?

    var body: some View {
        VStack {
            if let movie {
                Text(movie.title)
                    .font(.title)
                Text(movie.runtime, format: .runtime)
            } else {
                Text("Loading movie details")
                ProgressView()
            }
        }
        .padding()
        .task {
            do {
                let movie = try await movieDetails(1)
                withAnimation {
                    self.movie = movie
                }
            } catch {
                print(error)
            }
        }
    }
}

```
## Advanced Usage

### Discovery Filters

The [Discover Movies](https://developer.themoviedb.org/reference/discover-movie) and [Discover TV](https://developer.themoviedb.org/reference/discover-tv)
endpoints include optional filters which allow for complex querying of data from the TMDB API.

These filters are first-class value types in TMDBSwifty and can be composited easily to replicate complex functionality.

[See filters documenation for more details](#)

### Format Styles

TMDBSwifty also includes custom [Format Style](https://developer.apple.com/documentation/Foundation/FormatStyle) implementations
which allow for easy display of data coming from the TMDB API.

- [Runtime FormatStyle](#)

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

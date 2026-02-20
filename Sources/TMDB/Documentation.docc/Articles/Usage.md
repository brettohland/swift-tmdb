# Usage

Instructions on initialization and usage of the `swift-tmdb` package.

## Requirements

`swift-tmdb` requires a TMDB API Key in order to function.

Follow their [Getting Started](https://developer.themoviedb.org/docs/getting-started) guide in order to get your key.

> Warning:
[Follow the best security practices](https://nshipster.com/secrets/) with your TMDB API Key and do not store it inside of your source code repository.

## Initializing

Initialize the TMDB client with your TMDB API Key. This only needs to be done once, and it'd be best to do it as early
in your app's lifecycle as possible.

For example, if you're using the SwiftUI app lifecycle:

```swift
import SwiftUI
import TMDB

@main
struct MyApp: App {
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

For more control, use ``TMDBConfiguration`` directly:

```swift
let config = TMDBConfiguration(
    apiKey: "APIKEYHERE",
    defaultLanguage: Locale(identifier: "en-US"),
    defaultRegion: Locale.Region("US")
)
try await TMDB.initialize(configuration: config)
```

The `defaultLanguage` and `defaultRegion` values are injected automatically into endpoints that support them. Per-request overrides always take precedence.

## Getting Data

After initialization, there are two ways to use the module to request data from the TMDB API.

### Using Static Methods

Call static methods directly on the `TMDB` enum. Here's an example fetching movie details:

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

The same pattern works across all endpoint categories — movies, TV series, seasons, episodes, search, discover, trending, and more:

```swift
// TV series
let series = try await TMDB.tvSeriesDetails(id: 1396)

// Search
let results = try await TMDB.searchMovies(query: "Inception")

// Trending
let trending = try await TMDB.trendingAll(timeWindow: .week)

// Discover with filters
let action = try await TMDB.discoverMovie(filters: [.withGenres([.and("28")]), .sortBy(.popularity, .descending)])
```

Calling these methods is safe from SwiftUI Previews and unit tests. `swift-tmdb` uses [PointFree's Dependencies](https://github.com/pointfreeco/swift-dependencies) to provide mock data automatically.

### (Optional) Using Dependency Clients

The `TMDBDependencies` module provides `@Dependency`-based clients for use with PointFree's [swift-dependencies](https://github.com/pointfreeco/swift-dependencies) package.

Available clients:

| Client | Dependency Key | Endpoints |
|--------|---------------|-----------|
| `MoviesClient` | `\.tmdbMovies` | All movie endpoints |
| `TVSeriesClient` | `\.tmdbTVSeries` | All TV series endpoints |
| `TVSeasonsClient` | `\.tmdbTVSeasons` | All TV season endpoints |
| `TVEpisodesClient` | `\.tmdbTVEpisodes` | All TV episode endpoints |
| `PeopleClient` | `\.tmdbPeople` | All people endpoints |
| `CompanyClient` | `\.tmdbCompany` | Company details and images |
| `NetworkClient` | `\.tmdbNetwork` | Network details and images |
| `AuthClient` | `\.tmdbAuth` | Authentication token and session management |
| `AccountClient` | `\.tmdbAccount` | Account lists, favorites, watchlist, ratings |
| `ListsClient` | `\.tmdbLists` | List CRUD and item management |
| `GuestSessionClient` | `\.tmdbGuestSession` | Guest session creation and rated content |

The `swift-dependencies` module is re-exported when importing `TMDBDependencies`.

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

Calling these methods is safe from SwiftUI Previews and unit tests. `swift-tmdb` uses [PointFree's Dependencies](https://github.com/pointfreeco/swift-dependencies) to provide mock data automatically.

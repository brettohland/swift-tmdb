# Usage

Instructions on initialization and usage of the `swift-tmdb` package.

## Requirements

TMDBSwifty requires a TMDB API Key in order to function. 

Follow their [Getting Started](https://developer.themoviedb.org/docs/getting-started) guild in order to get your key.

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


## Getting Data

After initialization, there are two ways to use the TMDBSwifty module to request data from the TMDB API.

### Using Static Methods

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
Calling this method is safe to do from SwiftUI Previews or from unit test cases. TMDBSwifty uses [PointFree's Dependencies](https://github.com/pointfreeco/swift-dependencies) module to provide your previews or tests with mock data.

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

Calling this method is safe to do from SwiftUI Previews or from unit test cases. TMDBSwifty uses [PointFree's Dependencies](https://github.com/pointfreeco/swift-dependencies) module to provide your previews or tests with mock data.

# Account and Lists

Manage favorites, watchlists, ratings, and custom lists for authenticated users.

## Overview

All operations in this article require authentication. See <doc:AuthenticationGuide> to set up a user session first.

## Favorites and Watchlist

Add or remove movies and TV series from a user's favorites or watchlist using ``TMDB/Account/MediaType`` to specify the media kind.

```swift
// Add a movie to favorites
try await TMDB.setFavorite(mediaType: .movie, mediaID: 550, favorite: true)

// Remove a TV series from favorites
try await TMDB.setFavorite(mediaType: .tv, mediaID: 1396, favorite: false)

// Add to watchlist
try await TMDB.setWatchlist(mediaType: .movie, mediaID: 550, watchlist: true)
```

## Ratings

Rate movies and TV on a scale of 0.5 to 10.0 (in 0.5 increments).

```swift
// Rate a movie
try await TMDB.rateMovie(id: 550, rating: 8.5)

// Delete a rating
try await TMDB.deleteMovieRating(id: 550)

// Rate a TV series
try await TMDB.rateTVSeries(id: 1396, rating: 9.0)

// Rate a specific episode
try await TMDB.rateTVEpisode(
    seriesID: 1396,
    seasonNumber: 1,
    episodeNumber: 1,
    rating: 9.5
)
```

## Reading Account Data

Fetch paginated lists of a user's favorites, ratings, watchlist, and recommendations.

```swift
let favorites = try await TMDB.favoriteMovies()
let rated = try await TMDB.ratedMovies()
let watchlist = try await TMDB.watchlistMovies()
let recommendations = try await TMDB.accountMovieRecommendations()

// With sorting and pagination
let sortedFavorites = try await TMDB.favoriteMovies(
    sortBy: .createdAtDescending,
    page: 2
)
```

## Lists

Create and manage custom lists using the v4 API.

```swift
// Create a list
let result = try await TMDB.createList(
    name: "My Favorites",
    description: "A collection of my all-time favorites"
)
let listID = result.id

// Add items (each item is a tuple of media type, ID, and optional comment)
try await TMDB.addItemsToList(listID: listID, items: [
    (mediaType: .movie, mediaID: 550, comment: "Classic"),
    (mediaType: .tv, mediaID: 1396, comment: nil),
])

// View list details
let details = try await TMDB.listDetails(listID: listID)

// Check if an item is in the list
let status = try await TMDB.listItemStatus(
    listID: listID,
    mediaType: .movie,
    mediaID: 550
)

// Remove items
try await TMDB.removeItemsFromList(listID: listID, items: [
    (mediaType: .movie, mediaID: 550),
])

// Clear all items
try await TMDB.clearList(listID: listID)

// Delete the list
try await TMDB.deleteList(listID: listID)
```

## Guest Sessions

Guest sessions allow unauthenticated users to rate content. Ratings are stored temporarily on TMDB's servers.

```swift
// Create a guest session
let guestSession = try await TMDB.createGuestSession()
let sessionID = guestSession.guestSessionID

// Rate a movie as a guest
try await TMDB.guestRateMovie(
    id: 550,
    rating: 7.5,
    guestSessionID: sessionID
)

// Retrieve guest-rated movies
let rated = try await TMDB.guestRatedMovies(sessionID: sessionID)

// Delete a guest rating
try await TMDB.guestDeleteMovieRating(id: 550, guestSessionID: sessionID)
```

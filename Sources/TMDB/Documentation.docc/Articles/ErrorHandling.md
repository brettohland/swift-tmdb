# Error Handling

Handle errors from TMDB API requests using typed throws.

## Overview

All public methods on `TMDB` use `async throws(TMDBRequestError)`, giving you exhaustive error handling at compile time.

## TMDBRequestError

The primary error type thrown by all API methods.

| Case | Description |
|------|-------------|
| `.networkError(TMDBAPIError)` | HTTP-level error from the TMDB API |
| `.systemError(any Error)` | Unexpected error (URL session failure, decoding error, etc.) |
| `.notAuthenticated` | Operation requires authentication but no session exists |
| `.authenticationCancelled` | User cancelled the browser-based auth flow |
| `.authenticationAlreadyInProgress` | Another auth flow is already active |
| `.imageConfigurationMissing` | Image configuration not yet loaded (call `TMDB.initialize` first) |
| `.unsupportedImageSize` | Requested image size not available for this image type |

## Handling Errors

```swift
do {
    let movie = try await TMDB.movieDetails(id: 550)
} catch .networkError(let apiError) {
    // HTTP error from TMDB (4xx or 5xx)
    print("API error: \(apiError)")
} catch .notAuthenticated {
    // Prompt user to sign in
    showSignIn = true
} catch .systemError(let underlying) {
    // Network failure, decoding error, etc.
    print("System error: \(underlying)")
} catch {
    print("Other error: \(error)")
}
```

## TMDBInitializationError

Thrown by ``TMDB/initialize(apiKey:urlSessionConfiguration:)`` and ``TMDB/initialize(configuration:)``.

| Case | Description |
|------|-------------|
| `.alreadyInitialized` | `initialize` was called more than once |
| `.notYetInitialized` | An API call was made before `initialize` |
| `.configurationFetchFailed` | The initial configuration fetch from TMDB failed |

## TMDBAPIError

The HTTP-level error type wrapped by `TMDBRequestError.networkError`.

| Case | Description |
|------|-------------|
| `.invalidResponseFromServer` | Response was not a valid HTTP response |
| `.clientError(HTTPURLResponse, Data)` | 4xx status code (unauthorized, not found, etc.) |
| `.serverError(HTTPURLResponse, Data)` | 5xx status code (TMDB server error) |

Extract the HTTP status code from a client error:

```swift
catch .networkError(.clientError(let response, _)) {
    switch response.statusCode {
    case 401: print("Invalid API key")
    case 404: print("Resource not found")
    default: print("Client error: \(response.statusCode)")
    }
}
```

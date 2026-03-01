# Authentication

Authenticate users with TMDB to enable account features, lists, and ratings.

## Overview

Authentication unlocks account-level features: managing favorites and watchlists, rating movies and TV shows, and creating lists. `swift-tmdb` provides platform-specific helpers for SwiftUI and UIKit, plus a manual flow for custom UIs.

## SwiftUI

Import `TMDBSwiftUI` and use the `.tmdbAuthentication` view modifier. It presents a browser-based OAuth flow and returns the result.

```swift
import SwiftUI
import TMDBSwiftUI

struct SettingsView: View {
    @State private var showAuth = false

    var body: some View {
        Button("Sign In with TMDB") {
            showAuth = true
        }
        .tmdbAuthentication(isPresented: $showAuth) { result in
            switch result {
            case .success(let session):
                print("Authenticated: \(session.accountID)")
            case .failure(let error):
                print("Auth failed: \(error)")
            }
        }
    }
}
```

## UIKit

Import `TMDBUIKit` and call `TMDB.authenticate(presentationAnchor:)` from a view controller.

```swift
import UIKit
import TMDBUIKit

class SettingsViewController: UIViewController {
    @IBAction func signInTapped(_ sender: Any) {
        Task {
            do {
                let session = try await TMDB.authenticate(
                    presentationAnchor: view.window!
                )
                print("Authenticated: \(session.accountID)")
            } catch {
                print("Auth failed: \(error)")
            }
        }
    }
}
```

## Manual Flow

For custom UIs, use ``TMDB/AuthenticationCoordinator`` directly. This gives you control over each step of the OAuth flow.

```swift
let coordinator = TMDB.AuthenticationCoordinator()

// Step 1: Create a request token and get the approval URL
let (requestToken, approvalURL) = try await coordinator.createRequestToken()

// Step 2: Open approvalURL in a browser for the user to approve
// When the browser redirects back to your app with a URL...

// Step 3: Complete authentication with the redirect URL
let session = try await coordinator.authenticate(browserRedirectURL: redirectURL)
print("Access token: \(session.accessToken)")
print("Account ID: \(session.accountID)")
```

## Logout

```swift
try await TMDB.logout()
```

This deletes the v4 access token, v3 session, and clears the keychain.

## Checking Auth State

Use ``TMDB/isAuthenticated`` and ``TMDB/currentSession`` to check the current state:

```swift
if TMDB.isAuthenticated {
    let session = TMDB.currentSession
    print("Logged in as \(session?.accountID ?? "")")
}
```

The ``TMDB/AuthSession`` struct provides the authenticated user's credentials:

| Property | Type | Description |
|----------|------|-------------|
| `accessToken` | `String` | v4 API access token |
| `accountID` | `String` | TMDB account identifier |
| `sessionID` | `String?` | v3 session ID (if converted) |

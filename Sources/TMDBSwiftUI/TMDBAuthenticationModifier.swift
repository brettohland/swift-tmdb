import AuthenticationServices
import SwiftUI
import TMDB

struct TMDBAuthenticationModifier: ViewModifier {
    @Binding var isPresented: Bool
    let onComplete: (Result<TMDB.AuthSession, TMDBRequestError>) -> Void

    @Environment(\.webAuthenticationSession) private var webAuthenticationSession

    func body(content: Content) -> some View {
        content
            .onChange(of: isPresented) { _, newValue in
                if newValue {
                    Task {
                        await performAuthentication()
                    }
                }
            }
    }

    private func performAuthentication() async {
        defer { isPresented = false }

        let coordinator = TMDB.AuthenticationCoordinator()

        do {
            let (_, approvalURL) = try await coordinator.createRequestToken()

            let callbackURL = try await webAuthenticationSession.authenticate(
                using: approvalURL,
                callback: .customScheme("tmdb-sdk"),
                additionalHeaderFields: [:],
            )

            let session = try await coordinator.authenticate(browserRedirectURL: callbackURL)
            onComplete(.success(session))
        } catch {
            if let tmdbError = error as? TMDBRequestError {
                onComplete(.failure(tmdbError))
            } else if (error as NSError).domain == ASWebAuthenticationSessionError.errorDomain,
                      (error as NSError).code == ASWebAuthenticationSessionError.canceledLogin.rawValue
            {
                onComplete(.failure(.authenticationCancelled))
            } else {
                onComplete(.failure(.systemError(error)))
            }
        }
    }
}

public extension View {
    func tmdbAuthentication(
        isPresented: Binding<Bool>,
        onComplete: @escaping (Result<TMDB.AuthSession, TMDBRequestError>) -> Void,
    ) -> some View {
        modifier(TMDBAuthenticationModifier(isPresented: isPresented, onComplete: onComplete))
    }
}

import AuthenticationServices
import TMDB

#if canImport(UIKit)
import UIKit

public extension TMDB {
    @MainActor
    static func authenticate(
        presentationAnchor: ASPresentationAnchor,
    ) async throws(TMDBRequestError) -> AuthSession {
        let coordinator = AuthenticationCoordinator()

        let (_, approvalURL) = try await coordinator.createRequestToken()

        let callbackURL: URL
        do {
            let session = ASWebAuthenticationSession(
                url: approvalURL,
                callback: .customScheme("tmdb-sdk"),
            )
            session.presentationContextProvider = PresentationContextProvider(anchor: presentationAnchor)
            callbackURL = try await session.start()
        } catch {
            let nsError = error as NSError
            if nsError.domain == ASWebAuthenticationSessionError.errorDomain,
               nsError.code == ASWebAuthenticationSessionError.canceledLogin.rawValue
            {
                throw .authenticationCancelled
            }
            throw .systemError(error)
        }

        return try await coordinator.authenticate(browserRedirectURL: callbackURL)
    }
}

private final class PresentationContextProvider: NSObject, ASWebAuthenticationPresentationContextProviding,
    @unchecked Sendable
{
    let anchor: ASPresentationAnchor

    init(anchor: ASPresentationAnchor) {
        self.anchor = anchor
    }

    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        anchor
    }
}

#endif

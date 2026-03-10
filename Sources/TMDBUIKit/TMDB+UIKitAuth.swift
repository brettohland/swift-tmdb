import AuthenticationServices
import TMDB

#if os(iOS) || targetEnvironment(macCatalyst)
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
            callbackURL = try await withCheckedThrowingContinuation { continuation in
                let session = ASWebAuthenticationSession(
                    url: approvalURL,
                    callback: .customScheme(TMDB.callbackScheme),
                    completionHandler: { url, error in
                        if let error {
                            continuation.resume(throwing: error)
                        } else if let url {
                            continuation.resume(returning: url)
                        } else {
                            continuation.resume(throwing: URLError(.badServerResponse))
                        }
                    },
                )
                session.presentationContextProvider = PresentationContextProvider(anchor: presentationAnchor)
                session.start()
            }
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

#endif // os(iOS) || targetEnvironment(macCatalyst)

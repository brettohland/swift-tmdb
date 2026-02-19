@_exported public import Dependencies
internal import DependenciesMacros
import Foundation
import TMDB

@DependencyClient
public struct NetworkClient: Sendable {
    public var networkDetails: @Sendable (_ id: Int) async throws -> TMDB.Network
    public var networkImages: @Sendable (_ id: Int) async throws -> TMDB.LogoCollection
}

public extension DependencyValues {
    var tmdbNetwork: NetworkClient {
        get { self[NetworkClient.self] }
        set { self[NetworkClient.self] = newValue }
    }
}

extension NetworkClient: DependencyKey {
    public static var liveValue: NetworkClient {
        Self(
            networkDetails: { try await TMDB.networkDetails(id: $0) },
            networkImages: { try await TMDB.networkImages(id: $0) },
        )
    }
}

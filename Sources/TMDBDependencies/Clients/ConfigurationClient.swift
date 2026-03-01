@_exported public import Dependencies
internal import DependenciesMacros
import Foundation
import TMDB

@DependencyClient
public struct ConfigurationClient: Sendable {
    public var imageConfiguration: @Sendable () -> TMDB.ImageConfiguration? = { nil }
    public var changeKeys: @Sendable () -> [TMDB.Configuration.ChangeKey] = { [] }
}

public extension DependencyValues {
    var tmdbConfiguration: ConfigurationClient {
        get { self[ConfigurationClient.self] }
        set { self[ConfigurationClient.self] = newValue }
    }
}

extension ConfigurationClient: DependencyKey {
    public static var liveValue: ConfigurationClient {
        Self(
            imageConfiguration: { TMDB.imageConfiguration },
            changeKeys: { TMDB.changeKeys },
        )
    }
}

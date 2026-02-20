@_exported public import Dependencies
internal import DependenciesMacros
import Foundation
import TMDB

@DependencyClient
public struct CompanyClient: Sendable {
    public var companyDetails: @Sendable (_ id: Int) async throws -> TMDB.Company
    public var companyImages: @Sendable (_ id: Int) async throws -> TMDB.LogoCollection
}

public extension DependencyValues {
    var tmdbCompany: CompanyClient {
        get { self[CompanyClient.self] }
        set { self[CompanyClient.self] = newValue }
    }
}

extension CompanyClient: DependencyKey {
    public static var liveValue: CompanyClient {
        Self(
            companyDetails: { try await TMDB.companyDetails(id: $0) },
            companyImages: { try await TMDB.companyImages(id: $0) },
        )
    }
}

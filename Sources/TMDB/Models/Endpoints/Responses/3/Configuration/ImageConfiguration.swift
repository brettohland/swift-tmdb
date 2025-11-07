import Foundation

extension TMDB.Configuration {
    struct ImageConfiguration: Codable {
        let baseUrl: URL?
        let secureBaseUrl: URL?
        @NilCodableArray
        var backdropSizes: [ImageSize]
        @NilCodableArray
        var logoSizes: [ImageSize]
        @NilCodableArray
        var posterSizes: [ImageSize]
        @NilCodableArray
        var profileSizes: [ImageSize]
        @NilCodableArray
        var stillSizes: [ImageSize]
    }
}

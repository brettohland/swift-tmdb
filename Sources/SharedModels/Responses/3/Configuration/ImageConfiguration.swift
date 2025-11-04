import Foundation

public extension TMDBInternal.Configuration {
    struct ImageConfiguration: Codable {
        public let baseUrl: URL?
        public let secureBaseUrl: URL?
        @NilCodableArray
        public var backdropSizes: [ImageSize]
        @NilCodableArray
        public var logoSizes: [ImageSize]
        @NilCodableArray
        public var posterSizes: [ImageSize]
        @NilCodableArray
        public var profileSizes: [ImageSize]
        @NilCodableArray
        public var stillSizes: [ImageSize]
    }
}

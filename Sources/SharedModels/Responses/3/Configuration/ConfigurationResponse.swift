import Foundation

public extension TMDBInternal.Configuration {
    struct Response: Codable {
        public let images: ImageConfiguration?
        @NilCodableArray
        public var changeKeys: [ChangeKey]
    }
}

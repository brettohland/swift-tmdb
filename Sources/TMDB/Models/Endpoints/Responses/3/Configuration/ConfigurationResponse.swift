import Foundation

extension TMDB.Configuration {
    struct Response: Codable {
        let images: ImageConfiguration?
        @NilCodableArray
        var changeKeys: [ChangeKey]
    }
}

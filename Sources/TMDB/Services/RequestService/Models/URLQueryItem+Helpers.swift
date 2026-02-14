import Foundation

extension [URLQueryItem] {
    mutating func append(_ key: TMDB.V3Endpoints.QueryItemKey, value: some QueryValueRepresentable) {
        append(key.rawValue, value: value)
    }

    mutating func appendIfPresent(_ key: TMDB.V3Endpoints.QueryItemKey, value: (some QueryValueRepresentable)?) {
        appendIfPresent(key.rawValue, value: value)
    }

    mutating func appendIfTrue(_ key: TMDB.V3Endpoints.QueryItemKey, value: Bool) {
        appendIfTrue(key.rawValue, value: value)
    }

    mutating func append(_ name: String, value: some QueryValueRepresentable) {
        append(URLQueryItem(name: name, value: value.queryValue))
    }

    mutating func appendIfPresent(_ name: String, value: (some QueryValueRepresentable)?) {
        guard let value else { return }
        append(URLQueryItem(name: name, value: value.queryValue))
    }

    mutating func appendIfTrue(_ name: String, value: Bool) {
        guard value else { return }
        append(URLQueryItem(name: name, value: true.queryValue))
    }
}

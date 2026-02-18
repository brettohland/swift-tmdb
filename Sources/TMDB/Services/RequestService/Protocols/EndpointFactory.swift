import Foundation

protocol EndpointFactory {
    func makeURL(baseURL: URL) -> URL
    var supportsLanguage: Bool { get }
    var supportsRegion: Bool { get }
}

extension EndpointFactory {
    var supportsLanguage: Bool { true }
    var supportsRegion: Bool { false }
}

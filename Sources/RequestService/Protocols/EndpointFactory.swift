import Foundation

public protocol EndpointFactory {
    func makeURL(baseURL: URL) -> URL
}

import Foundation

protocol EndpointFactory {
    func makeURL(baseURL: URL) -> URL
}

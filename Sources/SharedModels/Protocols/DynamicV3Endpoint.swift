import Foundation

public protocol DynamicV3Endpoint {
    func makeFinalURL(baseURL: URL) -> URL
}

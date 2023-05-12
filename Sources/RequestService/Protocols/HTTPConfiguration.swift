import Foundation

public protocol HTTPConfiguration {
    var host: String { get }
    var client: HTTPClient { get }
}

import Foundation

public protocol HTTPConfigurationProvider {
    var configuration: HTTPConfiguration { get }
}

import Foundation

public protocol QueryItemEncodable {
    var encoded: URLQueryItem { get }
}

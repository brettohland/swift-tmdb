import Foundation

struct MockRoute: Sendable {
    let pattern: String
    let dataProvider: @Sendable () throws -> Data
}

protocol MockRouteProvider {
    static var mockRoutes: [MockRoute] { get }
}

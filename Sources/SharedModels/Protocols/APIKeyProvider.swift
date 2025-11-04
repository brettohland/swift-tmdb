//import Dependencies
//import Foundation
//
//public protocol APIKeyProvider {
//    var apiKey: String { get }
//}
//
//enum APIKeyProviderKey: DependencyKey {
//    static var currentValue: APIKeyProvider = NotImplementedAPIKeyProvider()
//}
//
//public struct NotImplementedAPIKeyProvider: APIKeyProvider {
//    public var apiKey: String {
//        runtimeWarning("The APIKeyProvider needs to be set up before you can query TMDB. See the docs")
//        return ""
//    }
//}

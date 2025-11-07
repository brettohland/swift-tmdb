// import Dependencies
// import Foundation
//
// protocol APIKeyProvider {
//    var apiKey: String { get }
// }
//
// enum APIKeyProviderKey: DependencyKey {
//    static var currentValue: APIKeyProvider = NotImplementedAPIKeyProvider()
// }
//
// struct NotImplementedAPIKeyProvider: APIKeyProvider {
//     var apiKey: String {
//        runtimeWarning("The APIKeyProvider needs to be set up before you can query TMDB. See the docs")
//        return ""
//    }
// }

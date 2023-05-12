import Dependencies
import Foundation

private enum HTTPConfigurationProviderKey: DependencyKey {
    static var liveValue: HTTPConfigurationProvider = NotImplementedConfigurationProvider()
}

extension DependencyValues {
    var httpConfigProvider: HTTPConfigurationProvider {
        get { self[HTTPConfigurationProviderKey.self] }
        set { self[HTTPConfigurationProviderKey.self] = newValue }
    }
}

struct NotImplementedConfigurationProvider: HTTPConfigurationProvider {
    var configuration: HTTPConfiguration = NotImplementedConfiguration()
}

struct NotImplementedConfiguration: HTTPConfiguration {
    var host = ""
    var client: HTTPClient = InMemoryMockHTTPClient(mockedData: .init())
}

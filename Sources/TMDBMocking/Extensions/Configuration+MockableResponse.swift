import Foundation
import TMDB

extension TMDB.ConfigurationResponse: MockableResponse {
    static var mockFilename: String { "Details" }
}

public extension TMDB.ConfigurationResponse {
    static func mock() throws -> Self { try _loadMock() }
    static func mockData() throws -> Data { try _loadMockData() }
}

extension TMDB.Configuration.JobDepartment: MockableResponse {
    static var mockFilename: String { "Jobs" }
}

public extension TMDB.Configuration.JobDepartment {
    static func mock() throws -> Self { try _loadMock() }
    static func mockData() throws -> Data { try _loadMockData() }
}

extension TMDB.Configuration.Language: MockableResponse {
    static var mockFilename: String { "Languages" }
}

public extension TMDB.Configuration.Language {
    static func mock() throws -> Self { try _loadMock() }
    static func mockData() throws -> Data { try _loadMockData() }
}

extension TMDB.Configuration.Timezone: MockableResponse {
    static var mockFilename: String { "Timezones" }
}

public extension TMDB.Configuration.Timezone {
    static func mock() throws -> Self { try _loadMock() }
    static func mockData() throws -> Data { try _loadMockData() }
}

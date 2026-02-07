import Foundation

extension TMDB.ConfigurationResponse: MockableResponse {
    static var mockFilename: String {
        "Details"
    }
}

extension CountriesResponse: MockableResponse {
    static var mockFilename: String {
        "Countries"
    }
}

extension TMDB.Configuration.JobDepartment: MockableResponse {
    static var mockFilename: String {
        "Jobs"
    }
}

extension TMDB.Configuration.Language: MockableResponse {
    static var mockFilename: String {
        "Languages"
    }
}

extension TMDB.Configuration.Timezone: MockableResponse {
    static var mockFilename: String {
        "Timezones"
    }
}

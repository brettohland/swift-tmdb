import Foundation

public extension TMDB {
    struct Configuration {
        let api = Endpoint<ApiResponse>(path: "/configuration", method: .get)
        let countries = Endpoint<CountriesResponse>(path: "/configuration/countries", method: .get)
    }
}

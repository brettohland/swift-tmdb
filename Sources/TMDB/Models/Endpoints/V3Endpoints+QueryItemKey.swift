import Foundation

extension TMDB.V3Endpoints {
    enum QueryItemKey: String {
        case firstAirDateYear = "first_air_date_year"
        case includeAdult = "include_adult"
        case language
        case page
        case primaryReleaseYear = "primary_release_year"
        case query
        case region
        case year
    }
}

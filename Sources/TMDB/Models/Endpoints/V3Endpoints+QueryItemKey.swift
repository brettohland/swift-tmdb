import Foundation

extension TMDB.V3Endpoints {
    enum QueryItemKey: String {
        case endDate = "end_date"
        case firstAirDateYear = "first_air_date_year"
        case guestSessionID = "guest_session_id"
        case includeAdult = "include_adult"
        case language
        case page
        case primaryReleaseYear = "primary_release_year"
        case query
        case region
        case sessionID = "session_id"
        case sortBy = "sort_by"
        case startDate = "start_date"
        case year
    }
}

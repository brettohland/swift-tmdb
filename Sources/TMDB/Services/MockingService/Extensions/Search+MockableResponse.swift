import Foundation

extension TMDB.MultiSearchResult: MockableResponse {
    static var mockFilename: String {
        "SearchMulti"
    }
}

extension TMDB.SearchPerson: MockableResponse {
    static var mockFilename: String {
        "SearchPerson"
    }
}

extension TMDB.SearchCollection: MockableResponse {
    static var mockFilename: String {
        "SearchCollections"
    }
}

extension TMDB.SearchCompany: MockableResponse {
    static var mockFilename: String {
        "SearchCompanies"
    }
}

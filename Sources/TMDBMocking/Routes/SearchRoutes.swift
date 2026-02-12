import Foundation
import TMDB

enum SearchRoutes: MockRouteProvider {
    static var mockRoutes: [MockRoute] {
        [
            MockRoute(pattern: "^/3/search/movie$") {
                try MockUtilities.jsonDataFromFile("SearchMovies")
            },
            MockRoute(pattern: "^/3/search/tv$") {
                try MockUtilities.jsonDataFromFile("SearchTV")
            },
            MockRoute(pattern: "^/3/search/person$") {
                try TMDB.SearchPerson.mockData()
            },
            MockRoute(pattern: "^/3/search/multi$") {
                try TMDB.MultiSearchResult.mockData()
            },
            MockRoute(pattern: "^/3/search/collection$") {
                try TMDB.SearchCollection.mockData()
            },
            MockRoute(pattern: "^/3/search/company$") {
                try TMDB.SearchCompany.mockData()
            },
            MockRoute(pattern: "^/3/search/keyword$") {
                try MockUtilities.jsonDataFromFile("SearchKeywords")
            },
        ]
    }
}

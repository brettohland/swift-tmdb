import Foundation
import TMDB

enum GenreRoutes: MockRouteProvider {
    static var mockRoutes: [MockRoute] {
        [
            MockRoute(pattern: "^/3/genre/movie/list$") {
                try TMDB.GenreList.mockData()
            },
            MockRoute(pattern: "^/3/genre/tv/list$") {
                try MockUtilities.jsonDataFromFile("TVGenres")
            },
        ]
    }
}

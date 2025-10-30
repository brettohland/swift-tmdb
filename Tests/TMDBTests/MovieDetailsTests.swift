import Foundation
import Testing
@testable import TMDB

struct MovieDetailsTests {
    @Test func verifyMovieDetailsDecoding() throws {
        // Arrange
        let payload = try TestUtilities.jsonDataFromFile("MovieDetails")

        // Act & Assert
        _  = try TMDB.decoder.decode(TMDB.Movie.Details.self, from: payload)
    }
}

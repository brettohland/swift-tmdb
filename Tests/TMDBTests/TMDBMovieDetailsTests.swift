@testable import TMDB
import XCTest

final class TMDBMovieDetailsTests: XCTestCase {

    func testMovieDetailsDecoding() async throws {
        // Arrange
        let payload = try Utilities.data(inFile: "MovieDetails")

        // Act
        let actual = try TMDB.decoder.decode(TMDB.Movie.Details.self, from: payload)

        // Assert
        XCTAssertEqual(actual.adult, false)
    }

}

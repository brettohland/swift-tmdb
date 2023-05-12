@testable import TMDB
import XCTest

final class TMDBConfigurationTests: XCTestCase {
    func testApiConfigurationDecoding() throws {
        // Arrange
        let payload = try Utilities.data(inFile: "api")

        // Act
        let response = try TMDB.decoder.decode(TMDB.Configuration.ApiResponse.self, from: payload)

        guard let images = response.images else {
            throw TestError.objectNotFound
        }

        // Assert
        XCTAssertNotNil(images.baseUrl)
        XCTAssertNotNil(images.secureBaseUrl)
        XCTAssertEqual(images.backdropSizes.count, 4)
        XCTAssertEqual(images.logoSizes.count, 7)
        XCTAssertEqual(images.posterSizes.count, 7)
        XCTAssertEqual(images.profileSizes.count, 4)
        XCTAssertEqual(images.stillSizes.count, 4)
        XCTAssertEqual(response.changeKeys.count, 53)
    }

    func testCountriesConfigurationDecoding() throws {
        // Arrange
        let payload = try Utilities.data(inFile: "countries")

        // Act
        let response = try TMDB.noSnakeCaseDecoder.decode(TMDB.Configuration.CountriesResponse.self, from: payload)

        // Assert
        XCTAssertEqual(response.countries.count, 247)
    }

    func testImageConfigurationDecoding() throws {
        // Arrange
        let payload = try Utilities.data(inFile: "api")

        // Act
        let response = try TMDB.decoder.decode(TMDB.Configuration.ApiResponse.self, from: payload)

        // Assert
        XCTAssertEqual(response.images?.baseUrl, URL(string: "http://image.tmdb.org/t/p/"))
        XCTAssertEqual(response.images?.secureBaseUrl, URL(string: "https://image.tmdb.org/t/p/"))
        XCTAssertEqual(response.images?.backdropSizes.count, 4)
        XCTAssertEqual(
            response.images?.backdropSizes,
            [
                TMDB.Configuration.ImageSize.setWidth(300),
                TMDB.Configuration.ImageSize.setWidth(780),
                TMDB.Configuration.ImageSize.setWidth(1_280),
                TMDB.Configuration.ImageSize.original,
            ]
        )
        XCTAssertEqual(
            response.images?.profileSizes,
            [
                TMDB.Configuration.ImageSize.setWidth(45),
                TMDB.Configuration.ImageSize.setWidth(185),
                TMDB.Configuration.ImageSize.setHeight(632),
                TMDB.Configuration.ImageSize.original,
            ]
        )
    }
}

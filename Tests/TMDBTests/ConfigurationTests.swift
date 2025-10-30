import Testing
@testable import TMDB

struct ConfigurationTest {
    @Test func verifyConfigurationDecoding() async throws {
        // Arrange
        let htmlBody = try TestUtilities.jsonDataFromFile("api")

        // Act/Assert
        _ = try TMDB.decoder.decode(TMDB.Configuration.ApiResponse.self, from: htmlBody)
    }

}

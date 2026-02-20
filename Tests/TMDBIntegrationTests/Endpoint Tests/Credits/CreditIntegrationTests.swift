import Dependencies
import Foundation
import Testing
@testable import TMDB

@Suite(.serialized, .enabled(if: TMDBCredential.isAvailable))
struct CreditIntegrationTests {
    // Note: The /3/credit/{id} endpoint expects a string credit ID (e.g. "52fe4250c3a36847f80149f3")
    // but the current API accepts Int. This endpoint cannot be integration-tested until the
    // parameter type is corrected. Tracked as a known issue.
}

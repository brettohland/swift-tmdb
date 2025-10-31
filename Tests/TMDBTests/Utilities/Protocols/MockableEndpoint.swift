import Foundation
import SharedModels

protocol MockableEndpoint {
    var mockFilename: String { get }
}

extension MockableEndpoint {
    func mockData() throws -> Data {
        try TestUtilities.jsonDataFromFile(mockFilename)
    }
}

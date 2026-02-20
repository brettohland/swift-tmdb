import Foundation

protocol MockableResponse: Decodable {
    static var mockFilename: String { get }
}

extension MockableResponse {
    static func _loadMock() throws -> Self {
        let data = try _loadMockData()
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(Self.self, from: data)
    }

    static func _loadMockData() throws -> Data {
        try MockUtilities.jsonDataFromFile(mockFilename)
    }
}

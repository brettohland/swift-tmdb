import Foundation

protocol MockableResponse: Decodable {
    static var mockFilename: String { get }
}

extension MockableResponse {
    static func mock() throws -> Self {
        let data = try mockData()
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(Self.self, from: data)
    }

    static func mockData() throws -> Data {
        try MockUtilities.jsonDataFromFile(mockFilename)
    }
}

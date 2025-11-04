import Foundation
import SharedModels

public protocol MockableResponse: Decodable {
    static var mockFilename: String { get }
}

public extension MockableResponse {
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

public extension JSONEncoder {
    static var iso8601SnakeCake: JSONEncoder {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        encoder.keyEncodingStrategy = .convertToSnakeCase
        return encoder
    }
}

public extension JSONDecoder {
    static var iso8601SnakeCake: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }
}

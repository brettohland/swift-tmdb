import Foundation

enum MockUtilities {
    static func jsonDataFromFile(_ name: String) throws -> Data {
        guard let url = Bundle.module.url(forResource: name, withExtension: "json") else {
            throw MockResponseError.fileNotFound
        }
        return try Data(contentsOf: url)
    }
}

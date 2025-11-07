import Foundation

enum MockUtilities {
    private static func getData(forName name: String, fileExtension: String) throws -> Data {
        guard let payloadURL = Bundle.module.url(forResource: name, withExtension: fileExtension) else {
            throw MockResponseError.fileNotFound
        }
        return try Data(contentsOf: payloadURL)
    }

    static func jsonDataFromFile(_ name: String) throws -> Data {
        try getData(forName: name, fileExtension: "json")
    }
}

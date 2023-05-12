import Foundation

enum Utilities {

    static var cache: [String: Data] = [:]

    private static func getData(forName name: String) throws -> Data {
        guard let payloadURL = Bundle.module.url(forResource: name, withExtension: "json") else {
            throw TestError.fileNotFound
        }
        return try Data(contentsOf: payloadURL)
    }

    static func data(inFile name: String) throws -> Data {
        switch cache[name] {
        case .none:
            return try getData(forName: name)
        case .some(let data):
            return data
        }
    }
}

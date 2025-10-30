import Foundation

public enum MockDataError: Error {
    case noFile(named: String)
}

public enum MockData {
    public static func contents(ofFileNamed name: String) throws -> Data {
        guard let fileURL = Bundle.module.url(forResource: name, withExtension: "json") else {
            throw MockDataError.noFile(named: name)
        }
        return try Data(contentsOf: fileURL)
    }
}

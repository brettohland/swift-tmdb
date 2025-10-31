import Foundation

public enum URLFactory {
    private static let slashCharacterSet = CharacterSet(charactersIn: "/")

    public static func makeURL(
        baseURL url: URL,
        appending paths: [any StringProtocol] = [],
        queryItems: [URLQueryItem] = []
    ) -> URL {
        var finalURL = url
        if queryItems.isEmpty == false {
            finalURL.append(queryItems: queryItems)
        }
        guard paths.count > 0 else {
            return finalURL
        }
        // Remove any trailing slashes from the paths.
        let strippedPaths = paths
            .map { $0.description.trimmingCharacters(in: Self.slashCharacterSet) }
            .filter { $0.isEmpty == false }

        // If the user passes a bare slash as the final element of the paths array (eg. ["path1", "/"])
        // OR the last element of the array contains a trailing slash (eg. ["path1", "path2/"]), then we know that
        // they want the URL to be a directory path.
        let hasTrailingSlash = paths.last?.last == "/"

        for (index, path) in strippedPaths.enumerated() {
            let isLastElement = index == strippedPaths.endIndex - 1
            let directoryHint: URL.DirectoryHint = isLastElement && hasTrailingSlash ? .isDirectory : .inferFromPath
            let noDupesPath = path.replacingOccurrences(of: "/+", with: "/", options: .regularExpression)
            finalURL.append(path: noDupesPath, directoryHint: directoryHint)
        }
        return finalURL
    }
}

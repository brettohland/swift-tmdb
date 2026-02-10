import Foundation

package enum MockUtilities {
    package nonisolated(unsafe) static var mockResourceBundle: Bundle?

    private nonisolated(unsafe) static var discoveredBundle: Bundle?

    private static func getData(forName name: String, fileExtension: String) throws -> Data {
        guard let bundle = resolveBundle() else {
            throw MockResponseError.mockBundleNotAvailable
        }
        guard let payloadURL = bundle.url(forResource: name, withExtension: fileExtension) else {
            throw MockResponseError.fileNotFound
        }
        return try Data(contentsOf: payloadURL)
    }

    static func jsonDataFromFile(_ name: String) throws -> Data {
        try getData(forName: name, fileExtension: "json")
    }

    private static func resolveBundle() -> Bundle? {
        if let mockResourceBundle {
            return mockResourceBundle
        }
        if let discoveredBundle {
            return discoveredBundle
        }
        discoveredBundle = discoverMockBundle()
        return discoveredBundle
    }

    private static func discoverMockBundle() -> Bundle? {
        let bundleName = "swift-tmdb_TMDBMocking"

        // Inside main bundle (Xcode apps embed SPM resource bundles here)
        if let url = Bundle.main.url(forResource: bundleName, withExtension: "bundle"),
           let bundle = Bundle(url: url)
        {
            return bundle
        }

        // Use dladdr to find the binary containing this code, then walk up
        // to find the resource bundle. During `swift test`, Bundle.main points
        // to the SPM test runner, not the test binary — so we locate ourselves
        // via the DSO handle instead.
        var info = Dl_info()
        if dladdr(#dsohandle, &info) != 0, let fname = info.dli_fname {
            var searchURL = URL(filePath: String(cString: fname))
            for _ in 0 ..< 6 {
                searchURL = searchURL.deletingLastPathComponent()
                let candidate = searchURL.appendingPathComponent("\(bundleName).bundle")
                if let bundle = Bundle(url: candidate) {
                    return bundle
                }
            }
        }

        return nil
    }
}

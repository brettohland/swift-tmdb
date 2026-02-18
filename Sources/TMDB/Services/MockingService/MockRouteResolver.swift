import Foundation

enum MockRouteResolver {
    enum ResolverError: Error, CustomStringConvertible {
        case mockBundleNotFound
        case manifestNotFound
        case routeNotMatched(String)
        case missingURL
        case fileNotFound(String)

        var description: String {
            switch self {
            case .mockBundleNotFound:
                "TMDBMocking resource bundle not found. Ensure the TMDB library product (which includes TMDBMocking) is linked."
            case .manifestNotFound:
                "MockRoutes.json not found in TMDBMocking resource bundle."
            case .routeNotMatched(let path):
                "No mock route matched path: \(path)"
            case .missingURL:
                "URLRequest has no URL."
            case .fileNotFound(let name):
                "Mock JSON file not found: \(name).json"
            }
        }
    }

    private struct RouteEntry: Decodable {
        let pattern: String
        let file: String
    }

    private struct CompiledRoute: @unchecked Sendable {
        let regex: Regex<AnyRegexOutput>
        let file: String
    }

    private struct ResolvedRoutes: @unchecked Sendable {
        let bundle: Bundle
        let routes: [CompiledRoute]
    }

    private static let resolved: ResolvedRoutes? = {
        guard let bundle = discoverMockBundle() else { return nil }
        guard
            let manifestURL = bundle.url(forResource: "MockRoutes", withExtension: "json"),
            let manifestData = try? Data(contentsOf: manifestURL),
            let entries = try? JSONDecoder().decode([RouteEntry].self, from: manifestData)
        else {
            return nil
        }

        let compiled = entries.compactMap { entry -> CompiledRoute? in
            guard let regex = try? Regex(entry.pattern) else { return nil }
            return CompiledRoute(regex: regex, file: entry.file)
        }
        return ResolvedRoutes(bundle: bundle, routes: compiled)
    }()

    static func data(for request: URLRequest) throws -> Data {
        guard let url = request.url else {
            throw ResolverError.missingURL
        }

        guard let resolved else {
            throw ResolverError.mockBundleNotFound
        }

        let path = url.path()

        for route in resolved.routes {
            if path.contains(route.regex) {
                #if DEBUG
                print("[TMDBMocking] Matched \(route.file) for \(path)")
                #endif
                guard let fileURL = resolved.bundle.url(forResource: route.file, withExtension: "json") else {
                    throw ResolverError.fileNotFound(route.file)
                }
                return try Data(contentsOf: fileURL)
            }
        }

        #if DEBUG
        print("[TMDBMocking] Failed to match any known endpoints to \(path)")
        #endif
        throw ResolverError.routeNotMatched(path)
    }

    private static func discoverMockBundle() -> Bundle? {
        // Strategy 1: Search all loaded bundles for SPM resource bundle
        if let bundle = Bundle.allBundles.first(where: {
            $0.bundlePath.hasSuffix("_TMDBMocking.bundle")
        }) {
            return bundle
        }

        // Strategy 2: Check alongside the main bundle's executable
        if let executableURL = Bundle.main.executableURL {
            let buildDir = executableURL.deletingLastPathComponent()
            let candidates = (try? FileManager.default.contentsOfDirectory(
                at: buildDir,
                includingPropertiesForKeys: nil,
            )) ?? []
            for candidate in candidates where candidate.lastPathComponent.hasSuffix("_TMDBMocking.bundle") {
                if let bundle = Bundle(url: candidate) {
                    return bundle
                }
            }
        }

        // Strategy 3: Check main bundle's resource path
        if let resourceURL = Bundle.main.resourceURL {
            let candidates = (try? FileManager.default.contentsOfDirectory(
                at: resourceURL,
                includingPropertiesForKeys: nil,
            )) ?? []
            for candidate in candidates where candidate.lastPathComponent.hasSuffix("_TMDBMocking.bundle") {
                if let bundle = Bundle(url: candidate) {
                    return bundle
                }
            }
        }

        return nil
    }
}

import Foundation

/// A type that provides a logo image path for URL construction.
///
/// The TMDB API returns image paths as fragments (e.g., `/xRPaJMnQhHPceTGswlhUPsNPGxa.png`)
/// rather than complete URLs. Conforming types expose a ``logoPath`` property that can be
/// combined with the cached ``TMDB/imageConfiguration`` to build a fully-qualified image URL.
///
/// Conforming types include ``TMDB/ProductionCompany``, ``TMDB/Company``,
/// ``TMDB/Network``, ``TMDB/SearchCompany``, and ``TMDB/TVSeries/Network``.
///
/// ## Usage
///
/// ```swift
/// let company = try await TMDB.companyDetails(id: 1)
///
/// if let logoURL = try company.logoImageURL(size: .setWidth(154)) {
///     // Use logoURL to load the image
/// }
/// ```
///
/// ## Available Sizes
///
/// Use ``TMDB/imageConfiguration`` to inspect ``TMDB/ImageConfiguration/logoSizes``
/// and discover which sizes the API supports. Common logo sizes include `.setWidth(45)`,
/// `.setWidth(154)`, `.setWidth(500)`, and `.original`.
public protocol LogoImageProviding {
    /// The logo image path fragment, e.g. `"/xRPaJMnQhHPceTGswlhUPsNPGxa.png"`.
    var logoPath: String? { get }
}

public extension LogoImageProviding {
    /// Constructs a full logo image URL by combining the cached image configuration's
    /// secure base URL, the specified size, and this instance's ``logoPath``.
    ///
    /// - Parameter size: The desired image size (e.g., `.setWidth(154)` or `.original`).
    /// - Returns: A fully-qualified image URL, or `nil` if ``logoPath`` is `nil`.
    /// - Throws: ``TMDBRequestError/imageConfigurationMissing`` if ``TMDB/initialize(configuration:)``
    ///   has not been called, or ``TMDBRequestError/unsupportedImageSize(requested:supported:)`` if
    ///   the size is not in ``TMDB/ImageConfiguration/logoSizes``.
    func logoImageURL(
        size: TMDB.Configuration.ImageSize,
    ) throws(TMDBRequestError) -> URL? {
        guard let configuration = TMDB.imageConfiguration else {
            throw .imageConfigurationMissing
        }
        guard configuration.logoSizes.contains(size) else {
            throw .unsupportedImageSize(requested: size, supported: configuration.logoSizes)
        }
        guard let logoPath else { return nil }
        return URL(string: configuration.secureBaseUrl.absoluteString + size.rawValue + logoPath)
    }
}

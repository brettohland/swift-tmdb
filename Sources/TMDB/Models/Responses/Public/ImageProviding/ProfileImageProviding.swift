import Foundation

/// A type that provides a profile image path for URL construction.
///
/// The TMDB API returns image paths as fragments (e.g., `/xRPaJMnQhHPceTGswlhUPsNPGxa.jpg`)
/// rather than complete URLs. Conforming types expose a ``profilePath`` property that can be
/// combined with the cached ``TMDB/imageConfiguration`` to build a fully-qualified image URL.
///
/// Conforming types include ``TMDB/Person``, ``TMDB/CastMember``, ``TMDB/CrewMember``,
/// ``TMDB/PopularPerson``, ``TMDB/SearchPerson``, and other person-related response types.
///
/// > Note: ``TMDB/Credits/Person`` has a non-optional `profilePath: String` which cannot
/// > satisfy this protocol's `String?` requirement. It provides the same
/// > `profileImageURL(size:)` method directly via an extension instead.
///
/// ## Usage
///
/// ```swift
/// let person = try await TMDB.personDetails(id: 287)
///
/// if let profileURL = try person.profileImageURL(size: .setWidth(185)) {
///     // Use profileURL to load the image
/// }
/// ```
///
/// ## Available Sizes
///
/// Use ``TMDB/imageConfiguration`` to inspect ``TMDB/ImageConfiguration/profileSizes``
/// and discover which sizes the API supports. Common profile sizes include `.setWidth(45)`,
/// `.setWidth(185)`, `.setHeight(632)`, and `.original`.
public protocol ProfileImageProviding {
    /// The profile image path fragment, e.g. `"/xRPaJMnQhHPceTGswlhUPsNPGxa.jpg"`.
    var profilePath: String? { get }
}

public extension ProfileImageProviding {
    /// Constructs a full profile image URL by combining the cached image configuration's
    /// secure base URL, the specified size, and this instance's ``profilePath``.
    ///
    /// - Parameter size: The desired image size (e.g., `.setWidth(185)` or `.original`).
    /// - Returns: A fully-qualified image URL, or `nil` if ``profilePath`` is `nil`.
    /// - Throws: ``TMDBRequestError/imageConfigurationMissing`` if ``TMDB/initialize(configuration:)``
    ///   has not been called, or ``TMDBRequestError/unsupportedImageSize(requested:supported:)`` if
    ///   the size is not in ``TMDB/ImageConfiguration/profileSizes``.
    func profileImageURL(
        size: TMDB.Configuration.ImageSize,
    ) throws(TMDBRequestError) -> URL? {
        guard let configuration = TMDB.imageConfiguration else {
            throw .imageConfigurationMissing
        }
        guard configuration.profileSizes.contains(size) else {
            throw .unsupportedImageSize(requested: size, supported: configuration.profileSizes)
        }
        guard let profilePath else { return nil }
        return URL(string: configuration.secureBaseUrl.absoluteString + size.rawValue + profilePath)
    }
}

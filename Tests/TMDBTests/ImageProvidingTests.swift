import Foundation
import Testing
@testable import TMDB

@Suite("Image Providing Protocol Tests", .serialized)
struct ImageProvidingTests {
    let configuration = TMDB.ImageConfiguration(
        baseUrl: URL(string: "http://image.tmdb.org/t/p/"),
        secureBaseUrl: URL(string: "https://image.tmdb.org/t/p/")!,
        backdropSizes: [.setWidth(300), .setWidth(780), .setWidth(1_280), .original],
        logoSizes: [.setWidth(45), .setWidth(154), .setWidth(500), .original],
        posterSizes: [.setWidth(92), .setWidth(154), .setWidth(500), .original],
        profileSizes: [.setWidth(45), .setWidth(185), .setHeight(632), .original],
        stillSizes: [.setWidth(92), .setWidth(185), .setWidth(300), .original],
    )

    // MARK: - imageConfigurationMissing

    @Suite("Image Configuration Missing")
    struct ConfigurationMissingTests {
        struct MockPoster: PosterImageProviding {
            var posterPath: String?
        }

        init() {
            TMDB.imageConfiguration = nil
        }

        @Test("Throws imageConfigurationMissing when configuration is nil")
        func throwsWhenMissing() {
            let mock = MockPoster(posterPath: "/abc123.jpg")
            #expect(throws: TMDBRequestError.imageConfigurationMissing) {
                try mock.posterImageURL(size: .setWidth(500))
            }
        }

        @Test("Throws imageConfigurationMissing even when path is nil")
        func throwsWhenMissingEvenWithNilPath() {
            let mock = MockPoster(posterPath: nil)
            #expect(throws: TMDBRequestError.imageConfigurationMissing) {
                try mock.posterImageURL(size: .setWidth(500))
            }
        }
    }

    // MARK: - PosterImageProviding

    @Suite("PosterImageProviding")
    struct PosterTests {
        struct MockPoster: PosterImageProviding {
            var posterPath: String?
        }

        init() {
            TMDB.imageConfiguration = TMDB.ImageConfiguration(
                baseUrl: nil,
                secureBaseUrl: URL(string: "https://image.tmdb.org/t/p/")!,
                backdropSizes: [],
                logoSizes: [],
                posterSizes: [],
                profileSizes: [],
                stillSizes: [],
            )
        }

        @Test("Constructs correct poster URL")
        func constructsURL() throws {
            let mock = MockPoster(posterPath: "/abc123.jpg")
            let url = try mock.posterImageURL(size: .setWidth(500))
            #expect(url == URL(string: "https://image.tmdb.org/t/p/w500/abc123.jpg"))
        }

        @Test("Returns nil when posterPath is nil")
        func nilPath() throws {
            let mock = MockPoster(posterPath: nil)
            let url = try mock.posterImageURL(size: .setWidth(500))
            #expect(url == nil)
        }

        @Test("Uses original size")
        func originalSize() throws {
            let mock = MockPoster(posterPath: "/abc123.jpg")
            let url = try mock.posterImageURL(size: .original)
            #expect(url == URL(string: "https://image.tmdb.org/t/p/original/abc123.jpg"))
        }

        @Test("Uses height-based size")
        func heightSize() throws {
            let mock = MockPoster(posterPath: "/abc123.jpg")
            let url = try mock.posterImageURL(size: .setHeight(632))
            #expect(url == URL(string: "https://image.tmdb.org/t/p/h632/abc123.jpg"))
        }
    }

    // MARK: - BackdropImageProviding

    @Suite("BackdropImageProviding")
    struct BackdropTests {
        struct MockBackdrop: BackdropImageProviding {
            var backdropPath: String?
        }

        init() {
            TMDB.imageConfiguration = TMDB.ImageConfiguration(
                baseUrl: nil,
                secureBaseUrl: URL(string: "https://image.tmdb.org/t/p/")!,
                backdropSizes: [],
                logoSizes: [],
                posterSizes: [],
                profileSizes: [],
                stillSizes: [],
            )
        }

        @Test("Constructs correct backdrop URL")
        func constructsURL() throws {
            let mock = MockBackdrop(backdropPath: "/backdrop.jpg")
            let url = try mock.backdropImageURL(size: .setWidth(780))
            #expect(url == URL(string: "https://image.tmdb.org/t/p/w780/backdrop.jpg"))
        }

        @Test("Returns nil when backdropPath is nil")
        func nilPath() throws {
            let mock = MockBackdrop(backdropPath: nil)
            let url = try mock.backdropImageURL(size: .setWidth(780))
            #expect(url == nil)
        }
    }

    // MARK: - ProfileImageProviding

    @Suite("ProfileImageProviding")
    struct ProfileTests {
        struct MockProfile: ProfileImageProviding {
            var profilePath: String?
        }

        init() {
            TMDB.imageConfiguration = TMDB.ImageConfiguration(
                baseUrl: nil,
                secureBaseUrl: URL(string: "https://image.tmdb.org/t/p/")!,
                backdropSizes: [],
                logoSizes: [],
                posterSizes: [],
                profileSizes: [],
                stillSizes: [],
            )
        }

        @Test("Constructs correct profile URL")
        func constructsURL() throws {
            let mock = MockProfile(profilePath: "/profile.jpg")
            let url = try mock.profileImageURL(size: .setWidth(185))
            #expect(url == URL(string: "https://image.tmdb.org/t/p/w185/profile.jpg"))
        }

        @Test("Returns nil when profilePath is nil")
        func nilPath() throws {
            let mock = MockProfile(profilePath: nil)
            let url = try mock.profileImageURL(size: .setWidth(185))
            #expect(url == nil)
        }
    }

    // MARK: - LogoImageProviding

    @Suite("LogoImageProviding")
    struct LogoTests {
        struct MockLogo: LogoImageProviding {
            var logoPath: String?
        }

        init() {
            TMDB.imageConfiguration = TMDB.ImageConfiguration(
                baseUrl: nil,
                secureBaseUrl: URL(string: "https://image.tmdb.org/t/p/")!,
                backdropSizes: [],
                logoSizes: [],
                posterSizes: [],
                profileSizes: [],
                stillSizes: [],
            )
        }

        @Test("Constructs correct logo URL")
        func constructsURL() throws {
            let mock = MockLogo(logoPath: "/logo.png")
            let url = try mock.logoImageURL(size: .setWidth(154))
            #expect(url == URL(string: "https://image.tmdb.org/t/p/w154/logo.png"))
        }

        @Test("Returns nil when logoPath is nil")
        func nilPath() throws {
            let mock = MockLogo(logoPath: nil)
            let url = try mock.logoImageURL(size: .setWidth(154))
            #expect(url == nil)
        }
    }

    // MARK: - StillImageProviding

    @Suite("StillImageProviding")
    struct StillTests {
        struct MockStill: StillImageProviding {
            var stillPath: String?
        }

        init() {
            TMDB.imageConfiguration = TMDB.ImageConfiguration(
                baseUrl: nil,
                secureBaseUrl: URL(string: "https://image.tmdb.org/t/p/")!,
                backdropSizes: [],
                logoSizes: [],
                posterSizes: [],
                profileSizes: [],
                stillSizes: [],
            )
        }

        @Test("Constructs correct still URL")
        func constructsURL() throws {
            let mock = MockStill(stillPath: "/still.jpg")
            let url = try mock.stillImageURL(size: .setWidth(300))
            #expect(url == URL(string: "https://image.tmdb.org/t/p/w300/still.jpg"))
        }

        @Test("Returns nil when stillPath is nil")
        func nilPath() throws {
            let mock = MockStill(stillPath: nil)
            let url = try mock.stillImageURL(size: .setWidth(300))
            #expect(url == nil)
        }
    }

    // MARK: - ImageURLProviding

    @Suite("ImageURLProviding")
    struct ImageURLTests {
        struct MockImage: ImageURLProviding {
            var filePath: String
        }

        init() {
            TMDB.imageConfiguration = TMDB.ImageConfiguration(
                baseUrl: nil,
                secureBaseUrl: URL(string: "https://image.tmdb.org/t/p/")!,
                backdropSizes: [],
                logoSizes: [],
                posterSizes: [],
                profileSizes: [],
                stillSizes: [],
            )
        }

        @Test("Constructs correct image URL from filePath")
        func constructsURL() throws {
            let mock = MockImage(filePath: "/image.jpg")
            let url = try mock.imageURL(size: .original)
            #expect(url == URL(string: "https://image.tmdb.org/t/p/original/image.jpg"))
        }

        @Test("Uses width-based size")
        func widthSize() throws {
            let mock = MockImage(filePath: "/image.jpg")
            let url = try mock.imageURL(size: .setWidth(500))
            #expect(url == URL(string: "https://image.tmdb.org/t/p/w500/image.jpg"))
        }
    }
}

import Foundation

extension TMDB.V3Endpoints {
    enum People {
        case details(id: Int, language: Locale?)
        case movieCredits(id: Int, language: Locale?)
        case tvCredits(id: Int, language: Locale?)
        case combinedCredits(id: Int, language: Locale?)
        case externalIDs(id: Int)
        case images(id: Int)
        case translations(id: Int)
        case popular(page: Int, language: Locale?)
    }
}

extension TMDB.V3Endpoints.People: EndpointFactory {
    var supportsLanguage: Bool {
        switch self {
        case .externalIDs,
             .images,
             .translations:
            false
        default:
            true
        }
    }

    func makeURL(baseURL: URL) -> URL {
        var paths: [any StringProtocol] = ["3", "person"]
        var queryItems: [URLQueryItem] = []
        switch self {
        case .details(let id, let language):
            // /3/person/{id}
            paths.append(String(id))
            queryItems.appendIfPresent(.language, value: language)
        case .movieCredits(let id, let language):
            // /3/person/{id}/movie_credits
            paths += [String(id), "movie_credits"]
            queryItems.appendIfPresent(.language, value: language)
        case .tvCredits(let id, let language):
            // /3/person/{id}/tv_credits
            paths += [String(id), "tv_credits"]
            queryItems.appendIfPresent(.language, value: language)
        case .combinedCredits(let id, let language):
            // /3/person/{id}/combined_credits
            paths += [String(id), "combined_credits"]
            queryItems.appendIfPresent(.language, value: language)
        case .externalIDs(let id):
            // /3/person/{id}/external_ids
            paths += [String(id), "external_ids"]
        case .images(let id):
            // /3/person/{id}/images
            paths += [String(id), "images"]
        case .translations(let id):
            // /3/person/{id}/translations
            paths += [String(id), "translations"]
        case .popular(let page, let language):
            // /3/person/popular
            paths.append("popular")
            queryItems.append(.page, value: page)
            queryItems.appendIfPresent(.language, value: language)
        }
        return URLFactory.makeURL(baseURL: baseURL, appending: paths, queryItems: queryItems)
    }
}

// MARK: - Public /3/person/ endpoints

// MARK: Person Details

public extension TMDB {
    /// `/3/person/{id}`
    ///
    /// [API Documentation on TMDB](https://developer.themoviedb.org/reference/person-details)
    /// - Parameters:
    ///   - id: `Int` TMDB's unique identifier for the person
    ///   - language: Override the default language for this request
    /// - Returns: ``TMDB/Person``
    /// - Throws: ``TMDBRequestError``
    static func personDetails(id: Int, language: Locale? = nil) async throws(TMDBRequestError) -> Person {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, TMDB.Person>(
            endpoint: V3Endpoints.People.details(id: id, language: language),
            httpMethod: .get,
        )
        do {
            return try await endpoint.decodedResponse()
        } catch {
            throw .systemError(error)
        }
    }
}

// MARK: Person Movie Credits

public extension TMDB {
    /// `/3/person/{id}/movie_credits`
    ///
    /// [API Documentation on TMDB](https://developer.themoviedb.org/reference/person-movie-credits)
    /// - Parameters:
    ///   - id: `Int` TMDB's unique identifier for the person
    ///   - language: Override the default language for this request
    /// - Returns: ``TMDB/PersonMovieCredits``
    /// - Throws: ``TMDBRequestError``
    static func personMovieCredits(
        id: Int,
        language: Locale? = nil,
    ) async throws(TMDBRequestError) -> PersonMovieCredits {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, TMDB.PersonMovieCredits>(
            endpoint: V3Endpoints.People.movieCredits(id: id, language: language),
            httpMethod: .get,
        )
        do {
            return try await endpoint.decodedResponse()
        } catch {
            throw .systemError(error)
        }
    }
}

// MARK: Person TV Credits

public extension TMDB {
    /// `/3/person/{id}/tv_credits`
    ///
    /// [API Documentation on TMDB](https://developer.themoviedb.org/reference/person-tv-credits)
    /// - Parameters:
    ///   - id: `Int` TMDB's unique identifier for the person
    ///   - language: Override the default language for this request
    /// - Returns: ``TMDB/PersonTVCredits``
    /// - Throws: ``TMDBRequestError``
    static func personTVCredits(id: Int, language: Locale? = nil) async throws(TMDBRequestError) -> PersonTVCredits {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, TMDB.PersonTVCredits>(
            endpoint: V3Endpoints.People.tvCredits(id: id, language: language),
            httpMethod: .get,
        )
        do {
            return try await endpoint.decodedResponse()
        } catch {
            throw .systemError(error)
        }
    }
}

// MARK: Person Combined Credits

public extension TMDB {
    /// `/3/person/{id}/combined_credits`
    ///
    /// [API Documentation on TMDB](https://developer.themoviedb.org/reference/person-combined-credits)
    /// - Parameters:
    ///   - id: `Int` TMDB's unique identifier for the person
    ///   - language: Override the default language for this request
    /// - Returns: ``TMDB/PersonCombinedCredits``
    /// - Throws: ``TMDBRequestError``
    static func personCombinedCredits(
        id: Int,
        language: Locale? = nil,
    ) async throws(TMDBRequestError) -> PersonCombinedCredits {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, TMDB.PersonCombinedCredits>(
            endpoint: V3Endpoints.People.combinedCredits(id: id, language: language),
            httpMethod: .get,
        )
        do {
            return try await endpoint.decodedResponse()
        } catch {
            throw .systemError(error)
        }
    }
}

// MARK: Person External IDs

public extension TMDB {
    /// `/3/person/{id}/external_ids`
    ///
    /// [API Documentation on TMDB](https://developer.themoviedb.org/reference/person-external-ids)
    /// - Parameter id: `Int` TMDB's unique identifier for the person
    /// - Returns: ``TMDB/ExternalIDs``
    /// - Throws: ``TMDBRequestError``
    static func personExternalIDs(id: Int) async throws(TMDBRequestError) -> ExternalIDs {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, TMDB.ExternalIDs>(
            endpoint: V3Endpoints.People.externalIDs(id: id),
            httpMethod: .get,
        )
        do {
            return try await endpoint.decodedResponse()
        } catch {
            throw .systemError(error)
        }
    }
}

// MARK: Person Images

public extension TMDB {
    /// `/3/person/{id}/images`
    ///
    /// [API Documentation on TMDB](https://developer.themoviedb.org/reference/person-images)
    /// - Parameter id: `Int` TMDB's unique identifier for the person
    /// - Returns: ``TMDB/PersonImages``
    /// - Throws: ``TMDBRequestError``
    static func personImages(id: Int) async throws(TMDBRequestError) -> PersonImages {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, TMDB.PersonImages>(
            endpoint: V3Endpoints.People.images(id: id),
            httpMethod: .get,
        )
        do {
            return try await endpoint.decodedResponse()
        } catch {
            throw .systemError(error)
        }
    }
}

// MARK: Person Translations

public extension TMDB {
    /// `/3/person/{id}/translations`
    ///
    /// [API Documentation on TMDB](https://developer.themoviedb.org/reference/person-translations)
    /// - Parameter id: `Int` TMDB's unique identifier for the person
    /// - Returns: ``TMDB/TranslationCollection``
    /// - Throws: ``TMDBRequestError``
    static func personTranslations(id: Int) async throws(TMDBRequestError) -> TranslationCollection {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, TMDB.TranslationCollection>(
            endpoint: V3Endpoints.People.translations(id: id),
            httpMethod: .get,
        )
        do {
            return try await endpoint.decodedResponse()
        } catch {
            throw .systemError(error)
        }
    }
}

// MARK: Popular People

public extension TMDB {
    /// `/3/person/popular`
    ///
    /// [API Documentation on TMDB](https://developer.themoviedb.org/reference/person-popular-list)
    /// - Parameters:
    ///   - page: `Int` The page of results to return (default: 1)
    ///   - language: Override the default language for this request
    /// - Returns: `PaginatedResponse<PopularPerson>`
    /// - Throws: ``TMDBRequestError``
    static func popularPeople(page: Int = 1, language: Locale? = nil) async throws(TMDBRequestError) -> Discover
    .PaginatedResponse<PopularPerson> {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, TMDB.Discover.PaginatedResponse<TMDB.PopularPerson>>(
            endpoint: V3Endpoints.People.popular(page: page, language: language),
            httpMethod: .get,
        )
        do {
            return try await endpoint.decodedResponse()
        } catch {
            throw .systemError(error)
        }
    }
}

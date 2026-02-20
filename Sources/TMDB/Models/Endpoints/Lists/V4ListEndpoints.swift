internal import Dependencies
import Foundation

extension TMDB.V4Endpoints {
    enum Lists {
        case details(listID: Int, page: Int, sortBy: String?)
        case itemStatus(listID: Int, mediaType: String, mediaID: Int)
        case create
        case update(listID: Int)
        case delete(listID: Int)
        case addItems(listID: Int)
        case updateItems(listID: Int)
        case removeItems(listID: Int)
        case clear(listID: Int)
    }
}

extension TMDB.V4Endpoints.Lists: EndpointFactory {
    var supportsLanguage: Bool { false }

    func makeURL(baseURL: URL) -> URL {
        var paths: [any StringProtocol] = ["4", "list"]
        var queryItems: [URLQueryItem] = []
        switch self {
        case .details(let listID, let page, let sortBy):
            paths.append(String(listID))
            queryItems.append(.page, value: page)
            queryItems.appendIfPresent("sort_by", value: sortBy)
        case .itemStatus(let listID, let mediaType, let mediaID):
            paths.append(String(listID))
            paths.append("item_status")
            queryItems.append("media_type", value: mediaType)
            queryItems.append("media_id", value: mediaID)
        case .create:
            break
        case .update(let listID):
            paths.append(String(listID))
        case .delete(let listID):
            paths.append(String(listID))
        case .addItems(let listID):
            paths.append(String(listID))
            paths.append("items")
        case .updateItems(let listID):
            paths.append(String(listID))
            paths.append("items")
        case .removeItems(let listID):
            paths.append(String(listID))
            paths.append("items")
        case .clear(let listID):
            paths.append(String(listID))
            paths.append("clear")
        }
        return URLFactory.makeURL(baseURL: baseURL, appending: paths, queryItems: queryItems)
    }
}

// MARK: - List Details

public extension TMDB {
    /// `GET /4/list/{list_id}`
    ///
    /// [TMDB API Documentation](https://developer.themoviedb.org/v4/reference/list-details)
    /// - Parameters:
    ///   - listID: The list ID
    ///   - page: The page of results to return (default: 1)
    ///   - sortBy: Sort order for results (e.g. "original_order.asc")
    /// - Returns: ``TMDB/List/Details``
    /// - Throws: ``TMDBRequestError``
    static func listDetails(
        listID: Int,
        page: Int = 1,
        sortBy: String? = nil,
    ) async throws(TMDBRequestError) -> List.Details {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, List.Details>(
            endpoint: V4Endpoints.Lists.details(listID: listID, page: page, sortBy: sortBy),
            httpMethod: .get,
        )
        do {
            return try await endpoint.decodedResponse()
        } catch {
            throw .systemError(error)
        }
    }
}

// MARK: - List Item Status

public extension TMDB {
    /// `GET /4/list/{list_id}/item_status`
    ///
    /// [TMDB API Documentation](https://developer.themoviedb.org/v4/reference/list-item-status)
    /// - Parameters:
    ///   - listID: The list ID
    ///   - mediaType: The media type (.movie or .tv)
    ///   - mediaID: The media ID
    /// - Returns: ``TMDB/List/ItemStatus``
    /// - Throws: ``TMDBRequestError``
    static func listItemStatus(
        listID: Int,
        mediaType: Account.MediaType,
        mediaID: Int,
    ) async throws(TMDBRequestError) -> List.ItemStatus {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, List.ItemStatus>(
            endpoint: V4Endpoints.Lists.itemStatus(listID: listID, mediaType: mediaType.rawValue, mediaID: mediaID),
            httpMethod: .get,
        )
        do {
            return try await endpoint.decodedResponse()
        } catch {
            throw .systemError(error)
        }
    }
}

// MARK: - Create List

public extension TMDB {
    /// `POST /4/list`
    ///
    /// [TMDB API Documentation](https://developer.themoviedb.org/v4/reference/list-create)
    /// - Parameters:
    ///   - name: The name of the list
    ///   - description: The description of the list
    ///   - languageCode: The ISO 639-1 language code (default: "en")
    ///   - regionCode: The ISO 3166-1 region code (default: "US")
    ///   - isPublic: Whether the list is public (default: true)
    /// - Returns: ``TMDB/List/CreateResult``
    /// - Throws: ``TMDBRequestError``
    static func createList(
        name: String,
        description: String = "",
        languageCode: String = "en",
        regionCode: String = "US",
        isPublic: Bool = true,
    ) async throws(TMDBRequestError) -> List.CreateResult {
        let endpoint = Endpoint<CreateListBody, List.CreateResult>(
            endpoint: V4Endpoints.Lists.create,
            httpMethod: .post,
            requestBody: CreateListBody(
                name: name,
                description: description,
                iso6391: languageCode,
                iso31661: regionCode,
                isPublic: isPublic,
            ),
        )
        do {
            return try await endpoint.decodedResponse()
        } catch {
            throw .systemError(error)
        }
    }
}

// MARK: - Update List

public extension TMDB {
    /// `PUT /4/list/{list_id}`
    ///
    /// [TMDB API Documentation](https://developer.themoviedb.org/v4/reference/list-update)
    /// - Parameters:
    ///   - listID: The list ID
    ///   - name: Updated name (optional)
    ///   - description: Updated description (optional)
    ///   - isPublic: Updated visibility (optional)
    ///   - sortBy: Updated sort order (optional)
    /// - Returns: ``TMDB/Account/WriteResult``
    /// - Throws: ``TMDBRequestError``
    static func updateList(
        listID: Int,
        name: String? = nil,
        description: String? = nil,
        isPublic: Bool? = nil,
        sortBy: String? = nil,
    ) async throws(TMDBRequestError) -> Account.WriteResult {
        let endpoint = Endpoint<UpdateListBody, Account.WriteResult>(
            endpoint: V4Endpoints.Lists.update(listID: listID),
            httpMethod: .put,
            requestBody: UpdateListBody(
                name: name,
                description: description,
                isPublic: isPublic,
                sortBy: sortBy,
            ),
        )
        do {
            return try await endpoint.decodedResponse()
        } catch {
            throw .systemError(error)
        }
    }
}

// MARK: - Delete List

public extension TMDB {
    /// `DELETE /4/list/{list_id}`
    ///
    /// [TMDB API Documentation](https://developer.themoviedb.org/v4/reference/list-delete)
    /// - Parameter listID: The list ID
    /// - Returns: ``TMDB/Account/WriteResult``
    /// - Throws: ``TMDBRequestError``
    static func deleteList(
        listID: Int,
    ) async throws(TMDBRequestError) -> Account.WriteResult {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, Account.WriteResult>(
            endpoint: V4Endpoints.Lists.delete(listID: listID),
            httpMethod: .delete,
        )
        do {
            return try await endpoint.decodedResponse()
        } catch {
            throw .systemError(error)
        }
    }
}

// MARK: - Add Items to List

public extension TMDB {
    /// `POST /4/list/{list_id}/items`
    ///
    /// [TMDB API Documentation](https://developer.themoviedb.org/v4/reference/list-add-items)
    /// - Parameters:
    ///   - listID: The list ID
    ///   - items: Array of (mediaType, mediaID, comment) tuples to add
    /// - Returns: ``TMDB/List/ItemsResult``
    /// - Throws: ``TMDBRequestError``
    static func addItemsToList(
        listID: Int,
        items: [(mediaType: Account.MediaType, mediaID: Int, comment: String?)],
    ) async throws(TMDBRequestError) -> List.ItemsResult {
        let endpoint = Endpoint<ListItemsBody, List.ItemsResult>(
            endpoint: V4Endpoints.Lists.addItems(listID: listID),
            httpMethod: .post,
            requestBody: ListItemsBody(
                items: items.map {
                    ListItemEntry(mediaType: $0.mediaType.rawValue, mediaID: $0.mediaID, comment: $0.comment)
                },
            ),
        )
        do {
            return try await endpoint.decodedResponse()
        } catch {
            throw .systemError(error)
        }
    }
}

// MARK: - Update List Items

public extension TMDB {
    /// `PUT /4/list/{list_id}/items`
    ///
    /// [TMDB API Documentation](https://developer.themoviedb.org/v4/reference/list-update-items)
    /// - Parameters:
    ///   - listID: The list ID
    ///   - items: Array of (mediaType, mediaID, comment) tuples to update
    /// - Returns: ``TMDB/List/ItemsResult``
    /// - Throws: ``TMDBRequestError``
    static func updateListItems(
        listID: Int,
        items: [(mediaType: Account.MediaType, mediaID: Int, comment: String?)],
    ) async throws(TMDBRequestError) -> List.ItemsResult {
        let endpoint = Endpoint<ListItemsBody, List.ItemsResult>(
            endpoint: V4Endpoints.Lists.updateItems(listID: listID),
            httpMethod: .put,
            requestBody: ListItemsBody(
                items: items.map {
                    ListItemEntry(mediaType: $0.mediaType.rawValue, mediaID: $0.mediaID, comment: $0.comment)
                },
            ),
        )
        do {
            return try await endpoint.decodedResponse()
        } catch {
            throw .systemError(error)
        }
    }
}

// MARK: - Remove Items from List

public extension TMDB {
    /// `DELETE /4/list/{list_id}/items`
    ///
    /// [TMDB API Documentation](https://developer.themoviedb.org/v4/reference/list-remove-items)
    /// - Parameters:
    ///   - listID: The list ID
    ///   - items: Array of (mediaType, mediaID) tuples to remove
    /// - Returns: ``TMDB/List/ItemsResult``
    /// - Throws: ``TMDBRequestError``
    static func removeItemsFromList(
        listID: Int,
        items: [(mediaType: Account.MediaType, mediaID: Int)],
    ) async throws(TMDBRequestError) -> List.ItemsResult {
        let endpoint = Endpoint<ListItemsBody, List.ItemsResult>(
            endpoint: V4Endpoints.Lists.removeItems(listID: listID),
            httpMethod: .delete,
            requestBody: ListItemsBody(
                items: items.map {
                    ListItemEntry(mediaType: $0.mediaType.rawValue, mediaID: $0.mediaID, comment: nil)
                },
            ),
        )
        do {
            return try await endpoint.decodedResponse()
        } catch {
            throw .systemError(error)
        }
    }
}

// MARK: - Clear List

public extension TMDB {
    /// `GET /4/list/{list_id}/clear`
    ///
    /// [TMDB API Documentation](https://developer.themoviedb.org/v4/reference/list-clear)
    /// - Parameter listID: The list ID
    /// - Returns: ``TMDB/Account/WriteResult``
    /// - Throws: ``TMDBRequestError``
    static func clearList(
        listID: Int,
    ) async throws(TMDBRequestError) -> Account.WriteResult {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, Account.WriteResult>(
            endpoint: V4Endpoints.Lists.clear(listID: listID),
            httpMethod: .get,
        )
        do {
            return try await endpoint.decodedResponse()
        } catch {
            throw .systemError(error)
        }
    }
}

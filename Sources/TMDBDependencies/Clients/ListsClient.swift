@_exported public import Dependencies
internal import DependenciesMacros
import Foundation
import TMDB

@DependencyClient
public struct ListsClient: Sendable {
    /// Get the details and items of a list
    public var listDetails: @Sendable (_ listID: Int, _ page: Int, _ sortBy: String?) async throws -> TMDB.List.Details
    /// Check if an item is on a list
    public var listItemStatus: @Sendable (
        _ listID: Int,
        _ mediaType: TMDB.Account.MediaType,
        _ mediaID: Int,
    ) async throws -> TMDB.List.ItemStatus
    /// Create a new list
    public var createList: @Sendable (
        _ name: String,
        _ description: String,
        _ languageCode: String,
        _ regionCode: String,
        _ isPublic: Bool,
    ) async throws -> TMDB.List.CreateResult
    /// Update a list
    public var updateList: @Sendable (
        _ listID: Int,
        _ name: String?,
        _ description: String?,
        _ isPublic: Bool?,
        _ sortBy: String?,
    ) async throws -> TMDB.Account.WriteResult
    /// Delete a list
    public var deleteList: @Sendable (_ listID: Int) async throws -> TMDB.Account.WriteResult
    /// Add items to a list
    public var addItemsToList: @Sendable (
        _ listID: Int,
        _ items: [(mediaType: TMDB.Account.MediaType, mediaID: Int, comment: String?)],
    ) async throws -> TMDB.List.ItemsResult
    /// Update items on a list
    public var updateListItems: @Sendable (
        _ listID: Int,
        _ items: [(mediaType: TMDB.Account.MediaType, mediaID: Int, comment: String?)],
    ) async throws -> TMDB.List.ItemsResult
    /// Remove items from a list
    public var removeItemsFromList: @Sendable (
        _ listID: Int,
        _ items: [(mediaType: TMDB.Account.MediaType, mediaID: Int)],
    ) async throws -> TMDB.List.ItemsResult
    /// Clear all items from a list
    public var clearList: @Sendable (_ listID: Int) async throws -> TMDB.Account.WriteResult
}

public extension DependencyValues {
    /// Dependency that represents the TMDB lists endpoints
    var tmdbLists: ListsClient {
        get { self[ListsClient.self] }
        set { self[ListsClient.self] = newValue }
    }
}

extension ListsClient: DependencyKey {
    public static var liveValue: ListsClient {
        Self(
            listDetails: {
                try await TMDB.listDetails(listID: $0, page: $1, sortBy: $2)
            },
            listItemStatus: {
                try await TMDB.listItemStatus(listID: $0, mediaType: $1, mediaID: $2)
            },
            createList: {
                try await TMDB.createList(name: $0, description: $1, languageCode: $2, regionCode: $3, isPublic: $4)
            },
            updateList: {
                try await TMDB.updateList(listID: $0, name: $1, description: $2, isPublic: $3, sortBy: $4)
            },
            deleteList: {
                try await TMDB.deleteList(listID: $0)
            },
            addItemsToList: {
                try await TMDB.addItemsToList(listID: $0, items: $1)
            },
            updateListItems: {
                try await TMDB.updateListItems(listID: $0, items: $1)
            },
            removeItemsFromList: {
                try await TMDB.removeItemsFromList(listID: $0, items: $1)
            },
            clearList: {
                try await TMDB.clearList(listID: $0)
            },
        )
    }
}

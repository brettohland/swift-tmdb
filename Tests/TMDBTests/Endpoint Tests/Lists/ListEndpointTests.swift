import Dependencies
import Foundation
import Testing
@testable import TMDB
import TMDBMocking

struct ListEndpointTests {
    // MARK: - Helper

    private func withMockSession(_ operation: () async throws -> Void) async throws {
        try await withDependencies {
            $0.authSessionStore = .init(
                load: {
                    TMDB.AuthSession(
                        accessToken: "mock_access_token",
                        accountID: "mock_account_id",
                        sessionID: "mock_session_id",
                    )
                },
                save: { _ in },
                clear: {},
            )
        } operation: {
            try await operation()
        }
    }

    // MARK: - Functional Tests

    @Test func listDetails() async throws {
        let result = try await TMDB.listDetails(listID: 8_136)
        #expect(result.id == 8_136)
        #expect(result.name == "Top Sci-Fi Films")
        #expect(result.numberOfItems == 2)
        #expect(result.page == 1)
        #expect(result.results.count == 2)
        #expect(result.results[0].id == 157_336)
        #expect(result.results[0].title == "Interstellar")
        #expect(result.results[0].mediaType == "movie")
        #expect(result.createdBy.username == "johndoe")
    }

    @Test func listItemStatus() async throws {
        let result = try await TMDB.listItemStatus(listID: 8_136, mediaType: .movie, mediaID: 157_336)
        #expect(result.id == "8136")
        #expect(result.mediaType == "movie")
        #expect(result.mediaID == 157_336)
        #expect(result.isSuccess)
    }

    @Test func createList() async throws {
        let result = try await TMDB.createList(name: "My List")
        #expect(result.id == 9_001)
        #expect(result.isSuccess)
        #expect(result.statusCode == 1)
    }

    @Test func updateList() async throws {
        let result = try await TMDB.updateList(listID: 8_136, name: "Updated Name")
        #expect(result.statusCode == 1)
        #expect(result.statusMessage == "Success.")
    }

    @Test func deleteList() async throws {
        let result = try await TMDB.deleteList(listID: 8_136)
        #expect(result.statusCode == 1)
        #expect(result.statusMessage == "Success.")
    }

    @Test func addItemsToList() async throws {
        let result = try await TMDB.addItemsToList(
            listID: 8_136,
            items: [
                (mediaType: .movie, mediaID: 550, comment: "Great film"),
                (mediaType: .tv, mediaID: 1_396, comment: nil),
            ],
        )
        #expect(result.isSuccess)
        #expect(result.results.count == 2)
        #expect(result.results[0].mediaType == "movie")
        #expect(result.results[0].mediaID == 550)
        #expect(result.results[0].isSuccess)
    }

    @Test func updateListItems() async throws {
        let result = try await TMDB.updateListItems(
            listID: 8_136,
            items: [(mediaType: .movie, mediaID: 550, comment: "Updated comment")],
        )
        #expect(result.isSuccess)
        #expect(!result.results.isEmpty)
    }

    @Test func removeItemsFromList() async throws {
        let result = try await TMDB.removeItemsFromList(
            listID: 8_136,
            items: [(mediaType: .movie, mediaID: 550)],
        )
        #expect(result.isSuccess)
        #expect(!result.results.isEmpty)
    }

    @Test func clearList() async throws {
        let result = try await TMDB.clearList(listID: 8_136)
        #expect(result.statusCode == 1)
        #expect(result.statusMessage == "Success.")
    }

    // MARK: - URL Generation

    @Test func listDetailsURL() {
        let endpoint = TMDB.V4Endpoints.Lists.details(listID: 8_136, page: 1, sortBy: nil)
        let url = endpoint.makeURL(baseURL: TMDB.Constants.baseURL)
        #expect(url.relativePath == "/4/list/8136")
    }

    @Test func listDetailsURLWithSortBy() {
        let endpoint = TMDB.V4Endpoints.Lists.details(listID: 8_136, page: 2, sortBy: "original_order.asc")
        let url = endpoint.makeURL(baseURL: TMDB.Constants.baseURL)
        #expect(url.relativePath == "/4/list/8136")
    }

    @Test func listItemStatusURL() {
        let endpoint = TMDB.V4Endpoints.Lists.itemStatus(listID: 8_136, mediaType: "movie", mediaID: 550)
        let url = endpoint.makeURL(baseURL: TMDB.Constants.baseURL)
        #expect(url.relativePath == "/4/list/8136/item_status")
    }

    @Test func createListURL() {
        let endpoint = TMDB.V4Endpoints.Lists.create
        let url = endpoint.makeURL(baseURL: TMDB.Constants.baseURL)
        #expect(url.relativePath == "/4/list")
    }

    @Test func updateListURL() {
        let endpoint = TMDB.V4Endpoints.Lists.update(listID: 8_136)
        let url = endpoint.makeURL(baseURL: TMDB.Constants.baseURL)
        #expect(url.relativePath == "/4/list/8136")
    }

    @Test func addItemsURL() {
        let endpoint = TMDB.V4Endpoints.Lists.addItems(listID: 8_136)
        let url = endpoint.makeURL(baseURL: TMDB.Constants.baseURL)
        #expect(url.relativePath == "/4/list/8136/items")
    }

    @Test func clearListURL() {
        let endpoint = TMDB.V4Endpoints.Lists.clear(listID: 8_136)
        let url = endpoint.makeURL(baseURL: TMDB.Constants.baseURL)
        #expect(url.relativePath == "/4/list/8136/clear")
    }
}

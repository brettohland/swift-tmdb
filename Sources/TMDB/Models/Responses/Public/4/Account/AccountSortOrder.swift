import Foundation

public extension TMDB.Account {
    enum SortOrder: String, Codable, Sendable {
        case createdAtAscending = "created_at.asc"
        case createdAtDescending = "created_at.desc"
    }
}

extension TMDB.Account.SortOrder: QueryValueRepresentable {
    var queryValue: String { rawValue }
}

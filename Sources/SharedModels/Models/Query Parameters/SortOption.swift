import Foundation

public enum SortOption: QueryValueRepresentable {
    case popularity(isAscending: Bool)
    case releaseDate(isAscending: Bool)
    case revenue(isAscending: Bool)
    case primaryReleaseDate(isAscending: Bool)
    case originalTitle(isAscending: Bool)
    case averageVote(isAscending: Bool)
    case voteCount(isAscending: Bool)

    public var queryValue: String {
        let ascending = ".asc"
        let descending = ".desc"
        switch self {
        case .popularity(let isAscending):
            return "popularity" + (isAscending ? ascending : descending)
        case .releaseDate(let isAscending):
            return "release_date" + (isAscending ? ascending : descending)
        case .revenue(let isAscending):
            return "revenue" + (isAscending ? ascending : descending)
        case .primaryReleaseDate(let isAscending):
            return "primary_release_date" + (isAscending ? ascending : descending)
        case .originalTitle(let isAscending):
            return "original_title" + (isAscending ? ascending : descending)
        case .averageVote(let isAscending):
            return "average_vote" + (isAscending ? ascending : descending)
        case .voteCount(let isAscending):
            return "vote_count" + (isAscending ? ascending : descending)
        }
    }
}

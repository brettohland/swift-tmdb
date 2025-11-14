import Foundation

public extension TMDB.Discover {
    /// Options of how to sort the results based of various properties
    enum SortOption: String, Sendable {
        case popularity
        case releaseDate = "release_date"
        case revenue
        case primaryReleaseDate = "primary_release_date"
        case originalTitle = "original_title"
        case averageVote = "average_vote"
        case voteCount = "vote_count"
    }

    /// How to sort the results, either descending or ascending order
    enum SortOptionOrder: String, Sendable {
        case ascending = "asc"
        case descending = "desc"
    }
}

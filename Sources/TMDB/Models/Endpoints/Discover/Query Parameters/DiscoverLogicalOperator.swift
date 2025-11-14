import Foundation

public extension TMDB.Discover {
    /// Adds `AND` and `OR` logic support to a given filter.
    enum LogicalOperator<T: CustomStringConvertible>: CustomStringConvertible {
        case and(T)
        case or(T)

        public var description: String {
            switch self {
            case .and(let value):
                ",\(value)"
            case .or(let value):
                "|\(value)"
            }
        }
    }
}

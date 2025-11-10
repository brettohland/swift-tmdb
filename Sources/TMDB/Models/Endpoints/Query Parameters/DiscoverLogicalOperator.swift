import Foundation

extension TMDB.Discover {
    enum LogicalOperator<T: CustomStringConvertible>: CustomStringConvertible {
        case and(T)
        case or(T)

        var description: String {
            switch self {
            case .and(let value):
                ",\(value)"
            case .or(let value):
                "|\(value)"
            }
        }
    }
}

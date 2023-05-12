import Foundation

public extension TMDB {
    struct ParameterList: QueryValueRepresentable {
        let filter: FilterType
        let list: [CustomStringConvertible]

        public init(filter: FilterType, list: [CustomStringConvertible]) {
            self.filter = filter
            self.list = list
        }

        public var queryValue: String {
            list.map(\.description).joined(separator: filter.character)
        }
    }
}

public extension TMDB.ParameterList {
    enum FilterType {
        case and
        case or

        var character: String {
            switch self {
            case .and:
                return ","
            case .or:
                return "|"
            }
        }
    }
}

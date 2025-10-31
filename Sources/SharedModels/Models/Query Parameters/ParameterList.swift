import Foundation

public extension TMDBInternal {
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

public extension TMDBInternal.ParameterList {
    enum FilterType {
        case and
        case or

        var character: String {
            switch self {
            case .and:
                ","
            case .or:
                "|"
            }
        }
    }
}

import Foundation

public extension HTTP {
    struct EmptyRequestBody: Encodable {
        public func encode(to encoder: Encoder) throws {}
    }

    struct EmptyResponseBody: Decodable {
        init() {}
        public init(from decoder: Decoder) throws { self.init() }
    }
}

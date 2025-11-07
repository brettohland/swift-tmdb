import Foundation

extension HTTP {
    struct EmptyRequestBody: Encodable {
        func encode(to encoder: Encoder) throws {}
    }

    struct EmptyResponseBody: Decodable {
        init() {}
        init(from decoder: Decoder) throws { self.init() }
    }
}

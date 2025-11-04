import Foundation
import RequestService
import SharedModels

extension TMDBInternal.V3Endpoints: EndpointRoot {
    public static var rootPaths: [String] {
        ["3"]
    }
}

struct Endpoint: LosslessStringConvertible {

    let value: String

    init?(_ description: String) {
        self.value = description
    }

    var description: String {
        self.value
    }
}

extension Endpoint: ExpressibleByStringInterpolation {
    init(stringLiteral value: String) {
        self.init(value)!
    }
    init(stringInterpolation: StringInterpolation) {
        self.init(stringInterpolation.value)!
    }

    struct StringInterpolation: StringInterpolationProtocol {
        var value: String = ""

        init(literalCapacity: Int, interpolationCount: Int) {
            self.value.reserveCapacity(literalCapacity)
        }

        mutating func appendLiteral(_ literal: StringLiteralType) {
            self.value.append(literal)
        }

        mutating func appendInterpolation<T>(_ value: T) where T: CustomStringConvertible {
            // So the interpolation here
            self.value.append(value.description)
        }
    }
}

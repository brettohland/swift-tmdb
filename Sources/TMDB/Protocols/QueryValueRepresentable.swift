import Foundation

protocol QueryValueRepresentable {
    var queryValue: String { get }
}

extension Locale: QueryValueRepresentable {
    var queryValue: String {
        identifier
    }
}

extension Locale.Region: QueryValueRepresentable {
    var queryValue: String {
        identifier
    }
}

extension Locale.Language: QueryValueRepresentable {
    var queryValue: String {
        languageCode!.identifier
    }
}

extension StringLiteralType: QueryValueRepresentable {
    var queryValue: String {
        self
    }
}

extension Bool: QueryValueRepresentable {
    var queryValue: String {
        self ? "true" : "false"
    }
}

extension Int: QueryValueRepresentable {
    var queryValue: String {
        String(self)
    }
}

extension Double: QueryValueRepresentable {
    var queryValue: String {
        String(self)
    }
}

extension Array: QueryValueRepresentable where Element: CustomStringConvertible {
    // You can only extend an array to conform to a protocol once, regardless of if there are different constraints on
    // it.
    // So we have to get a little tricky here and handle bare items (
    var queryValue: String {
        let logicalCharacterSet = CharacterSet(charactersIn: "|, ")
        let reducedString = reduce("") { partialResult, element in
            let elementString = element.description
            switch elementString.first {
            case ",":
                return partialResult.appending(elementString)
            case "|":
                return partialResult.appending(elementString)
            default:
                return partialResult.appending("\(elementString),")
            }
        }
        return reducedString.trimmingCharacters(in: logicalCharacterSet)
    }
}

extension Date: QueryValueRepresentable {
    var queryValue: String {
        formatted(.iso8601.year().month().day())
    }
}

extension TimeZone: QueryValueRepresentable {
    var queryValue: String {
        identifier
    }
}

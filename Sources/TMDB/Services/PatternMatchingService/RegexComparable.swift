import Foundation

protocol RegexComparable {
    var patternString: String { get }
}

extension RegexComparable {
    func pattern() throws -> Regex<Substring> {
        try Regex(patternString)
    }
}

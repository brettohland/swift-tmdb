import Foundation

protocol RegexComparable {
    var pattern: Regex<Substring> { get }
}

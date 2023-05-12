import Foundation

public protocol QueryValueRepresentable {
    var queryValue: String { get }
}

extension Locale: QueryValueRepresentable {
    public var queryValue: String {
        identifier
    }
}

extension StringLiteralType: QueryValueRepresentable {
    public var queryValue: String {
        self
    }
}

extension Bool: QueryValueRepresentable {
    public var queryValue: String {
        self ? "true" : "false"
    }
}

extension Int: QueryValueRepresentable {
    public var queryValue: String {
        String(self)
    }
}

extension Double: QueryValueRepresentable {
    public var queryValue: String {
        String(self)
    }
}

extension [StringLiteralType]: QueryValueRepresentable {
    public var queryValue: String {
        map(\.description).joined(separator: ",")
    }
}

extension Date: QueryValueRepresentable {
    public var queryValue: String {
        formatted(.iso8601.year().month().day())
    }
}

extension Locale.Region: QueryValueRepresentable {
    public var queryValue: String {
        identifier
    }
}

extension TimeZone: QueryValueRepresentable {
    public var queryValue: String {
        identifier
    }
}

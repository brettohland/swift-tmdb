// import Foundation
//
// extension Date {
//    struct ReleaseDateFormatStyle: Foundation.FormatStyle {
//        func format(_ value: Date) -> String {
//            value.formatted(
//                .verbatim(
//                    "\(year: .defaultDigits)-\(month: .twoDigits)-\(day: .twoDigits)",
//                    timeZone: .current,
//                    calendar: Calendar(identifier: .gregorian)
//                )
//            )
//        }
//    }
// }
//
// extension Date.ReleaseDateFormatStyle {
//    struct ParseStrategy: Foundation.ParseStrategy {
//        typealias ParseInput = String
//        typealias ParseOutput = Date
//        func parse(_ value: ParseInput) throws -> ParseOutput {
//            try Date(
//                value,
//                strategy: Date.ParseStrategy(
//                    format: "\(year: .defaultDigits)-\(month: .twoDigits)-\(day: .twoDigits)",
//                    timeZone: .current
//                )
//            )
//        }
//    }
// }
//
// extension Date.ReleaseDateFormatStyle: ParseableFormatStyle {
//    var parseStrategy: Date.ReleaseDateFormatStyle.ParseStrategy {
//        .init()
//    }
// }
//
// extension FormatStyle where Self == Date.FormatStyle {
//    static var releaseDate: any FormatStyle { Date.ReleaseDateFormatStyle() }
// }

import Foundation

extension Data {
    var prettyJSON: String? {
        do {
            let json = try JSONSerialization.jsonObject(with: self, options: [])
            let data = try JSONSerialization.data(withJSONObject: json, options: [.prettyPrinted, .sortedKeys])
            return String(data: data, encoding: .utf8)
        } catch {
            return nil
        }
    }
}

import Foundation

extension Data {
    var prettyJSON: String {
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = String(data: data, encoding: String.Encoding.utf8) else {
                  return String(data: self, encoding: String.Encoding.utf8) ?? ""
              }
        return prettyPrintedString
    }
}

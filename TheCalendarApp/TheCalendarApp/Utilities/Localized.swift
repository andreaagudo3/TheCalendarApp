import Foundation

func localized(_ string: String, fallback: String = "") -> String {
    return NSLocalizedString(string, comment: "")
}

func localizedFormat(_ string: String, fallback: String, arguments: [String]) -> String {
    return String(format: localized(string, fallback: fallback), arguments: arguments)
}

func localized(with value: String, in string: String) -> String {
    return String.localizedStringWithFormat(localized(string), value)
}

func localized(_ string: String, forLanguageCode lanCode: String) -> String {
    guard
        let bundlePath = Bundle.main.path(forResource: lanCode, ofType: "lproj"),
        let bundle = Bundle(path: bundlePath)
    else { return "" }

    return NSLocalizedString(
        string,
        bundle: bundle,
        value: " ",
        comment: ""
    )
}


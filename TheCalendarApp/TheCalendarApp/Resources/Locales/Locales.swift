import Foundation

struct Locales {
    static let appLocale = localized("app_locale", fallback: "en_US")
    static func spacesFor(arg0: String) -> String {
        return localized(with: arg0, in: "spaces_for")
    }
    static let bookSpace = localized("book_space", fallback: "Book a space")
    static let noSpacesAvailable = localized("no_spaces_available", fallback: "No spaces available")
}

import Foundation

struct Locales {
    static let appLocale = localized("app_locale", fallback: "en_US")
    static func bookingsFor(arg0: String) -> String {
        return localized(with: arg0, in: "bookings_for")
    }
    static let bookSpace = localized("book_space", fallback: "Book a space")
}

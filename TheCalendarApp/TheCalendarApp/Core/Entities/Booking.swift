import Foundation

class BookingsResponse: Decodable {
    let bookings: [Booking]

    required public init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        bookings = try container.decodeArray(Booking.self)
    }
}

struct Booking: Decodable {
    var startsAt: Date
    var endsAt: Date
    var spaceName: String
    var spaceTimezone: String
    var spaceImage: URL?
    
    func hourRange(format: String, timezone: String) -> String {
        return "\(startsAtDescription(format: format, timezone: timezone))-\(endsAtDescription(format: format, timezone: timezone))"
    }
    
    func startsAtDescription(format: String, timezone: String) -> String {
        return startsAt.withFormat(format, fromTimezone: self.spaceTimezone, toTimezone: timezone)
    }
    
    func endsAtDescription(format: String, timezone: String) -> String {
        return endsAt.withFormat(format, fromTimezone: self.spaceTimezone, toTimezone: timezone)
    }
    
    enum CodingKeys: String, CodingKey {
        case startsAt = "starts_at"
        case endsAt = "ends_at"
        case spaceName = "space_name"
        case spaceTimezone = "space_timezone"
        case spaceImage = "space_image"
    }
}

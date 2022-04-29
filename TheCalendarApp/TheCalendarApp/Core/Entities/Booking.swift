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
    
    func startEndDescription(format: String, timezone: String) -> String {
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
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        spaceTimezone = try container.decode(String.self, forKey: .spaceTimezone)
        spaceName = try container.decodeIfPresent(String.self, forKey: .spaceName) ?? "-"
        spaceImage = try container.decodeIfPresent(URL.self, forKey: .spaceImage)
        
        if let startsAtStr = try container.decodeIfPresent(String.self, forKey: .startsAt) {
            if let date = Date(formattedDate: startsAtStr) {
                startsAt = date
            } else {
                fatalError("Booking startAt format is not valid")
            }
        } else {
            fatalError("Booking is missing startAt")
        }
        
        if let endsAtStr = try container.decodeIfPresent(String.self, forKey: .endsAt) {
            if let date = Date(formattedDate: endsAtStr) {
                endsAt = date
            } else {
                fatalError("Booking endsAt format is not valid")
            }
        } else {
            fatalError("Booking is missing endsAt")
        }
    }
}

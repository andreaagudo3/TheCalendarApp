import Foundation

extension Date {
    static let defaultDateFormatter = DateFormatter()

    static let sharedDateFormatter: DateFormatter = {
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormats.databaseFormat
        dateFormatter.locale = .current
        return dateFormatter
    }()
    
    init?(formattedDate dateString: String) {
        if let date = Date.sharedDateFormatter.date(from: dateString) {
            self = date
            return
        }
        
        return nil
    }
    
    init?(formattedDate dateString: String, format: String = DateFormats.databaseFormat) {
        Date.sharedDateFormatter.dateFormat = format
        if let date = Date.sharedDateFormatter.date(from: dateString) {
            self = date
            return
        }

        return nil
    }
    
    func withFormat(_ format: String,
                    fromTimezone: String? = nil,
                    toTimezone: String? = nil) -> String {
        
        if let fromTZ = fromTimezone,
           let fromValue = TimeZone(identifier: fromTZ),
           let toTZ = toTimezone,
           let toValue = TimeZone(identifier: toTZ) {
            
            let convertedDate = convert(from: fromValue,to: toValue)
            Date.sharedDateFormatter.dateFormat = format
            return Date.sharedDateFormatter.string(from: convertedDate)
        } else {
            Date.sharedDateFormatter.dateFormat = format
            return Date.sharedDateFormatter.string(from: self)
        }
    }
    
    var isToday: Bool {
        return Calendar.current.isDateInToday(self)
    }
    
    func isSameDay(to date: Date?) -> Bool {
        guard let date = date else { return false }
        return Calendar.current.isDate(self, inSameDayAs: date)
    }
    
    var startOfDay: Date {
        return Calendar.current.startOfDay(for: self)
    }
    
    func dayIsBefore(than date: Date) -> Bool {
        return self.startOfDay < date.startOfDay
    }
}

// MARK: Timezones conversion
extension Date {
    private func convert(from inputTimeZone: TimeZone,
                         to outputTimeZone: TimeZone) -> Date {
        var calendar = Calendar.current
        calendar.timeZone = outputTimeZone
        return calendar.dateBySetting(timeZone: inputTimeZone, of: self)!
    }
}

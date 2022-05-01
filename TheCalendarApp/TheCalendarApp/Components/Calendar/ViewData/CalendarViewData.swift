import Foundation
import JTAppleCalendar

struct CalendarViewData {
    var highlightedDates: [Date]
    var startDate: Date
    var endDate: Date
    var numerOfRows: Int = 6
    var firstDayOfWeek: DaysOfWeek = .monday
    
    // TODO: Add selected date in case we want to have preselected date or save alst selecion.
}

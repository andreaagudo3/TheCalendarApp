import Foundation
import JTAppleCalendar

struct CalendarViewData {
    var highlightedDays: [CalendarDay]
    var startDate: Date
    var endDate: Date
    var numerOfRows: Int
    var firstDayOfWeek: DaysOfWeek
    
    // TODO: Add selected date in case we want to have preselected date or save alst selecion.
}

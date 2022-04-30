import Foundation

// MARK: Presenter comunication
protocol CalendarPresentation: AnyObject {
    var title: String { get }
    var calendarDaysWithBookings: [CalendarDay] { get }
    func cellViewDataType(_ section: Int) -> [BookingsCellType]
    func numberOfObjects(_ section: Int) -> Int
    func getBookings()
    func handleDateSelection(date: Date)
}


// MARK: Interface performance
protocol CalendarViewInterface: AnyObject {
    func refreshBookingsList()
    func refreshCalendar()
    func updateBookingInfo(booking: String)
    func showBookingView(_ show: Bool)
}

// MARK: Navigation
protocol CalendarSceneDelegate: AnyObject  {
}

enum BookingsCellType {
    case booking(BookingCellViewData)
}


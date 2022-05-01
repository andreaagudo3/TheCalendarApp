import Foundation

// MARK: Presenter comunication
protocol CalendarPresentation: AnyObject {
    var title: String { get }
    var calendarViewData: CalendarViewData { get }
    func getBookings()
    func handleDateSelection(date: Date)
    
    // TODO: Create generic protocol
    func cellsViewDataType(_ section: Int) -> [BookingsListCellType]
    func sectionHeaderViewData(_ section: Int) -> BookingsListSectionHeader
    func numberOfObjects(_ section: Int) -> Int
    func numberOfSections() -> Int
}

// MARK: Interface performance
protocol CalendarViewInterface: AnyObject {
    func refreshBookingsList()
    func refreshCalendar()
}

// MARK: Navigation
protocol CalendarSceneDelegate: AnyObject  {
}

// MARK: Bookings List
struct BookingsListSectionHeader {
    let title: String
}

enum BookingsListSection: Int, CaseIterable {
    case bookings
}

enum BookingsListCellType {
    case booking(BookingCellViewData)
    case emptySection(String)
}


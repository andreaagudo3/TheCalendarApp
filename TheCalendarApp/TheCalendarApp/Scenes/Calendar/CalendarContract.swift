import Foundation

// MARK: Presenter comunication
protocol CalendarPresentation: AnyObject {
    var title: String { get }
    func getBookings()
    func handleDateSelection(date: Date)
}

// MARK: Interface performance
protocol CalendarViewInterface: AnyObject {
    func setBookings(_ bookings: [String])
    func updateBookingInfo(booking: String)
    func showBookingView(_ show: Bool)
}

// MARK: Navigation
protocol CalendarSceneDelegate: AnyObject  {
}


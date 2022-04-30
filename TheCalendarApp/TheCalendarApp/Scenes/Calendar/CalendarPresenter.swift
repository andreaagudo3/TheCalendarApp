import Foundation

class CalendarPresenter {

    weak var delegate: CalendarSceneDelegate?
    weak var view: CalendarViewInterface!
    var title: String = Locales.bookSpace
    
    // Private
    private var bookings: [Booking] = []
    private var selectedDate: Date?
    
    // Public
    var calendarDaysWithBookings: [CalendarDay] {
        let calendarDays = bookings.map({
            CalendarDay(date: $0.startsAt,
                        isAvailable: true,
                        hasBookings: true)
        })
        
        return calendarDays
    }
    
    init(view: CalendarViewInterface) {
        self.view = view
    }
    
    private func createBookingsCells() -> [BookingsCellType] {
        guard let selectedDate = selectedDate else {
            return []
        }

        let bookingsOfSelectedDate = bookings.filter({
            !$0.startsAt.isSameDay(to: selectedDate)
        })
        
        return bookingsOfSelectedDate.map({
            BookingsCellType.booking(.init(
                title: Locales.bookingsFor(arg0: $0.startsAt.withFormat(DateFormats.dayMonth)),
                spaceName: $0.spaceName,
                hourRange: $0.hourRange(format: DateFormats.hourFormat, timezone: "UCT"),
                imageUrl: $0.spaceImage
            ))
        })
    }
}

extension CalendarPresenter: CalendarPresentation {
    func getBookings() {
        let fileName = "bookings"
        let path = Bundle.main.path(forResource: fileName, ofType: "json")!
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let articlesFromFile = try decoder.decode(BookingsResponse.self, from: data)
            
            self.bookings = articlesFromFile.bookings
            self.view.refreshCalendar()
        } catch {
            fatalError("Json \(fileName) does not exist or is corrupted")
        }    }
    
    func handleDateSelection(date: Date) {
        selectedDate = date
        self.view.refreshBookingsList()
    }
    
    // MARK: Bookings List
    func numberOfObjects(_ section: Int) -> Int {
        guard let selectedDate = selectedDate else { return 0 }
        
        let bookingsOfSelectedDate = bookings.filter({
            $0.startsAt.isSameDay(to: selectedDate)
        })
        return bookingsOfSelectedDate.count
    }
    
    func cellViewDataType(_ section: Int) -> [BookingsCellType] {
        // TODO: Take in consideration section in case we want to add differents in the future
        var cellViewData: [BookingsCellType] = []
        cellViewData.append(contentsOf: createBookingsCells())
        
        return cellViewData
    }
    
}

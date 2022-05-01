import Foundation

class CalendarPresenter {

    weak var delegate: CalendarSceneDelegate?
    weak var view: CalendarViewInterface!
    var title: String = Locales.bookSpace
    
    // MARK: Private
    private var bookings: [Booking] = []
    private var selectedDate: Date?
    private var datesWithBookings: [Date] {
        return bookings.map({
            $0.startsAt
        })
    }
    
    // MARK: Public
    var calendarViewData: CalendarViewData {
        // TODO: Delete hardcoded startDate
        return CalendarViewData(
            highlightedDates: datesWithBookings,
            startDate: Date(formattedDate: "2010 01 01", format: "yyyy MM dd")!,
            endDate: Calendar.current.date(byAdding: .month, value: 12, to: Date())!
        )
    }
    
    init(view: CalendarViewInterface) {
        self.view = view
    }
    
    private func createBookingsCells() -> [BookingsListCellType] {
        guard let selectedDate = selectedDate else {
            return []
        }

        let bookingsOfSelectedDate = bookings.filter({
            $0.startsAt.isSameDay(to: selectedDate)
        })
        
        if bookingsOfSelectedDate.isEmpty {
            return [.emptySection(Locales.noSpacesAvailable)]
        } else {
            return bookingsOfSelectedDate.map({
                BookingsListCellType.booking(.init(
                    spaceName: $0.spaceName,
                    hourRange: $0.hourRange(format: DateFormats.hourFormat, timezone: User.timezone),
                    imageUrl: $0.spaceImage
                ))
            })
        }
    }
}

// MARK: CalendarPresentation
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
        }
    }
    
    func handleDateSelection(date: Date) {
        selectedDate = date
        self.view.refreshBookingsList()
    }
    
    // MARK: Bookings List
    func numberOfSections() -> Int {
        selectedDate == nil ? 0 : BookingsListSection.allCases.count
    }
    
    func numberOfObjects(_ section: Int) -> Int {
        return self.cellsViewDataType(section).count
    }
    
    func sectionHeaderViewData(_ section: Int) -> BookingsListSectionHeader {
        switch BookingsListSection(rawValue: section) {
        case .bookings:
            return .init(title: Locales.spacesFor(arg0: selectedDate?.withFormat(DateFormats.dayMonth) ?? ""))
        case .none:
            return .init(title: "")
        }
    }
    
    func cellsViewDataType(_ section: Int) -> [BookingsListCellType] {
        var cellsViewDataType: [BookingsListCellType] = []
        switch BookingsListSection(rawValue: section) {
        case .bookings:
            cellsViewDataType.append(contentsOf: createBookingsCells())
        case .none:
            break
        }
        return cellsViewDataType
    }
    
}

import UIKit
import JTAppleCalendar

final class CalendarView: UIView {
    
    @IBOutlet weak var calendarHeaderLabel: UILabel!
    @IBOutlet weak var calendarView: JTACMonthView!
    @IBOutlet weak var weekDaysStack: UIStackView!
    @IBOutlet weak var contentView: UIStackView!

    var onDateSelected: ((Date) -> Void)?
    private var testCalendar = Calendar(identifier: .gregorian)
    private var parameters = ConfigurationParameters(startDate: Date(), endDate: Date())
    
    // TODO: Handle preselected day
    private var selectedDay: CalendarDay?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadViewFromNib(nibName: CalendarView.reuseID)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadViewFromNib(nibName: CalendarView.reuseID)
        setup()
    }
    
    func setViewData(_ viewData: CalendarViewData) {
        configureWeekDaysStack(firstDayOfWeek: viewData.firstDayOfWeek)
        parameters = ConfigurationParameters(startDate: viewData.startDate,
                                             endDate: viewData.endDate,
                                             numberOfRows: viewData.numerOfRows,
                                             calendar: testCalendar,
                                             generateInDates: .forAllMonths,
                                             generateOutDates: .tillEndOfGrid,
                                             firstDayOfWeek: viewData.firstDayOfWeek)
        
        calendarView.reloadData()
        
        if let firstDate = viewData.highlightedDays.first?.date {
            calendarView.scrollToDate(firstDate, animateScroll: false)
        }
    }
    
    func selectDate(_ date: Date) {
        calendarView.selectDates([date], triggerSelectionDelegate: true)
        calendarView.scrollToDate(date, animateScroll: false)
    }
}

// MARK: Private
extension CalendarView {
    private func setup() {
        // Calendar
        setCalendar()
        self.calendarView.visibleDates {[unowned self] (visibleDates: DateSegmentInfo) in
            self.setupViewsOfCalendar(from: visibleDates)
        }
        
        contentView.cornerRadius = ViewConstants.cornerRadius
        contentView.layer.masksToBounds = true
    }

    private func setupViewsOfCalendar(from visibleDates: DateSegmentInfo) {
        guard let startDate = visibleDates.monthDates.first?.date else {
            return
        }
        
        calendarHeaderLabel.text = startDate.withFormat(DateFormats.Calendar.calendarTitleFormat).uppercased()
    }
    
    private func setCalendar() {
        testCalendar.locale = .current
        
        calendarView.calendarDataSource = self
        calendarView.calendarDelegate = self
        
        let nibName = UINib(nibName: CalendarCell.reuseID, bundle: nil)
        calendarView.register(nibName, forCellWithReuseIdentifier: CalendarCell.reuseID)
        calendarView.minimumLineSpacing = 0
        calendarView.minimumInteritemSpacing = 0
    }
    
    private func configureWeekDaysStack(firstDayOfWeek: DaysOfWeek) {
        var weekDays = testCalendar.veryShortWeekdaySymbols
        weekDays = Array(weekDays[firstDayOfWeek.rawValue-1..<weekDays.count]) + weekDays[0..<firstDayOfWeek.rawValue-1]
        
        for weekdaySimbol in weekDays {
            self.weekDaysStack.addArrangedSubview(self.makeWeekLabel(for: weekdaySimbol.description))
        }
    }
    
    private func makeWeekLabel(for symbol: String) -> UILabel {
        let label = UILabel()
        label.textAlignment = .center
        label.text = symbol
        return label
    }
}

// MARK: JTAppleCalendarDelegate
extension CalendarView: JTACMonthViewDelegate, JTACMonthViewDataSource {
    func configureCalendar(_ calendar: JTACMonthView) -> ConfigurationParameters {
        return parameters
    }
    
    func calendar(_ calendar: JTACMonthView, willDisplay cell: JTACDayCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
        let calendarDay = CalendarDay(date: date,
                                      isAvailable: true,
                                      hasBookings: true)
        (cell as? CalendarCell)?.handleCellSelection(cellState: cellState,
                                                     day: calendarDay)
    }
    
    func calendar(_ calendar: JTACMonthView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTACDayCell {
        guard let myCustomCell = calendar.dequeueReusableCell(withReuseIdentifier: CalendarCell.reuseID, for: indexPath) as? CalendarCell else {
            fatalError()
        }
    
        let calendarDay = CalendarDay(date: date,
                                      isAvailable: true,
                                      hasBookings: true)
        myCustomCell.handleCellSelection(cellState: cellState, day: calendarDay)
        return myCustomCell
    }
    
    func calendar(_ calendar: JTACMonthView, didSelectDate date: Date, cell: JTACDayCell?, cellState: CellState, indexPath: IndexPath) {
        onDateSelected?(date)
        
        if let selectedDay = self.selectedDay {
            if !date.isSameDay(to: selectedDay.date) {
                let cell = cell as? CalendarCell
                cell?.cellSelectionChanged(cellState, date: date)
                
                calendarView.deselect(dates: [selectedDay.date])
                self.layoutIfNeeded()
                
                self.selectedDay = cell?.day
            }
            return
        }
        
        let cell = cell as? CalendarCell
        cell?.cellSelectionChanged(cellState, date: date)
        self.selectedDay = cell?.day
        self.layoutIfNeeded()
    }
    
    func calendar(_ calendar: JTACMonthView, didDeselectDate date: Date, cell: JTACDayCell?, cellState: CellState, indexPath: IndexPath) {
        (cell as? CalendarCell)?.cellSelectionChanged(cellState, date: date)
    }

    func calendar(_ calendar: JTACMonthView, willResetCell cell: JTACDayCell) {
        (cell as? CalendarCell)?.selectedView.isHidden = true
    }

    func calendar(_ calendar: JTACMonthView, didScrollToDateSegmentWith visibleDates: DateSegmentInfo) {
        self.setupViewsOfCalendar(from: visibleDates)
    }
}

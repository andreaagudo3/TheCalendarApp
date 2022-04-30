import UIKit

final class CalendarVC: UIViewController {

    @IBOutlet weak var calendarView: CalendarView!
    @IBOutlet weak var bookingsTableView: UITableView!
    
    var presenter: CalendarPresentation!

    override func viewDidLoad() {
        super.viewDidLoad()
        setTable()
        configureView()
        presenter.getBookings()
    }
    
    private func configureView() {
        title = presenter.title
        calendarView.onDateSelected = { [weak self] calendarDate in
            self?.presenter.handleDateSelection(date: calendarDate)
        }
    }
    
    private func setTable() {
        bookingsTableView.delegate = self
        bookingsTableView.dataSource = self
        
        bookingsTableView.register(UINib(nibName: BookingCell.reuseID, bundle: nil),
                           forCellReuseIdentifier: BookingCell.reuseID)
    }
}

extension CalendarVC: CalendarViewInterface {
    func refreshCalendar() {
        calendarView.setViewData(presenter.calendarViewData)
    }
    
    func refreshBookingsList() {
        bookingsTableView.reloadData()
    }
}

extension CalendarVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfObjects(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viewData = presenter.cellViewDataType(indexPath.section)[indexPath.row]
        switch viewData {
        case .booking(let viewData):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: BookingCell.reuseID,
                                                           for: indexPath) as? BookingCell else {
                fatalError("Could not dequeue cell with identifier: \(BookingCell.reuseID)")
            }
            cell.setViewData(viewData)
            return cell
        }
    }
    
    
}

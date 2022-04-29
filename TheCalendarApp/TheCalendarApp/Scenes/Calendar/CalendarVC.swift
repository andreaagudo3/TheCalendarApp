import UIKit

final class CalendarVC: UIViewController {

    var presenter: CalendarPresentation!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    private func configureView() {

    }
}

extension CalendarVC: CalendarViewInterface {
    func setBookings(_ bookings: [String]) {
    }
    
    func updateBookingInfo(booking: String) {
       
    }
    
    func showBookingView(_ show: Bool) {
    }
}

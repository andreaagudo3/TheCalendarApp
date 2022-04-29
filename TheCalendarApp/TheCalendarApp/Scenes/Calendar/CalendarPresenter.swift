import Foundation

class CalendarPresenter {

    weak var delegate: CalendarSceneDelegate?
    weak var view: CalendarViewInterface!
    var title: String = ""
    
    init(view: CalendarViewInterface) {
        self.view = view
    }
}

extension CalendarPresenter: CalendarPresentation {
    func getBookings() {

    }
    
    func handleDateSelection(date: Date) {

    }
    
}

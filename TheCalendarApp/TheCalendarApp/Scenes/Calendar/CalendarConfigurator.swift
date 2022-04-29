import UIKit

class CalendarConfigurator {

    func create(delegate: CalendarSceneDelegate?) -> CalendarVC {
        let storyboard = UIStoryboard(name: "Calendar", bundle: nil)
        let controller = storyboard.instantiateViewController(ofType: CalendarVC.self)
        let presenter = CalendarPresenter(view: controller)
        presenter.delegate = delegate
        controller.presenter = presenter
        return controller
    }
}

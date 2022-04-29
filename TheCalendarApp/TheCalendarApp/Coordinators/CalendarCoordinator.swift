import UIKit

class CalendarCoordinator: Coordinator {
    weak var finishDelegate: CoordinatorFinishDelegate?
    var navigationController: UINavigationController
    var childCoordinators = [Coordinator]()
    var type: CoordinatorType { .calendar }

    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        showCalendarScene()
    }

    deinit {
        DebugPrint.info("CalendarCoordinator deinit")
    }

    func showCalendarScene() {
        DispatchQueue.main.async {
            let controller = CalendarConfigurator().create(delegate: self)
            self.navigationController.pushViewController(controller, animated: true)
        }
    }
}

extension CalendarCoordinator: CalendarSceneDelegate {
    
}

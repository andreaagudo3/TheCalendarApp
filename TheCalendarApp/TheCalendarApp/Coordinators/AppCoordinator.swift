import UIKit

// Define what type of flows can be started from this Coordinator
protocol AppCoordinatorProtocol: Coordinator {
}

class AppCoordinator: AppCoordinatorProtocol {
    weak var finishDelegate: CoordinatorFinishDelegate?
    var navigationController: UINavigationController
    var childCoordinators = [Coordinator]()
    var type: CoordinatorType { .app }

    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        showCalendarFlow()
    }

    deinit {
        DebugPrint.info("AppCoordinator deinit")
    }
    
    func showCalendarFlow() {
        let coordintator = CalendarCoordinator(self.navigationController)
        coordintator.start()
        self.childCoordinators.append(coordintator)
        
    }
}

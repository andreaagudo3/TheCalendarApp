# TheCalendarApp

### Installation

Dependencies in this project are provided via Cocoapods. Please install all dependecies with

`
pod install
`

Remember to place youself inside the TheCalendarApp folder via terminal first.

### High Level Layers

#### MVP-C Concepts

* `View` - delegates user interaction events to the `Presenter` and displays data passed by the `Presenter`
    * All `UIViewController`, `UIView`, `UITableViewCell` subclasses belong to the `View` layer
    * It shouldn't contain any complex logic.
* `Presenter` - contains the presentation logic and tells the `View` what to present
    * Usually we have one `Presenter` per scene (view controller)
    * It doesn't reference the concrete type of the `View`, but rather it references the `View` protocol that is implemented usually by a `UIViewController` subclass
    * It should be a plain `Swift` class and not reference any `iOS` framework classes - this makes it easier to reuse it maybe in a `macOS` application
    * It should be covered by Unit Tests
* `Configurator` - injects the dependency object graph into the scene (view controller)
* `Coordinator` - contains navigation / flow logic from one scene to another
    * Tt might be referred to as a `FlowCoordinator`
    * It should be referenced only by the `Presenter`.

### TheCalendarApp Details

* __Unit Tests__ are missing at the moment.
* __Code comments__ can be found in several classes highlighting different design decisions or referencing followup resources
* The project structure tries to follow clean code concept that can be found in the references section

### Useful Resources

#### MVP
* [iOS Swift : MVP Architecture] (https://saad-eloulladi.medium.com/ios-swift-mvp-architecture-pattern-a2b0c2d310a3)

#### Coordinator pattern
* [iOS : Coordinator pattern in Swift] (https://saad-eloulladi.medium.com/ios-coordinator-pattern-in-swift-39a15aa3b01b)

#### Clean code
* [What is Clean Code ?] (https://garywoodfine.com/what-is-clean-code/)

import UIKit

class AnimationClass {
    class func bounceEffect() -> (UIView, @escaping (Bool) -> Void) -> () {

        return {
            view, completion in
            view.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            UIView.animate(
                withDuration: 0.5,
                delay: 0, usingSpringWithDamping: 0.3,
                initialSpringVelocity: 0.1,
                options: UIView.AnimationOptions.beginFromCurrentState,
                animations: {
                    view.transform = CGAffineTransform(scaleX: 1, y: 1)
                },
                completion: completion
            )
        }

    }
}


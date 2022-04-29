import UIKit

class AnimationView: UIView {
    func animateWithBounceEffect(withCompletionHandler completionHandler:(() -> Void)?) {
        let viewAnimation = AnimationClass.bounceEffect()
        viewAnimation(self) { _ in
            completionHandler?()
        }
    }
}

import UIKit

extension UIViewController {
    static func create(with color: UIColor) -> UIViewController {
        let viewController = UIViewController()
        viewController.title = "Color"
        viewController.view.backgroundColor = color

        return viewController
    }
}

//  Created by Anton Popkov on 23.10.17.

extension UICollectionViewFlowLayout: AssociatedObjectStore { }

extension UICollectionViewFlowLayout {
    private enum AssociatedKeys {
        static var customDelegate = \UICollectionViewFlowLayout.customDelegate
    }

    var customDelegate: UICollectionViewDelegateFlowLayout? {
        get {
            return associatedObject(forKey: &AssociatedKeys.customDelegate)
        }

        set {
            setAssociatedObject(newValue, forKey: &AssociatedKeys.customDelegate, with: .OBJC_ASSOCIATION_ASSIGN)
        }
    }
}

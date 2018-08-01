//  Created by Anton Popkov on 04.10.17.

public protocol NibViewProtocol {
    static var nib: UINib { get }
}

public extension NibViewProtocol {
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: Bundle.main)
    }
}

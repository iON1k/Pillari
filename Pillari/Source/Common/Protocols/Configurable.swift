//  Created by Anton Popkov on 25.08.17.

public protocol Configurable {
    associatedtype Configuration

    func configure(with _: Configuration)
}

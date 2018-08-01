//  Created by Anton Popkov on 31.10.17.

import Pillari

final class CollectionColoredCell: UICollectionViewCell, Configurable {
    func configure(with configuration: UIColor) {
        backgroundColor = configuration
    }
}

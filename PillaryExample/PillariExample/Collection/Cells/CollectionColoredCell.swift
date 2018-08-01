import Pillari

final class CollectionColoredCell: UICollectionViewCell, Configurable {
    func configure(with configuration: UIColor) {
        backgroundColor = configuration
    }
}

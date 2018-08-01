public final class CollectionCellFactory: CollectionCellFactoryProtocol {
    public typealias FactoryHandler = (UICollectionView, IndexPath) -> UICollectionViewCell

    private let factoryHandler: FactoryHandler

    public init(factoryHandler: @escaping FactoryHandler) {
        self.factoryHandler = factoryHandler
    }

    public func createCell(for collectionView: UICollectionView, with indexPath: IndexPath) -> UICollectionViewCell {
        return factoryHandler(collectionView, indexPath)
    }
}

public final class CollectionSupplementaryFactory: CollectionSupplementaryFactoryProtocol {
    public typealias FactoryHandler = (UICollectionView, String, IndexPath) -> UICollectionReusableView

    private let factoryHandler: FactoryHandler

    public init(factoryHandler: @escaping FactoryHandler) {
        self.factoryHandler = factoryHandler
    }

    public func createView(for collectionView: UICollectionView, kind: String, with indexPath: IndexPath) -> UICollectionReusableView {
        return factoryHandler(collectionView, kind, indexPath)
    }
}

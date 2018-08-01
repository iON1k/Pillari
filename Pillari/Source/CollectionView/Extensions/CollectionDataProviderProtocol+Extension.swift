public extension CollectionDataProviderProtocol {
    func asCollectionPillar(collectionView: UICollectionView? = nil) -> CollectionPillar {
        return CollectionPillar(collectionView: collectionView, dataProvider: self)
    }
}

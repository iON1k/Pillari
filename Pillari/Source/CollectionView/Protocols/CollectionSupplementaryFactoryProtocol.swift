public protocol CollectionSupplementaryFactoryProtocol {
    func createView(for collectionView: UICollectionView, kind: String, with indexPath: IndexPath) -> UICollectionReusableView
}

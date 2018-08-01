//  Created by Anton Popkov on 26.10.17.

public protocol CollectionSupplementaryFactoryProtocol {
    func createView(for collectionView: UICollectionView, kind: String, with indexPath: IndexPath) -> UICollectionReusableView
}

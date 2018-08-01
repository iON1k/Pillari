//  Created by Anton Popkov on 25.10.17.

public extension CollectionDataProviderProtocol {
    func asCollectionPillar(collectionView: UICollectionView? = nil) -> CollectionPillar {
        return CollectionPillar(collectionView: collectionView, dataProvider: self)
    }
}

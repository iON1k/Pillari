//  Created by Anton Popkov on 26.10.17.

public protocol CollectionCellFactoryProtocol {
    func createCell(for collectionView: UICollectionView, with indexPath: IndexPath) -> UICollectionViewCell
}

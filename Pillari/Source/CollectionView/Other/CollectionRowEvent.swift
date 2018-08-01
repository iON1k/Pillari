//  Created by Anton Popkov on 23.10.17.

public enum CollectionRowEvent {
    case didConfigure(context: (collection: UICollectionView, cell: UICollectionViewCell, index: IndexPath))
    case willDisplay(context: (collection: UICollectionView, cell: UICollectionViewCell, index: IndexPath))
    case didEndDisplaying(context: (collection: UICollectionView, cell: UICollectionViewCell, index: IndexPath))
    case didSelect(context: (collection: UICollectionView, index: IndexPath))
    case didDeselect(context: (collection: UICollectionView, index: IndexPath))
    case didHighlight(context: (collection: UICollectionView, index: IndexPath))
    case didUnhighlight(context: (collection: UICollectionView, index: IndexPath))
    case move(context: (collection: UICollectionView, sourceIndex: IndexPath, destinationIndex: IndexPath))
    case performAction(context: (collection: UICollectionView, action: Selector, index: IndexPath, sender: Any?))
}

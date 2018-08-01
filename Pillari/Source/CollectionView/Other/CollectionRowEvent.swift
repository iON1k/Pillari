public enum CollectionRowEvent {
    public typealias Context = (collection: UICollectionView, index: IndexPath)
    public typealias CellContext = (collection: UICollectionView, cell: UICollectionViewCell, index: IndexPath)
    public typealias MoveContext = (collection: UICollectionView, sourceIndex: IndexPath, destinationIndex: IndexPath)

    case didConfigure(context: CellContext)
    case willDisplay(context: CellContext)
    case didEndDisplaying(context: CellContext)
    case didSelect(context: Context)
    case didDeselect(context: Context)
    case didHighlight(context: Context)
    case didUnhighlight(context: Context)
    case move(context: MoveContext)
    case performAction(context: (collection: UICollectionView, action: Selector, index: IndexPath, sender: Any?))
}

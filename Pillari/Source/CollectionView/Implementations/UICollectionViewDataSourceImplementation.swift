public final class UICollectionViewDataSourceImplementation: NSObject {
    public var dataSource: CollectionDataSourceProtocol

    public weak var forwardDataSource: UICollectionViewDataSource?

    init(dataSource: CollectionDataSourceProtocol) {
        self.dataSource = dataSource
    }
}

extension UICollectionViewDataSourceImplementation: UICollectionViewDataSource {
    private static let onlyForwardDataSourceSelectors = Set([
        #selector(UICollectionViewDataSource.collectionView(_:indexPathForIndexTitle:at:))
    ])

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let section = dataSource.section(for: section) else {
            return 0
        }

        return section.rows.count
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let row = dataSource.row(for: indexPath) else {
            return UICollectionViewCell()
        }

        let cell = row.cellFactory.createCell(for: collectionView, with: indexPath)
        row.eventsHandler.onEvent(event: .didConfigure(context: (collection: collectionView, cell: cell, index: indexPath)))

        return cell
    }

    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        if let numberOfSections = forwardDataSource?.numberOfSections?(in: collectionView) {
            return numberOfSections
        }

        return dataSource.sections.count
    }

    public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String,
                               at indexPath: IndexPath) -> UICollectionReusableView {
        if let viewForSupplementary = forwardDataSource?.collectionView?(collectionView,
                                                                viewForSupplementaryElementOfKind: kind, at: indexPath) {
            return viewForSupplementary
        }

        guard let supplementary = dataSource.supplementary(with: kind, at: indexPath) else {
            return UICollectionReusableView()
        }

        let view = supplementary.viewFactory.createView(for: collectionView, kind: kind, with: indexPath)
        supplementary.eventsHandler.onEvent(event: .didConfigure(context: (collection: collectionView, view: view, kind: kind, index: indexPath)))

        return view
    }

    @available(iOS 9.0, *)
    public func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        if let canMoveItem = forwardDataSource?.collectionView?(collectionView, canMoveItemAt: indexPath) {
            return canMoveItem
        }

        guard let row = dataSource.row(for: indexPath) else {
            return false
        }

        return row.configuration.canMove
    }

    @available(iOS 9.0, *)
    public func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        forwardDataSource?.collectionView?(collectionView, moveItemAt: sourceIndexPath, to: destinationIndexPath)

        guard let row = dataSource.row(for: sourceIndexPath) else {
            return
        }

        row.eventsHandler.onEvent(event: .move(context:(collection: collectionView,
                                                        sourceIndex: sourceIndexPath,
                                                        destinationIndex: destinationIndexPath)))
    }

    public func indexTitles(for collectionView: UICollectionView) -> [String]? {
        return forwardDataSource?.indexTitles?(for: collectionView)
    }

    public func collectionView(_ collectionView: UICollectionView, indexPathForIndexTitle title: String, at index: Int) -> IndexPath {
        guard let indexPath = forwardDataSource?.collectionView?(collectionView, indexPathForIndexTitle: title, at: index) else {
            assert(false, "UICollectionViewDataSourceImplementation: forward data source not responds on selector \(#function)")
            return IndexPath()
        }

        return indexPath
    }

    public override func responds(to aSelector: Selector!) -> Bool {
        guard UICollectionViewDataSourceImplementation.onlyForwardDataSourceSelectors.contains(aSelector) else {
            return super.responds(to: aSelector)
        }

        guard let forwardDataSource = forwardDataSource else {
            return false
        }

        return forwardDataSource.responds(to: aSelector)
    }
}

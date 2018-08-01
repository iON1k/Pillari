public final class CollectionFlowLayoutDataProvider: CollectionDataProviderProtocol,
    CollectionDataSourceProtocol, CollectionFlowLayoutSourceProtocol {
    public var sections: [CollectionSectionProtocol] {
        return flowSections
    }

    public var sectionsLayout: [CollectionSectionFlowLayoutProtocol] {
        return flowSections
    }

    public let flowSections: [CollectionFlowLayoutSectionProtocol]

    public let flowLayout: UICollectionViewFlowLayout

    public var dataSource: CollectionDataSourceProtocol {
        return self
    }

    public var layout: UICollectionViewLayout {
        return collectionViewFlowLayout.layout
    }

    public func supplementary(with kind: String, at index: IndexPath) -> CollectionSupplementaryProtocol? {
        guard let section = flowSections[try: index.section],
            index.row == 0
        else {
            return nil
        }

        switch kind {
        case UICollectionElementKindSectionHeader:
            return section.header
        case UICollectionElementKindSectionFooter:
            return section.footer
        default:
            return nil
        }
    }

    public var layoutForwardDelegate: UICollectionViewDelegateFlowLayout? {
        get {
            return collectionViewFlowLayout.forwardDelegate
        }

        set {
            collectionViewFlowLayout.forwardDelegate = newValue
        }
    }

    lazy var collectionViewFlowLayout =  CollectionViewFlowLayout(layout: flowLayout, dataSource: self)

    public init(layout: UICollectionViewFlowLayout,
                flowSections: [CollectionFlowLayoutSectionProtocol] = []) {
        self.flowSections = flowSections
        flowLayout = layout
    }
}

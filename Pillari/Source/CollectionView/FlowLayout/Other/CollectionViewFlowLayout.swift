//  Created by Anton Popkov on 23.10.17.

public final class CollectionViewFlowLayout: NSObject {
    public let layout: UICollectionViewFlowLayout
    public var dataSource: CollectionFlowLayoutSourceProtocol

    public weak var forwardDelegate: UICollectionViewDelegateFlowLayout?

    public init(layout: UICollectionViewFlowLayout, dataSource: CollectionFlowLayoutSourceProtocol) {
        self.dataSource = dataSource
        self.layout = layout
        super.init()

        layout.customDelegate = self
    }

    deinit {
        if layout.customDelegate === self {
            layout.customDelegate = nil
        }
    }
}

extension CollectionViewFlowLayout: UICollectionViewDelegateFlowLayout {

    public func collectionView(_ collectionView: UICollectionView, layout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if let itemSize = forwardDelegate?.collectionView?(collectionView, layout: layout, sizeForItemAt: indexPath) {
            return itemSize
        }

        guard let rowLayout = dataSource.rowLayout(for: indexPath) else {
            return .zero
        }

        return rowLayout.sizeCalculator.calculateSize(with: collectionView)
    }

    public func collectionView(_ collectionView: UICollectionView,
                               layout: UICollectionViewLayout, insetForSectionAt sectionIndex: Int) -> UIEdgeInsets {
        if let inset = forwardDelegate?.collectionView?(collectionView, layout: layout, insetForSectionAt: sectionIndex) {
            return inset
        }

        return sectionLayoutConfiguration(for: sectionIndex).inset
    }

    public func collectionView(_ collectionView: UICollectionView,
                               layout: UICollectionViewLayout,
                               minimumLineSpacingForSectionAt sectionIndex: Int) -> CGFloat {
        if let minimumLineSpacing = forwardDelegate?.collectionView?(collectionView, layout: layout, minimumLineSpacingForSectionAt: sectionIndex) {
            return minimumLineSpacing
        }

        return sectionLayoutConfiguration(for: sectionIndex).minimumLineSpacing
    }

    public func collectionView(_ collectionView: UICollectionView,
                               layout: UICollectionViewLayout,
                               minimumInteritemSpacingForSectionAt sectionIndex: Int) -> CGFloat {
        if let minimumInteritemSpacing = forwardDelegate?.collectionView?(collectionView,
                                                                          layout: layout,
                                                                          minimumInteritemSpacingForSectionAt: sectionIndex) {
            return minimumInteritemSpacing
        }

        return sectionLayoutConfiguration(for: sectionIndex).minimumInteritemSpacing
    }

    public func collectionView(_ collectionView: UICollectionView,
                               layout: UICollectionViewLayout,
                               referenceSizeForHeaderInSection sectionIndex: Int) -> CGSize {
        if let headerSize = forwardDelegate?.collectionView?(collectionView, layout: layout, referenceSizeForHeaderInSection: sectionIndex) {
            return headerSize
        }

        guard let headerLayout = dataSource.sectionLayout(for: sectionIndex)?.headerLayout else {
            return .zero
        }

        return headerLayout.sizeCalculator.calculateSize(with: collectionView)
    }

    public func collectionView(_ collectionView: UICollectionView,
                               layout: UICollectionViewLayout,
                               referenceSizeForFooterInSection sectionIndex: Int) -> CGSize {
        if let footerSize = forwardDelegate?.collectionView?(collectionView, layout: layout, referenceSizeForFooterInSection: sectionIndex) {
            return footerSize
        }

        guard let footerLayout = dataSource.sectionLayout(for: sectionIndex)?.footerLayout else {
            return .zero
        }

        return footerLayout.sizeCalculator.calculateSize(with: collectionView)
    }

    private func sectionLayoutConfiguration(for sectionIndex: Int) -> CollectionFlowLayoutSectionConfiguration {
        return dataSource.sectionLayout(for: sectionIndex)?.layoutConfiguration ?? .default
    }
}

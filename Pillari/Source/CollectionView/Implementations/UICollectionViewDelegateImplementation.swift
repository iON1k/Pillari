public final class UICollectionViewDelegateImplementation: UIScrollViewDelegateImplementation {
    public var dataSource: CollectionDataSourceProtocol

    public weak var forwardDelegate: UICollectionViewDelegate?

    internal override var forwardScrollDelegate: UIScrollViewDelegate? {
        return forwardDelegate
    }

    init(dataSource: CollectionDataSourceProtocol) {
        self.dataSource = dataSource
    }
}

extension UICollectionViewDelegateImplementation: UICollectionViewDelegate {

    public func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        if let shouldHighlight = forwardDelegate?.collectionView?(collectionView, shouldHighlightItemAt: indexPath) {
            return shouldHighlight
        }

        guard let row = dataSource.row(for: indexPath) else {
            return true
        }

        return row.configuration.should.highlight
    }

    public func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        forwardDelegate?.collectionView?(collectionView, didHighlightItemAt: indexPath)

        sendRowEvent(event: .didHighlight(context: (collection: collectionView, index: indexPath)), index: indexPath)
    }

    public func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        forwardDelegate?.collectionView?(collectionView, didUnhighlightItemAt: indexPath)

        sendRowEvent(event: .didUnhighlight(context: (collection: collectionView, index: indexPath)), index: indexPath)
    }

    public func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        if let shouldSelect = forwardDelegate?.collectionView?(collectionView, shouldSelectItemAt: indexPath) {
            return shouldSelect
        }

        guard let row = dataSource.row(for: indexPath) else {
            return true
        }

        return row.configuration.should.select
    }

    public func collectionView(_ collectionView: UICollectionView, shouldDeselectItemAt indexPath: IndexPath) -> Bool {
        if let shouldDeselect = forwardDelegate?.collectionView?(collectionView, shouldDeselectItemAt: indexPath) {
            return shouldDeselect
        }

        guard let row = dataSource.row(for: indexPath) else {
            return true
        }

        return row.configuration.should.deselect
    }

    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        forwardDelegate?.collectionView?(collectionView, didSelectItemAt: indexPath)

        sendRowEvent(event: .didSelect(context: (collection: collectionView, index: indexPath)), index: indexPath)
    }

    public func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        forwardDelegate?.collectionView?(collectionView, didDeselectItemAt: indexPath)

        sendRowEvent(event: .didDeselect(context: (collection: collectionView, index: indexPath)), index: indexPath)
    }

    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        forwardDelegate?.collectionView?(collectionView, willDisplay: cell, forItemAt: indexPath)

        sendRowEvent(event: .willDisplay(context: (collection: collectionView, cell: cell, index: indexPath)), index: indexPath)
    }

    public func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView,
                               forElementKind elementKind: String, at indexPath: IndexPath) {
        forwardDelegate?.collectionView?(collectionView, willDisplaySupplementaryView: view, forElementKind: elementKind, at: indexPath)

        sendSupplementaryEvent(event: .willDisplay(context: (collection: collectionView, view: view, kind: elementKind, index: indexPath)))
    }

    public func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        forwardDelegate?.collectionView?(collectionView, didEndDisplaying: cell, forItemAt: indexPath)

        sendRowEvent(event: .didEndDisplaying(context: (collection: collectionView, cell: cell, index: indexPath)), index: indexPath)
    }

    public func collectionView(_ collectionView: UICollectionView, didEndDisplayingSupplementaryView view: UICollectionReusableView,
                               forElementOfKind elementKind: String, at indexPath: IndexPath) {
        forwardDelegate?.collectionView?(collectionView, didEndDisplayingSupplementaryView: view, forElementOfKind: elementKind, at: indexPath)

        sendSupplementaryEvent(event: .didEndDisplaying(context: (collection: collectionView, view: view, kind: elementKind, index: indexPath)))
    }

    public func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        if let shouldShowMenu = forwardDelegate?.collectionView?(collectionView, shouldShowMenuForItemAt: indexPath) {
            return shouldShowMenu
        }

        guard let row = dataSource.row(for: indexPath) else {
            return false
        }

        return row.configuration.should.showMenu
    }

    public func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector,
                               forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return forwardDelegate?.collectionView?(collectionView, canPerformAction: action, forItemAt: indexPath, withSender: sender) ?? true
    }

    public func collectionView(_ collectionView: UICollectionView,
                               performAction action: Selector,
                               forItemAt indexPath: IndexPath, withSender sender: Any?) {
        forwardDelegate?.collectionView?(collectionView, performAction: action, forItemAt: indexPath, withSender: sender)

        sendRowEvent(event: .performAction(context: (collection: collectionView, action: action, index: indexPath, sender: sender)), index: indexPath)
    }

    public func collectionView(_ collectionView: UICollectionView,
                               transitionLayoutForOldLayout fromLayout: UICollectionViewLayout,
                               newLayout toLayout: UICollectionViewLayout) -> UICollectionViewTransitionLayout {
        if let transitionLayout = forwardDelegate?.collectionView?(collectionView, transitionLayoutForOldLayout: fromLayout, newLayout: toLayout) {
            return transitionLayout
        }

        return UICollectionViewTransitionLayout(currentLayout: fromLayout, nextLayout: toLayout)
    }

    @available(iOS 9.0, *)
    public func collectionView(_ collectionView: UICollectionView, canFocusItemAt indexPath: IndexPath) -> Bool {
        if let canFocus = forwardDelegate?.collectionView?(collectionView, canFocusItemAt: indexPath) {
            return canFocus
        }

        guard let row = dataSource.row(for: indexPath) else {
            return true
        }

        return row.configuration.canFocus
    }

    @available(iOS 9.0, *)
    public func collectionView(_ collectionView: UICollectionView, shouldUpdateFocusIn context: UICollectionViewFocusUpdateContext) -> Bool {
        return forwardDelegate?.collectionView?(collectionView, shouldUpdateFocusIn: context) ?? true
    }

    @available(iOS 9.0, *)
    public func collectionView(_ collectionView: UICollectionView, didUpdateFocusIn context: UICollectionViewFocusUpdateContext,
                               with coordinator: UIFocusAnimationCoordinator) {
        forwardDelegate?.collectionView?(collectionView, didUpdateFocusIn: context, with: coordinator)
    }

    @available(iOS 9.0, *)
    public func indexPathForPreferredFocusedView(in collectionView: UICollectionView) -> IndexPath? {
        return forwardDelegate?.indexPathForPreferredFocusedView?(in: collectionView)
    }

    @available(iOS 9.0, *)
    public func collectionView(_ collectionView: UICollectionView,
                               targetIndexPathForMoveFromItemAt originalIndexPath: IndexPath,
                               toProposedIndexPath proposedIndexPath: IndexPath) -> IndexPath {
        if let targetIndexPath = forwardDelegate?.collectionView?(collectionView, targetIndexPathForMoveFromItemAt: originalIndexPath,
                                                    toProposedIndexPath: proposedIndexPath) {
            return targetIndexPath
        }

        return proposedIndexPath
    }

    @available(iOS 9.0, *)
    public func collectionView(_ collectionView: UICollectionView,
                               targetContentOffsetForProposedContentOffset proposedContentOffset: CGPoint) -> CGPoint {
        if let targetContentOffset = forwardDelegate?.collectionView?(collectionView,
                                                                      targetContentOffsetForProposedContentOffset: proposedContentOffset) {
            return targetContentOffset
        }

        return proposedContentOffset
    }

    @available(iOS 11.0, *)
    public func collectionView(_ collectionView: UICollectionView, shouldSpringLoadItemAt indexPath: IndexPath,
                               with context: UISpringLoadedInteractionContext) -> Bool {
        if let shouldSpringLoad = forwardDelegate?.collectionView?(collectionView, shouldSpringLoadItemAt: indexPath, with: context) {
            return shouldSpringLoad
        }

        guard let row = dataSource.row(for: indexPath) else {
            return true
        }

        return row.configuration.should.springLoad
    }

    private func sendRowEvent(event: CollectionRowEvent, index indexPath: IndexPath) {
        guard let row = dataSource.row(for: indexPath) else {
            return
        }

        row.eventsHandler.onEvent(event: event)
    }

    private func sendSupplementaryEvent(event: CollectionSupplementaryEvent) {
        guard let supplementary = dataSource.supplementary(with: event.supplementaryKind, at: event.supplementaryIndex) else {
            return
        }

        supplementary.eventsHandler.onEvent(event: event)
    }
}

extension UICollectionViewDelegateImplementation: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return flowLayoutCustomDelegate(layout)?.collectionView?(collectionView, layout: layout, sizeForItemAt: indexPath) ?? .zero
    }

    public func collectionView(_ collectionView: UICollectionView,
                               layout: UICollectionViewLayout, insetForSectionAt sectionIndex: Int) -> UIEdgeInsets {
        return flowLayoutCustomDelegate(layout)?.collectionView?(collectionView, layout: layout, insetForSectionAt: sectionIndex) ?? .zero
    }

    public func collectionView(_ collectionView: UICollectionView,
                               layout: UICollectionViewLayout, minimumLineSpacingForSectionAt sectionIndex: Int) -> CGFloat {
        return flowLayoutCustomDelegate(layout)?.collectionView?(collectionView, layout: layout, minimumLineSpacingForSectionAt: sectionIndex) ?? 0
    }

    public func collectionView(_ collectionView: UICollectionView,
                               layout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt sectionIndex: Int) -> CGFloat {
        return flowLayoutCustomDelegate(layout)?.collectionView?(collectionView,
                                                                 layout: layout, minimumInteritemSpacingForSectionAt: sectionIndex) ?? 0
    }

    public func collectionView(_ collectionView: UICollectionView,
                               layout: UICollectionViewLayout, referenceSizeForHeaderInSection sectionIndex: Int) -> CGSize {
        return flowLayoutCustomDelegate(layout)?.collectionView?(collectionView,
                                                                 layout: layout, referenceSizeForHeaderInSection: sectionIndex) ?? .zero
    }

    public func collectionView(_ collectionView: UICollectionView,
                               layout: UICollectionViewLayout, referenceSizeForFooterInSection sectionIndex: Int) -> CGSize {
        return flowLayoutCustomDelegate(layout)?.collectionView?(collectionView,
                                                                 layout: layout, referenceSizeForFooterInSection: sectionIndex) ?? .zero
    }

    private func flowLayoutCustomDelegate(_ layout: UICollectionViewLayout) -> UICollectionViewDelegateFlowLayout? {
        return (layout as? UICollectionViewFlowLayout)?.customDelegate
    }
}

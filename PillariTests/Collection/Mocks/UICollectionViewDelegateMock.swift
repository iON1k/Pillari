import UIKit

// swiftlint:disable identifier_name

class UICollectionViewDelegateMock: NSObject {
    enum Event {
        case shouldHighlightItem(UICollectionView, IndexPath)
        case didHighlightItem(UICollectionView, IndexPath)
        case didUnhighlightItem(UICollectionView, IndexPath)
        case shouldSelectItem(UICollectionView, IndexPath)
        case shouldDeselectItem(UICollectionView, IndexPath)
        case didSelectItem(UICollectionView, IndexPath)
        case didDeselectItem(UICollectionView, IndexPath)
        case willDisplayCell(UICollectionView, UICollectionViewCell, IndexPath)
        case didEndDisplayingCell(UICollectionView, UICollectionViewCell, IndexPath)
        case willDisplaySupplementaryView(UICollectionView, UICollectionReusableView, String, IndexPath)
        case didEndDisplayingSupplementaryView(UICollectionView, UICollectionReusableView, String, IndexPath)
        case shouldShowMenuForItem(UICollectionView, IndexPath)
        case canPerformAction(UICollectionView, Selector, IndexPath, Any?)
        case performAction(UICollectionView, Selector, IndexPath, Any?)
        case transitionLayout(UICollectionView, UICollectionViewLayout, UICollectionViewLayout)
        case canFocusItem(UICollectionView, IndexPath)
        case shouldUpdateFocus(UICollectionView, UICollectionViewFocusUpdateContext)
        case didUpdateFocus(UICollectionView, UICollectionViewFocusUpdateContext, UIFocusAnimationCoordinator)
        case indexPathForPreferredFocusedView(UICollectionView)
        case targetIndexPathForMoveFromItem(UICollectionView, IndexPath, IndexPath)
        case targetContentOffsetForProposedContentOffset(UICollectionView, CGPoint)
        case shouldSpringLoadItem(UICollectionView, IndexPath, UISpringLoadedInteractionContext)
    }

    var events: [Event] {
        return eventsHandler.events
    }

    private let eventsHandler = EventsHandlerMock<Event>()

    let shouldHighlightItem = false
    let shouldSelectItem = false
    let shouldDeselectItem = false
    let shouldShowMenuForItem = true
    let canPerformAction = false
    let transitionLayout = UICollectionViewTransitionLayout(currentLayout: UICollectionViewLayout(), nextLayout: UICollectionViewLayout())
    let canFocusItem = false
    let shouldUpdateFocus = false
    let indexPathForPreferredFocusedView = IndexPath(row: 5, section: 11)
    let targetIndexPathForMoveFromItem = IndexPath(row: 2, section: 4)
    let targetContentOffsetForProposedContentOffset = CGPoint(x: 102, y: 432)
    let shouldSpringLoadItem = false
}

extension UICollectionViewDelegateMock: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        eventsHandler.onEvent(event: .shouldHighlightItem(collectionView, indexPath))
        return shouldHighlightItem
    }

    public func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        eventsHandler.onEvent(event: .didHighlightItem(collectionView, indexPath))
    }

    public func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        eventsHandler.onEvent(event: .didUnhighlightItem(collectionView, indexPath))
    }

    public func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        eventsHandler.onEvent(event: .shouldSelectItem(collectionView, indexPath))
        return shouldSelectItem
    }

    public func collectionView(_ collectionView: UICollectionView, shouldDeselectItemAt indexPath: IndexPath) -> Bool {
        eventsHandler.onEvent(event: .shouldDeselectItem(collectionView, indexPath))
        return shouldDeselectItem
    }

    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        eventsHandler.onEvent(event: .didSelectItem(collectionView, indexPath))
    }

    public func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        eventsHandler.onEvent(event: .didDeselectItem(collectionView, indexPath))
    }

    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        eventsHandler.onEvent(event: .willDisplayCell(collectionView, cell, indexPath))
    }

    public func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView,
                               forElementKind elementKind: String, at indexPath: IndexPath) {
        eventsHandler.onEvent(event: .willDisplaySupplementaryView(collectionView, view, elementKind, indexPath))
    }

    public func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        eventsHandler.onEvent(event: .didEndDisplayingCell(collectionView, cell, indexPath))
    }

    public func collectionView(_ collectionView: UICollectionView, didEndDisplayingSupplementaryView view: UICollectionReusableView,
                               forElementOfKind elementKind: String, at indexPath: IndexPath) {
        eventsHandler.onEvent(event: .didEndDisplayingSupplementaryView(collectionView, view, elementKind, indexPath))
    }

    public func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        eventsHandler.onEvent(event: .shouldShowMenuForItem(collectionView, indexPath))
        return shouldShowMenuForItem
    }

    public func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector,
                               forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        eventsHandler.onEvent(event: .canPerformAction(collectionView, action, indexPath, sender))
        return canPerformAction
    }

    public func collectionView(_ collectionView: UICollectionView, performAction action: Selector,
                               forItemAt indexPath: IndexPath, withSender sender: Any?) {
        eventsHandler.onEvent(event: .performAction(collectionView, action, indexPath, sender))
    }

    public func collectionView(_ collectionView: UICollectionView, transitionLayoutForOldLayout fromLayout: UICollectionViewLayout,
                               newLayout toLayout: UICollectionViewLayout) -> UICollectionViewTransitionLayout {
        eventsHandler.onEvent(event: .transitionLayout(collectionView, fromLayout, toLayout))
        return transitionLayout
    }

    @available(iOS 9.0, *)
    public func collectionView(_ collectionView: UICollectionView, canFocusItemAt indexPath: IndexPath) -> Bool {
        eventsHandler.onEvent(event: .canFocusItem(collectionView, indexPath))
        return canFocusItem
    }

    @available(iOS 9.0, *)
    public func collectionView(_ collectionView: UICollectionView, shouldUpdateFocusIn context: UICollectionViewFocusUpdateContext) -> Bool {
        eventsHandler.onEvent(event: .shouldUpdateFocus(collectionView, context))
        return shouldUpdateFocus
    }

    @available(iOS 9.0, *)
    public func collectionView(_ collectionView: UICollectionView, didUpdateFocusIn context: UICollectionViewFocusUpdateContext,
                               with coordinator: UIFocusAnimationCoordinator) {
        eventsHandler.onEvent(event: .didUpdateFocus(collectionView, context, coordinator))
    }

    @available(iOS 9.0, *)
    public func indexPathForPreferredFocusedView(in collectionView: UICollectionView) -> IndexPath? {
        eventsHandler.onEvent(event: .indexPathForPreferredFocusedView(collectionView))
        return indexPathForPreferredFocusedView
    }

    @available(iOS 9.0, *)
    public func collectionView(_ collectionView: UICollectionView, targetIndexPathForMoveFromItemAt originalIndexPath: IndexPath,
                               toProposedIndexPath proposedIndexPath: IndexPath) -> IndexPath {
        eventsHandler.onEvent(event: .targetIndexPathForMoveFromItem(collectionView, originalIndexPath, proposedIndexPath))
        return targetIndexPathForMoveFromItem
    }

    @available(iOS 9.0, *)
    public func collectionView(_ collectionView: UICollectionView,
                               targetContentOffsetForProposedContentOffset proposedContentOffset: CGPoint) -> CGPoint {
        eventsHandler.onEvent(event: .targetContentOffsetForProposedContentOffset(collectionView, proposedContentOffset))
        return targetContentOffsetForProposedContentOffset
    }

    @available(iOS 11.0, *)
    public func collectionView(_ collectionView: UICollectionView, shouldSpringLoadItemAt indexPath: IndexPath,
                               with context: UISpringLoadedInteractionContext) -> Bool {
        eventsHandler.onEvent(event: .shouldSpringLoadItem(collectionView, indexPath, context))
        return shouldSpringLoadItem
    }
}

// swiftlint:enable identifier_name

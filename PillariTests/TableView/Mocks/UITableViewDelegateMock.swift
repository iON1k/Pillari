//  Created by Anton Popkov on 09.11.17.

import UIKit

class UITableViewDelegateMock: NSObject {
    enum Event {
        case willDisplayCell(UITableView, UITableViewCell, IndexPath)
        case willDisplayHeaderView(UITableView, UIView, Int)
        case willDisplayFooterView(UITableView, UIView, Int)
        case didEndDisplayingCell(UITableView, UITableViewCell, IndexPath)
        case didEndDisplayingHeaderView(UITableView, UIView, Int)
        case didEndDisplayingFooterView(UITableView, UIView, Int)
        case heightForRow(UITableView, IndexPath)
        case heightForHeader(UITableView, Int)
        case heightForFooter(UITableView, Int)
        case estimatedHeightForRow(UITableView, IndexPath)
        case estimatedHeightForHeader(UITableView, Int)
        case estimatedHeightForFooter(UITableView, Int)
        case viewForHeader(UITableView, Int)
        case viewForFooter(UITableView, Int)
        case accessoryButtonTappedForRow(UITableView, IndexPath)
        case shouldHighlightRow(UITableView, IndexPath)
        case didHighlightRow(UITableView, IndexPath)
        case didUnhighlightRow(UITableView, IndexPath)
        case willSelectRow(UITableView, IndexPath)
        case willDeselectRow(UITableView, IndexPath)
        case didSelectRow(UITableView, IndexPath)
        case didDeselectRow(UITableView, IndexPath)
        case editingStyleForRow(UITableView, IndexPath)
        case titleForDeleteConfirmationButtonForRow(UITableView, IndexPath)
        case editActionsForRow(UITableView, IndexPath)
        case shouldIndentWhileEditingRow(UITableView, IndexPath)
        case willBeginEditingRow(UITableView, IndexPath)
        case didEndEditingRow(UITableView, IndexPath?)
        case targetIndexPathForMoveFromRow(UITableView, IndexPath, IndexPath)
        case indentationLevelForRow(UITableView, IndexPath)
        case shouldShowMenuForRow(UITableView, IndexPath)
        case canPerformAction(UITableView, Selector, IndexPath, Any?)
        case performAction(UITableView, Selector, IndexPath, Any?)
        case canFocusRow(UITableView, IndexPath)
        case shouldUpdateFocus(UITableView, UITableViewFocusUpdateContext)
        case didUpdateFocus(UITableView, UITableViewFocusUpdateContext, UIFocusAnimationCoordinator)
        case indexPathForPreferredFocusedView(UITableView)
    }

    var events: [Event] {
        return eventsHandler.events
    }

    private let eventsHandler = EventsHandlerMock<Event>()

    let heightForRow = CGFloat(30)
    let heightForHeader = CGFloat(40)
    let heightForFooter = CGFloat(50)
    let estimatedHeightForRow = CGFloat(60)
    let estimatedHeightForHeader = CGFloat(70)
    let estimatedHeightForFooter = CGFloat(80)
    let viewForHeader = UIView()
    let viewForFooter = UIView()
    let shouldHighlightRow = false
    let willSelectRowIndexPath = IndexPath(row: 10, section: 15)
    let willDeselectRowIndexPath = IndexPath(row: 20, section: 25)
    let editingStyleForRow = UITableViewCellEditingStyle.delete
    let titleForDeleteConfirmationButtonForRow = "TestDeleteTitle"
    let editActionsForRow = [UITableViewRowAction(), UITableViewRowAction(), UITableViewRowAction()]
    let shouldIndentWhileEditingRow = false
    let targetIndexPathForMoveFromRow = IndexPath(row: 5, section: 13)
    let indentationLevelForRow = 3
    let shouldShowMenuForRow = true
    let canPerformAction = true
    let canFocusRow = false
    let shouldUpdateFocus = false
    let indexPathForPreferredFocusedView = IndexPath(row: 3, section: 7)
}

extension UITableViewDelegateMock: UITableViewDelegate {

    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        eventsHandler.onEvent(event: .willDisplayCell(tableView, cell, indexPath))
    }

    public func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        eventsHandler.onEvent(event: .willDisplayHeaderView(tableView, view, section))
    }

    public func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        eventsHandler.onEvent(event: .willDisplayFooterView(tableView, view, section))
    }

    public func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        eventsHandler.onEvent(event: .didEndDisplayingCell(tableView, cell, indexPath))
    }

    public func tableView(_ tableView: UITableView, didEndDisplayingHeaderView view: UIView, forSection section: Int) {
        eventsHandler.onEvent(event: .didEndDisplayingHeaderView(tableView, view, section))
    }

    public func tableView(_ tableView: UITableView, didEndDisplayingFooterView view: UIView, forSection section: Int) {
        eventsHandler.onEvent(event: .didEndDisplayingFooterView(tableView, view, section))
    }

    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        eventsHandler.onEvent(event: .heightForRow(tableView, indexPath))
        return heightForRow
    }

    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        eventsHandler.onEvent(event: .heightForHeader(tableView, section))
        return heightForHeader
    }

    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        eventsHandler.onEvent(event: .heightForFooter(tableView, section))
        return heightForFooter
    }

    public func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        eventsHandler.onEvent(event: .estimatedHeightForRow(tableView, indexPath))
        return estimatedHeightForRow
    }

    public func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        eventsHandler.onEvent(event: .estimatedHeightForHeader(tableView, section))
        return estimatedHeightForHeader
    }

    public func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
        eventsHandler.onEvent(event: .estimatedHeightForFooter(tableView, section))
        return estimatedHeightForFooter
    }

    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        eventsHandler.onEvent(event: .viewForHeader(tableView, section))
        return viewForHeader
    }

    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        eventsHandler.onEvent(event: .viewForFooter(tableView, section))
        return viewForFooter
    }

    public func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        eventsHandler.onEvent(event: .accessoryButtonTappedForRow(tableView, indexPath))
    }

    public func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        eventsHandler.onEvent(event: .shouldHighlightRow(tableView, indexPath))
        return shouldHighlightRow
    }

    public func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        eventsHandler.onEvent(event: .didHighlightRow(tableView, indexPath))
    }

    public func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        eventsHandler.onEvent(event: .didUnhighlightRow(tableView, indexPath))
    }

    public func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        eventsHandler.onEvent(event: .willSelectRow(tableView, indexPath))
        return willSelectRowIndexPath
    }

    public func tableView(_ tableView: UITableView, willDeselectRowAt indexPath: IndexPath) -> IndexPath? {
        eventsHandler.onEvent(event: .willDeselectRow(tableView, indexPath))
        return willDeselectRowIndexPath
    }

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        eventsHandler.onEvent(event: .didSelectRow(tableView, indexPath))
    }

    public func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        eventsHandler.onEvent(event: .didDeselectRow(tableView, indexPath))
    }

    public func tableView(_ tableView: UITableView,
                          editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        eventsHandler.onEvent(event: .editingStyleForRow(tableView, indexPath))
        return editingStyleForRow
    }

    public func tableView(_ tableView: UITableView,
                          titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        eventsHandler.onEvent(event: .titleForDeleteConfirmationButtonForRow(tableView, indexPath))
        return titleForDeleteConfirmationButtonForRow
    }

    public func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        eventsHandler.onEvent(event: .editActionsForRow(tableView, indexPath))
        return editActionsForRow
    }

    public func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        eventsHandler.onEvent(event: .shouldIndentWhileEditingRow(tableView, indexPath))
        return shouldIndentWhileEditingRow
    }

    public func tableView(_ tableView: UITableView, willBeginEditingRowAt indexPath: IndexPath) {
        eventsHandler.onEvent(event: .willBeginEditingRow(tableView, indexPath))
    }

    public func tableView(_ tableView: UITableView, didEndEditingRowAt indexPath: IndexPath?) {
        eventsHandler.onEvent(event: .didEndEditingRow(tableView, indexPath))
    }

    public func tableView(_ tableView: UITableView, targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath,
                          toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath {
        eventsHandler.onEvent(event: .targetIndexPathForMoveFromRow(tableView, sourceIndexPath,
                                                                    proposedDestinationIndexPath))
        return targetIndexPathForMoveFromRow
    }

    public func tableView(_ tableView: UITableView, indentationLevelForRowAt indexPath: IndexPath) -> Int {
        eventsHandler.onEvent(event: .indentationLevelForRow(tableView, indexPath))
        return indentationLevelForRow
    }

    public func tableView(_ tableView: UITableView, shouldShowMenuForRowAt indexPath: IndexPath) -> Bool {
        eventsHandler.onEvent(event: .shouldShowMenuForRow(tableView, indexPath))
        return shouldShowMenuForRow
    }

    public func tableView(_ tableView: UITableView, canPerformAction action: Selector,
                          forRowAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        eventsHandler.onEvent(event: .canPerformAction(tableView, action, indexPath, sender))
        return canPerformAction
    }

    public func tableView(_ tableView: UITableView, performAction action: Selector,
                          forRowAt indexPath: IndexPath, withSender sender: Any?) {
        eventsHandler.onEvent(event: .performAction(tableView, action, indexPath, sender))
    }

    @available(iOS 9.0, *)
    public func tableView(_ tableView: UITableView, canFocusRowAt indexPath: IndexPath) -> Bool {
        eventsHandler.onEvent(event: .canFocusRow(tableView, indexPath))
        return canFocusRow
    }

    @available(iOS 9.0, *)
    public func tableView(_ tableView: UITableView, shouldUpdateFocusIn context: UITableViewFocusUpdateContext) -> Bool {
        eventsHandler.onEvent(event: .shouldUpdateFocus(tableView, context))
        return shouldUpdateFocus
    }

    @available(iOS 9.0, *)
    public func tableView(_ tableView: UITableView, didUpdateFocusIn context: UITableViewFocusUpdateContext,
                          with coordinator: UIFocusAnimationCoordinator) {
        eventsHandler.onEvent(event: .didUpdateFocus(tableView, context, coordinator))
    }

    @available(iOS 9.0, *)
    public func indexPathForPreferredFocusedView(in tableView: UITableView) -> IndexPath? {
        eventsHandler.onEvent(event: .indexPathForPreferredFocusedView(tableView))
        return indexPathForPreferredFocusedView
    }
}

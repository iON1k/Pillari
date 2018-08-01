//  Created by Anton Popkov on 25.08.17.

public final class UITableViewDelegateImplementation: UIScrollViewDelegateImplementation {
    public var dataSource: TableDataSourceProtocol

    public weak var forwardDelegate: UITableViewDelegate?

    internal override var forwardScrollDelegate: UIScrollViewDelegate? {
        return forwardDelegate
    }

    public init(dataSource: TableDataSourceProtocol = TableDataSource()) {
        self.dataSource = dataSource
    }
}

extension UITableViewDelegateImplementation: UITableViewDelegate {

    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        forwardDelegate?.tableView?(tableView, willDisplay: cell, forRowAt: indexPath)

        sendRowEvent(event:
            .willDisplay(context: (table: tableView, cell: cell, index: indexPath)), index: indexPath)
    }

    public func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        forwardDelegate?.tableView?(tableView, willDisplayHeaderView: view, forSection: section)

        guard let header = dataSource.header(for: section) else {
            return
        }

        header.eventsHandler.onEvent(event: .willDisplay(context: (table: tableView, view: view, section: section)))
    }

    public func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        forwardDelegate?.tableView?(tableView, willDisplayFooterView: view, forSection: section)

        guard let footer = dataSource.footer(for: section) else {
            return
        }

        footer.eventsHandler.onEvent(event: .willDisplay(context: (table: tableView, view: view, section: section)))
    }

    public func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        forwardDelegate?.tableView?(tableView, didEndDisplaying: cell, forRowAt: indexPath)

        sendRowEvent(event:
            .didEndDisplaying(context: (table: tableView, cell: cell, index: indexPath)), index: indexPath)
    }

    public func tableView(_ tableView: UITableView, didEndDisplayingHeaderView view: UIView, forSection section: Int) {
        forwardDelegate?.tableView?(tableView, didEndDisplayingHeaderView: view, forSection: section)

        guard let header = dataSource.header(for: section) else {
            return
        }

        header.eventsHandler.onEvent(event: .didEndDisplaying(context: (table: tableView, view: view, section: section)))
    }

    public func tableView(_ tableView: UITableView, didEndDisplayingFooterView view: UIView, forSection section: Int) {
        forwardDelegate?.tableView?(tableView, didEndDisplayingFooterView: view, forSection: section)

        guard let footer = dataSource.footer(for: section) else {
            return
        }

        footer.eventsHandler.onEvent(event: .didEndDisplaying(context: (table: tableView, view: view, section: section)))
    }

    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let rowHeight = forwardDelegate?.tableView?(tableView, heightForRowAt: indexPath) {
            return rowHeight
        }

        guard let row = dataSource.row(for: indexPath) else {
            return 0
        }

        return row.heightCalculator.calculateHeight(with: tableView)
    }

    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if let headerHeight = forwardDelegate?.tableView?(tableView, heightForHeaderInSection: section) {
            return headerHeight
        }

        guard let header = dataSource.header(for: section) else {
            return 0
        }

        return header.heightCalculator.calculateHeight(with: tableView)
    }

    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if let footerHeight = forwardDelegate?.tableView?(tableView, heightForFooterInSection: section) {
            return footerHeight
        }

        guard let footer = dataSource.footer(for: section) else {
            return 0
        }

        return footer.heightCalculator.calculateHeight(with: tableView)
    }

    public func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        if let rowHeight = forwardDelegate?.tableView?(tableView, estimatedHeightForRowAt: indexPath) {
            return rowHeight
        }

        guard let row = dataSource.row(for: indexPath) else {
            return 0
        }

        return row.heightCalculator.calculateEstimatedHeight(with: tableView)
    }

    public func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        if let headerHeight = forwardDelegate?.tableView?(tableView, estimatedHeightForHeaderInSection: section) {
            return headerHeight
        }

        guard let header = dataSource.header(for: section) else {
            return 0
        }

        return header.heightCalculator.calculateEstimatedHeight(with: tableView)
    }

    public func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
        if let footerHeight = forwardDelegate?.tableView?(tableView, estimatedHeightForFooterInSection: section) {
            return footerHeight
        }

        guard let footer = dataSource.footer(for: section) else {
            return 0
        }

        return footer.heightCalculator.calculateEstimatedHeight(with: tableView)
    }

    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let header = forwardDelegate?.tableView?(tableView, viewForHeaderInSection: section) {
            return header
        }

        guard let header = dataSource.header(for: section) else {
            return nil
        }

        let view = header.viewFactory.createView(for: tableView, with: section)
        header.eventsHandler.onEvent(event: .didConfigure(context: (table: tableView, view: view, section: section)))

        return view
    }

    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if let footer = forwardDelegate?.tableView?(tableView, viewForFooterInSection: section) {
            return footer
        }

        guard let footer = dataSource.footer(for: section) else {
            return nil
        }

        let view = footer.viewFactory.createView(for: tableView, with: section)
        footer.eventsHandler.onEvent(event: .didConfigure(context: (table: tableView, view: view, section: section)))

        return view
    }

    public func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        forwardDelegate?.tableView?(tableView, accessoryButtonTappedForRowWith: indexPath)

        sendRowEvent(event:
            .accessoryButtonTapped(context: (table: tableView, index: indexPath)), index: indexPath)
    }

    public func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        if let shouldHighlightRow = forwardDelegate?.tableView?(tableView, shouldHighlightRowAt: indexPath) {
            return shouldHighlightRow
        }

        guard let row = dataSource.row(for: indexPath) else {
            return false
        }

        return row.configuration.selection.shouldHighlight
    }

    public func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        forwardDelegate?.tableView?(tableView, didHighlightRowAt: indexPath)

        sendRowEvent(event: .didHighlight(context: (table: tableView, index: indexPath)), index: indexPath)
    }

    public func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        forwardDelegate?.tableView?(tableView, didUnhighlightRowAt: indexPath)

        sendRowEvent(event: .didUnhighlight(context: (table: tableView, index: indexPath)), index: indexPath)
    }

    public func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        var forwardDelegateResult: IndexPath? = nil
        let selector = #selector(UITableViewDelegate.tableView(_:willSelectRowAt:))

        if let forwardDelegate = forwardDelegate, forwardDelegate.responds(to: selector) {
            forwardDelegateResult = forwardDelegate.tableView?(tableView, willSelectRowAt: indexPath)
        }

        sendRowEvent(event: .willSelect(context: (table: tableView, index: indexPath)), index: indexPath)

        return forwardDelegateResult ?? indexPath
    }

    public func tableView(_ tableView: UITableView, willDeselectRowAt indexPath: IndexPath) -> IndexPath? {
        var forwardDelegateResult: IndexPath? = nil
        let selector = #selector(UITableViewDelegate.tableView(_:willDeselectRowAt:))

        if let forwardDelegate = forwardDelegate, forwardDelegate.responds(to: selector) {
            forwardDelegateResult = forwardDelegate.tableView?(tableView, willDeselectRowAt: indexPath)
        }

        sendRowEvent(event: .willDeselect(context: (table: tableView, index: indexPath)), index: indexPath)

        return forwardDelegateResult ?? indexPath
    }

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        forwardDelegate?.tableView?(tableView, didSelectRowAt: indexPath)

        sendRowEvent(event: .didSelect(context: (table: tableView, index: indexPath)), index: indexPath)

        if let row = dataSource.row(for: indexPath),
            row.configuration.selection.shouldReset {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }

    public func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        forwardDelegate?.tableView?(tableView, didDeselectRowAt: indexPath)

        sendRowEvent(event: .didDeselect(context: (table: tableView, index: indexPath)), index: indexPath)
    }

    public func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        if let rowEditingStyle = forwardDelegate?.tableView?(tableView, editingStyleForRowAt: indexPath) {
            return rowEditingStyle
        }

        guard let row = dataSource.row(for: indexPath) else {
            return .none
        }

        return row.configuration.editing.style
    }

    public func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        let selector = #selector(UITableViewDelegate.tableView(_:titleForDeleteConfirmationButtonForRowAt:))
        if let forwardDelegate = forwardDelegate, forwardDelegate.responds(to: selector) {
            return forwardDelegate.tableView?(tableView, titleForDeleteConfirmationButtonForRowAt: indexPath)
        }

        guard let row = dataSource.row(for: indexPath) else {
            return nil
        }

        return row.configuration.editing.titleForDeleteConfirmationButton
    }

    public func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let selector = #selector(UITableViewDelegate.tableView(_:editActionsForRowAt:))
        if let forwardDelegate = forwardDelegate, forwardDelegate.responds(to: selector) {
            return forwardDelegate.tableView?(tableView, editActionsForRowAt: indexPath)
        }

        guard let row = dataSource.row(for: indexPath) else {
            return nil
        }

        return row.configuration.editing.actions
    }

    public func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        if let shouldIndentWhileEditing = forwardDelegate?.tableView?(tableView, shouldIndentWhileEditingRowAt: indexPath) {
            return shouldIndentWhileEditing
        }

        guard let row = dataSource.row(for: indexPath) else {
            return false
        }

        return row.configuration.editing.shouldIndent
    }

    public func tableView(_ tableView: UITableView, willBeginEditingRowAt indexPath: IndexPath) {
        forwardDelegate?.tableView?(tableView, willBeginEditingRowAt: indexPath)

        sendRowEvent(event: .willBeginEditing(context: (table: tableView, index: indexPath)), index: indexPath)
    }

    public func tableView(_ tableView: UITableView, didEndEditingRowAt indexPath: IndexPath?) {
        forwardDelegate?.tableView?(tableView, didEndEditingRowAt: indexPath)

        if let indexPath = indexPath {
            sendRowEvent(event: .didEndEditing(context: (table: tableView, index: indexPath)), index: indexPath)
        }
    }

    public func tableView(_ tableView: UITableView, targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath,
                          toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath {
        return forwardDelegate?.tableView?(tableView, targetIndexPathForMoveFromRowAt: sourceIndexPath,
                                           toProposedIndexPath: proposedDestinationIndexPath) ?? proposedDestinationIndexPath
    }

    public func tableView(_ tableView: UITableView, indentationLevelForRowAt indexPath: IndexPath) -> Int {
        if let rowIndentationLevel = forwardDelegate?.tableView?(tableView, indentationLevelForRowAt: indexPath) {
            return rowIndentationLevel
        }

        guard let row = dataSource.row(for: indexPath) else {
            return 0
        }

        return row.configuration.indentationLevel
    }

    public func tableView(_ tableView: UITableView, shouldShowMenuForRowAt indexPath: IndexPath) -> Bool {
        if let shouldShowMenu = forwardDelegate?.tableView?(tableView, shouldShowMenuForRowAt: indexPath) {
            return shouldShowMenu
        }

        guard let row = dataSource.row(for: indexPath) else {
            return false
        }

        return row.configuration.shouldShowMenu
    }

    public func tableView(_ tableView: UITableView, canPerformAction action: Selector,
                          forRowAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return forwardDelegate?.tableView?(tableView, canPerformAction: action,
                                           forRowAt: indexPath, withSender: sender) ?? true
    }

    public func tableView(_ tableView: UITableView, performAction action: Selector,
                          forRowAt indexPath: IndexPath, withSender sender: Any?) {
        forwardDelegate?.tableView?(tableView, performAction: action,
                                    forRowAt: indexPath, withSender: sender)

        sendRowEvent(event: .performAction(context:
            (table: tableView, action: action, index: indexPath, sender: sender)), index: indexPath)
    }

    @available(iOS 9.0, *)
    public func tableView(_ tableView: UITableView, canFocusRowAt indexPath: IndexPath) -> Bool {
        if let canFocusRow = forwardDelegate?.tableView?(tableView, canFocusRowAt: indexPath) {
            return canFocusRow
        }

        guard let row = dataSource.row(for: indexPath) else {
            return false
        }

        return row.configuration.canFocus
    }

    @available(iOS 9.0, *)
    public func tableView(_ tableView: UITableView, shouldUpdateFocusIn context: UITableViewFocusUpdateContext) -> Bool {
        return forwardDelegate?.tableView?(tableView, shouldUpdateFocusIn: context) ?? true
    }

    @available(iOS 9.0, *)
    public func tableView(_ tableView: UITableView, didUpdateFocusIn context: UITableViewFocusUpdateContext,
                          with coordinator: UIFocusAnimationCoordinator) {
        forwardDelegate?.tableView?(tableView, didUpdateFocusIn: context, with: coordinator)
    }

    @available(iOS 9.0, *)
    public func indexPathForPreferredFocusedView(in tableView: UITableView) -> IndexPath? {
        return forwardDelegate?.indexPathForPreferredFocusedView?(in: tableView)
    }

    private func sendRowEvent(event: TableRowEvent, index: IndexPath) {
        guard let row = dataSource.row(for: index) else {
            return
        }

        row.eventsHandler.onEvent(event: event)
    }
}

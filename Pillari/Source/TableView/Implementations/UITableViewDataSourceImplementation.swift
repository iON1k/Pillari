public final class UITableViewDataSourceImplementation: NSObject {
    public var dataSource: TableDataSourceProtocol

    public weak var forwardDataSource: UITableViewDataSource?

    public init(dataSource: TableDataSourceProtocol = TableDataSource()) {
        self.dataSource = dataSource
    }
}

extension UITableViewDataSourceImplementation: UITableViewDataSource {

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = dataSource.section(for: section) else {
            return 0
        }

        return section.rows.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let row = dataSource.row(for: indexPath) else {
            return UITableViewCell()
        }

        let cell = row.cellFactory.createCell(for: tableView, with: indexPath)
        row.eventsHandler.onEvent(event: .didConfigure(context:
            (table: tableView, cell: cell, index: indexPath)))

        return cell
    }

    public func numberOfSections(in tableView: UITableView) -> Int {
        if let numberOfSections = forwardDataSource?.numberOfSections?(in: tableView) {
            return numberOfSections
        }

        return dataSource.sections.count
    }

    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if let headerTitle = forwardDataSource?.tableView?(tableView, titleForHeaderInSection: section) {
            return headerTitle
        }

        let header = dataSource.header(for: section)
        return header?.configuration.title
    }

    public func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        if let footerTitle = forwardDataSource?.tableView?(tableView, titleForFooterInSection: section) {
            return footerTitle
        }

        let footer = dataSource.footer(for: section)
        return footer?.configuration.title
    }

    public func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if let canEditRow = forwardDataSource?.tableView?(tableView, canEditRowAt: indexPath) {
            return canEditRow
        }

        guard let row = dataSource.row(for: indexPath) else {
            return false
        }

        return row.configuration.editing.canEdit
    }

    public func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        if let canMoveRow = forwardDataSource?.tableView?(tableView, canMoveRowAt: indexPath) {
            return canMoveRow
        }

        guard let row = dataSource.row(for: indexPath) else {
            return false
        }

        return row.configuration.editing.canMove
    }

    public func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return forwardDataSource?.sectionIndexTitles?(for: tableView)
    }

    public func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        return forwardDataSource?.tableView?(tableView, sectionForSectionIndexTitle: title, at: index) ?? 0
    }

    public func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        forwardDataSource?.tableView?(tableView, commit: editingStyle, forRowAt: indexPath)

        let row = dataSource.row(for: indexPath)
        row?.eventsHandler.onEvent(event: .commitEditing(context:
            (table: tableView, editingStyle: editingStyle, index: indexPath)))
    }

    public func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        forwardDataSource?.tableView?(tableView, moveRowAt: sourceIndexPath, to: destinationIndexPath)

        let row = dataSource.row(for: sourceIndexPath)
        row?.eventsHandler.onEvent(event: .move(context:
            (table: tableView, sourceIndex: sourceIndexPath, destinationIndex: destinationIndexPath)))
    }
}

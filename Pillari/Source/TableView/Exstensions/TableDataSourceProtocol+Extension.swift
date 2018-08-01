//  Created by Anton Popkov on 25.08.17.

public extension TableDataSourceProtocol {
    func row(section sectionIndex: Int, row rowIndex: Int) -> TableRowProtocol? {
        return section(for: sectionIndex)?.rows[try: rowIndex]
    }

    func row(for indexPath: IndexPath) -> TableRowProtocol? {
        return row(section: indexPath.section, row: indexPath.row)
    }

    func header(for sectionIndex: Int) -> TableHeaderFooterProtocol? {
        return section(for: sectionIndex)?.header
    }

    func footer(for sectionIndex: Int) -> TableHeaderFooterProtocol? {
        return section(for: sectionIndex)?.footer
    }

    func section(for sectionIndex: Int) -> TableSectionProtocol? {
        return sections[try: sectionIndex]
    }

    func asTablePillar(tableView: UITableView? = nil) -> TablePillar {
        return TablePillar(tableView: tableView, dataSource: self)
    }
}

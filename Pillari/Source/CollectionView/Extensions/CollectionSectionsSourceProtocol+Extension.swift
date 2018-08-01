//  Created by Anton Popkov on 24.10.17.

public extension CollectionDataSourceProtocol {
    func row(section sectionIndex: Int, row rowIndex: Int) -> CollectionRowProtocol? {
        return section(for: sectionIndex)?.rows[try: rowIndex]
    }

    func row(for indexPath: IndexPath) -> CollectionRowProtocol? {
        return row(section: indexPath.section, row: indexPath.row)
    }

    func section(for sectionIndex: Int) -> CollectionSectionProtocol? {
        return sections[try: sectionIndex]
    }
}

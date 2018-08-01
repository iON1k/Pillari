//  Created by Anton Popkov on 24.10.17.

public extension CollectionFlowLayoutSourceProtocol {
    func rowLayout(section sectionIndex: Int, row rowIndex: Int) -> CollectionElementFlowLayoutProtocol? {
        return sectionLayout(for: sectionIndex)?.rowsLayout[try: rowIndex]
    }

    func rowLayout(for indexPath: IndexPath) -> CollectionElementFlowLayoutProtocol? {
        return rowLayout(section: indexPath.section, row: indexPath.row)
    }

    func sectionLayout(for sectionIndex: Int) -> CollectionSectionFlowLayoutProtocol? {
        return sectionsLayout[try: sectionIndex]
    }
}

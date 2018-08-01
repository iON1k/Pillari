//  Created by Anton Popkov on 27.10.17.

public extension CollectionRow where TCell: HeightCalculator {
    func withFlowLayout(item: TCell.Configuration, width: CGFloat) -> CollectionFlowLayoutRow {
        return CollectionFlowLayoutRow(row: self, sizeCalculator: CollectionElementSizeCalculator(TCell.self, item: item, width: width))
    }

    func withFlowLayout(item: TCell.Configuration) -> CollectionFlowLayoutRow {
        return CollectionFlowLayoutRow(row: self, sizeCalculator: CollectionElementSizeCalculator(TCell.self, item: item))
    }
}

public extension CollectionRow where TCell: HeightCalculator, TCell.Configuration == Void {
    func withFlowLayout(width: CGFloat) -> CollectionFlowLayoutRow {
        return withFlowLayout(item: Void(), width: width)
    }

    func withFlowLayout() -> CollectionFlowLayoutRow {
        return withFlowLayout(item: Void())
    }
}

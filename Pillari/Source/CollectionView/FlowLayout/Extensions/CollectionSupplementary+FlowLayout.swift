//  Created by Anton Popkov on 31.10.17.

public extension CollectionSupplementary where TView: HeightCalculator {
    func withFlowLayout(item: TView.Configuration, width: CGFloat) -> CollectionFlowLayoutSupplementary {
        return CollectionFlowLayoutSupplementary(
            supplementary: self,
            sizeCalculator: CollectionElementSizeCalculator(TView.self, item: item, width: width)
        )
    }

    func withFlowLayout(item: TView.Configuration) -> CollectionFlowLayoutSupplementary {
        return CollectionFlowLayoutSupplementary(
            supplementary: self,
            sizeCalculator: CollectionElementSizeCalculator(TView.self, item: item)
        )
    }
}

public extension CollectionSupplementary where TView: HeightCalculator, TView.Configuration == Void {
    func withFlowLayout(width: CGFloat) -> CollectionFlowLayoutSupplementary {
        return withFlowLayout(item: Void(), width: width)
    }

    func withFlowLayout() -> CollectionFlowLayoutSupplementary {
        return withFlowLayout(item: Void())
    }
}

public extension CollectionRowProtocol {
    @available(iOS 10.0, *)
    func withFlowAutomaticLayout() -> CollectionFlowLayoutRow {
        return withFlowLayout(sizeCalculator: UICollectionViewFlowLayoutAutomaticSize)
    }

    func withFlowLayout(sizeCalculator: CollectionElementSizeCalculatorProtocol) -> CollectionFlowLayoutRow {
        return CollectionFlowLayoutRow(row: self, sizeCalculator: sizeCalculator)
    }
}

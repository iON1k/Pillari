public extension CollectionSupplementaryProtocol {
    @available(iOS 10.0, *)
    func withFlowAutomaticLayout() -> CollectionFlowLayoutSupplementary {
        return withFlowLayout(sizeCalculator: UICollectionViewFlowLayout.automaticSize)
    }

    func withFlowLayout(sizeCalculator: CollectionElementSizeCalculatorProtocol) -> CollectionFlowLayoutSupplementary {
        return CollectionFlowLayoutSupplementary(supplementary: self, sizeCalculator: sizeCalculator)
    }
}

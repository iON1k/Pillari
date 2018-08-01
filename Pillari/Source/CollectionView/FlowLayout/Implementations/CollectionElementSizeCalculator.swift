public final class CollectionElementSizeCalculator: CollectionElementSizeCalculatorProtocol {
    public typealias SizeCalculationHandler = (UICollectionView) -> CGSize

    private let sizeCalculationHandler: SizeCalculationHandler

    public init(sizeCalculationHandler: @escaping SizeCalculationHandler) {
        self.sizeCalculationHandler = sizeCalculationHandler
    }

    public func calculateSize(with collectionView: UICollectionView) -> CGSize {
        return sizeCalculationHandler(collectionView)
    }
}

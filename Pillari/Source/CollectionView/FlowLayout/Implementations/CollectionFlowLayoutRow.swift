public final class CollectionFlowLayoutRow: CollectionFlowLayoutRowProtocol {
    public let row: CollectionRowProtocol
    public let sizeCalculator: CollectionElementSizeCalculatorProtocol

    public init(row: CollectionRowProtocol, sizeCalculator: CollectionElementSizeCalculatorProtocol) {
        self.row = row
        self.sizeCalculator = sizeCalculator
    }
}

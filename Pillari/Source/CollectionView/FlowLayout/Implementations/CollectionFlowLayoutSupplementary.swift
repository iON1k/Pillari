//  Created by Anton Popkov on 24.10.17.

public final class CollectionFlowLayoutSupplementary: CollectionFlowLayoutSupplementaryProtocol {
    public let supplementary: CollectionSupplementaryProtocol
    public let sizeCalculator: CollectionElementSizeCalculatorProtocol

    public init(supplementary: CollectionSupplementaryProtocol, sizeCalculator: CollectionElementSizeCalculatorProtocol) {
        self.supplementary = supplementary
        self.sizeCalculator = sizeCalculator
    }
}

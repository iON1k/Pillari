import Quickimport Nimble
@testable import Pillari

class CollectionFlowLayoutSupplementaryTests: QuickSpec {
    override func spec() {
        describe(".init") {
            it("should return valid supplementary") {
                let supplementary = CollectionSupplementary()
                let sizeCalculator = CollectionElementSizeCalculator { _ in .zero }
                let flowSupplementary = CollectionFlowLayoutSupplementary(supplementary: supplementary, sizeCalculator: sizeCalculator)

                expect(flowSupplementary.supplementary).to(beIdenticalTo(supplementary))
                expect(flowSupplementary.sizeCalculator).to(beIdenticalTo(sizeCalculator))
            }
        }
    }
}

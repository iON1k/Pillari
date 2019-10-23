import Quick
import Nimble
@testable import Pillari

// swiftlint:disable type_name

class CollectionSupplementaryProtocolFlowLayoutTests: QuickSpec {
    override func spec() {
        let supplementary: CollectionSupplementaryProtocol = CollectionSupplementary<CollectionSupplementaryViewMock>()

        describe(".withFlowLayout(sizeCalculator:)") {
            it("should return valid value") {
                let size = CGSize(width: 40, height: 30)
                let flowSupplementary = supplementary.withFlowLayout(sizeCalculator: size)
                expect(flowSupplementary.supplementary).to(beIdenticalTo(supplementary))
                expect(flowSupplementary.sizeCalculator as? CGSize).to(equal(size))
            }
        }

        describe(".withFlowAutomaticLayout") {
            it("should return valid value") {
                let flowSupplementary = supplementary.withFlowAutomaticLayout()
                expect(flowSupplementary.supplementary).to(beIdenticalTo(supplementary))
                expect(flowSupplementary.sizeCalculator as? CGSize).to(equal(UICollectionViewFlowLayout.automaticSize))
            }
        }
    }
}

// swiftlint:enable type_name

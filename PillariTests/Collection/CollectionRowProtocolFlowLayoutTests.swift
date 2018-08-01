//  Created by Anton Popkov on 16.11.17.

import Quick
import Nimble

@testable import Pillari

class CollectionRowProtocolFlowLayoutTests: QuickSpec {
    override func spec() {
        let row: CollectionRowProtocol = CollectionRow<CollectionCellMock>()

        describe(".withFlowLayout(sizeCalculator:)") {
            it("should return valid value") {
                let size = CGSize(width: 40, height: 30)
                let flowRow = row.withFlowLayout(sizeCalculator: size)
                expect(flowRow.row).to(beIdenticalTo(row))
                expect(flowRow.sizeCalculator as? CGSize).to(equal(size))
            }
        }

        describe(".withFlowAutomaticLayout") {
            it("should return valid value") {
                let flowRow = row.withFlowAutomaticLayout()
                expect(flowRow.row).to(beIdenticalTo(row))
                expect(flowRow.sizeCalculator as? CGSize).to(equal(UICollectionViewFlowLayoutAutomaticSize))
            }
        }
    }
}

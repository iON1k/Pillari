//  Created by Anton Popkov on 14.11.17.

import Quick
import Nimble

@testable import Pillari

class CollectionFlowLayoutRowTests: QuickSpec {
    override func spec() {
        describe(".init") {
            it("should return valid row") {
                let row = CollectionRow()
                let sizeCalculator = CollectionElementSizeCalculator { _ in .zero }
                let flowRow = CollectionFlowLayoutRow(row: row, sizeCalculator: sizeCalculator)

                expect(flowRow.row).to(beIdenticalTo(row))
                expect(flowRow.sizeCalculator).to(beIdenticalTo(sizeCalculator))
            }
        }
    }
}

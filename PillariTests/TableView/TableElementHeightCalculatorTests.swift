import Quick
import Nimble
@testable import Pillari

class TableElementHeightCalculatorTests: QuickSpec {
    override func spec() {
        let tableView = UITableView()
        let expectedHeight: CGFloat = 50
        let expectedEstimatedHeight: CGFloat = 150

        let viewHeightCalculator = TableElementHeightCalculator(heightCalculationHandler: { _ in
            return expectedHeight
        }, estimatedHeightCalculationHandler: { _ in
            return expectedEstimatedHeight
        })

        describe(".calculateHeight(tableView:)") {
            it("should calculated height equals to expected height") {
                expect(viewHeightCalculator.calculateHeight(with: tableView)).to(equal(expectedHeight))
            }
        }

        describe(".calculateEstimatedHeight(tableView:)") {
            it("should calculated height equals to expected height") {
                expect(viewHeightCalculator.calculateEstimatedHeight(with: tableView)).to(equal(expectedEstimatedHeight))
            }
        }
    }
}

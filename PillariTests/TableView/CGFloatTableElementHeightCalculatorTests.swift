import Quickimport Nimble
@testable import Pillari

class CGFloatTableElementHeightCalculatorTests: QuickSpec {
    override func spec() {
        let tableView = UITableView()
        let height = CGFloat(50)

        describe(".calculateHeight(with:)") {
            it("should calculated height equals to self") {
                expect(height.calculateHeight(with: tableView)).to(equal(height))
            }
        }

        describe(".calculateEstimatedHeight(with:)") {
            it("should calculated height equals to self") {
                expect(height.calculateEstimatedHeight(with: tableView)).to(equal(height))
            }
        }
    }
}

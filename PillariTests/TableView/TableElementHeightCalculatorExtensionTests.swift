//  Created by Anton Popkov on 09.11.17.

import Quick
import Nimble

@testable import Pillari

// swiftlint:disable type_name

class TableElementHeightCalculatorExtensionTests: QuickSpec {
    override func spec() {
        let tableView = UITableView()

        describe(".init(height: estimatedHeight:)") {
            it("should return valid instance") {
                let expectedHeight: CGFloat = 30
                let expectedEstimatedHeight: CGFloat = 40
                let viewHeightCalculator =
                    TableElementHeightCalculator(height: expectedHeight,
                                                 estimatedHeight: expectedEstimatedHeight)

                expect(viewHeightCalculator.calculateHeight(with: tableView)).to(equal(expectedHeight))
                expect(viewHeightCalculator.calculateEstimatedHeight(with: tableView))
                    .to(equal(expectedEstimatedHeight))
            }
        }

        describe(".init(_: item:)") {
            it("should return valid instance") {
                let viewHeightCalculator =
                    TableElementHeightCalculator(TableCellMock.self,
                                                 item: ViewModelMock())

                expect(viewHeightCalculator.calculateHeight(with: tableView)).to(equal(TableCellMock.defaultHeight))
                expect(viewHeightCalculator.calculateEstimatedHeight(with: tableView))
                    .to(equal(TableCellMock.defaultEstimatedHeight))
            }
        }
    }
}

// swiftlint:enable type_name

import Quick
import Nimble
@testable import Pillari

class TableRowTests: QuickSpec {
    override func spec() {
        describe(".init") {
            it("should return valid row") {
                let cellFactory = TableCellFactory(UITableViewCell.self)
                let heightCalculator = TableElementHeightCalculator { _ in 0 }
                let indentationLevel = 10
                let configuration = TableRowConfiguration(indentationLevel: indentationLevel)
                let eventsHandler = TableRow.RowEventsHandler()
                let row = TableRow(
                    cellFactory: cellFactory,
                    heightCalculator: heightCalculator,
                    configuration: configuration,
                    eventsHandler: eventsHandler
                )

                expect(row.cellFactory).to(beIdenticalTo(cellFactory))
                expect(row.heightCalculator).to(beIdenticalTo(heightCalculator))
                expect(row.configuration.indentationLevel).to(equal(indentationLevel))
                expect(row.eventsHandler).to(beIdenticalTo(eventsHandler))
            }
        }
    }
}

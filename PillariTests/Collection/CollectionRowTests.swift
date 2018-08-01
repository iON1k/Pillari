import Quick
import Nimble
@testable import Pillari

class CollectionRowTests: QuickSpec {
    override func spec() {
        describe(".init") {
            it("should return valid row") {
                let cellFactory = CollectionCellFactory(UICollectionViewCell.self)
                let canMove = true
                let configuration = CollectionRowConfiguration(canMove: canMove)
                let eventsHandler = CollectionRow.RowEventsHandler()
                let row = CollectionRow(cellFactory: cellFactory, configuration: configuration, eventsHandler: eventsHandler)

                expect(row.cellFactory).to(beIdenticalTo(cellFactory))
                expect(row.configuration.canMove).to(equal(canMove))
                expect(row.eventsHandler).to(beIdenticalTo(eventsHandler))
            }
        }
    }
}

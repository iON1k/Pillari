//  Created by Anton Popkov on 10.11.17.

import Quick
import Nimble

@testable import Pillari

// swiftlint:disable function_body_length
// swiftlint:disable type_name

class UITableViewDataSourceImplementationEventsTests: QuickSpec {
    override func spec() {
        let expectedTableView = UITableView()
        let expectedIndexPath = IndexPath(row: 3, section: 0)
        var tableDataSource: UITableViewDataSource!
        var eventsHandler: EventsHandlerMock<TableRowEvent>!

        beforeEach {
            eventsHandler = EventsHandlerMock()

            let row = TableRow<TableVoidCellMock>(eventsHandler: eventsHandler.onEvent)
            let dataSource =
                Array(repeating: row, count: 5)
                    .asSections()
                    .asDataSource()

            tableDataSource = UITableViewDataSourceImplementation(dataSource: dataSource)
        }

        describe(".cellForRow") {
            it("should send didConfigure event") {
                let expectedCell = tableDataSource.tableView(expectedTableView, cellForRowAt: expectedIndexPath)
                let event = expectOnlyOneEvent(eventsHandler.events)
                guard case .didConfigure(let context)? = event else {
                    XCTAssert(false, "Event no sends")
                    return
                }

                expect(context.table).to(beIdenticalTo(expectedTableView))
                expect(context.cell).to(beIdenticalTo(expectedCell))
                expect(context.index).to(equal(expectedIndexPath))
            }
        }

        describe(".commitEditingStyle") {
            it("should send commitEditing event") {
                let expectedEditingStyle = UITableViewCellEditingStyle.delete
                tableDataSource.tableView?(expectedTableView, commit: expectedEditingStyle, forRowAt: expectedIndexPath)
                let event = expectOnlyOneEvent(eventsHandler.events)
                guard case .commitEditing(let context)? = event else {
                    XCTAssert(false, "Event no sends")
                    return
                }

                expect(context.table).to(beIdenticalTo(expectedTableView))
                expect(context.editingStyle).to(equal(expectedEditingStyle))
                expect(context.index).to(equal(expectedIndexPath))
            }
        }

        describe(".moveRow") {
            it("should send move event") {
                let expectedDestIndexPath = IndexPath(row: 3, section: 4)
                tableDataSource.tableView?(expectedTableView, moveRowAt: expectedIndexPath, to: expectedDestIndexPath)

                let event = expectOnlyOneEvent(eventsHandler.events)
                guard case .move(let context)? = event else {
                    XCTAssert(false, "Event no sends")
                    return
                }

                expect(context.table).to(beIdenticalTo(expectedTableView))
                expect(context.sourceIndex).to(equal(expectedIndexPath))
                expect(context.destinationIndex).to(equal(expectedDestIndexPath))
            }
        }
    }
}

// swiftlint:enable function_body_length
// swiftlint:enable type_name

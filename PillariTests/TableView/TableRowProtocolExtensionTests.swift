import Quick
import Nimble
@testable import Pillari

// swiftlint:disable function_body_length

class TableRowProtocolExtensionTests: QuickSpec {
    override func spec() {
        let expectedTableView = UITableView()
        let expectedIndexPath = IndexPath(row: 3, section: 0)
        let expectedCellFactory = TableCellFactory(TableCellMock.self)
        let expectedCell = UITableViewCell()
        let expectedHeightCalculator = TableElementHeightCalculator(height: 10, estimatedHeight: 10)

        var eventsHandler: EventsHandlerMock<TableRowEvent>!
        var expectedRow: TableRowProtocol!

        beforeEach {
            eventsHandler = EventsHandlerMock()
            expectedRow = TableRow(cellFactory: expectedCellFactory,
                           heightCalculator: expectedHeightCalculator,
                           configuration: .init(indentationLevel: 10),
                           eventsHandler: .init(handler: eventsHandler.onEvent))
        }

        describe(".with(action:)") {
            it("should send didSelect event") {
                let newRowEventsHandler = EventsHandlerMock<TableRowEvent>()
                let newRow = expectedRow.with(action: newRowEventsHandler.onEvent)
                expectRowHasValidData(newRow)
                newRow.eventsHandler.onEvent(event: .didSelect(context: (table: expectedTableView, index: expectedIndexPath)))

                if case .didSelect(let context)? = expectOnlyOneEvent(eventsHandler.events) {
                    expect(context.table).to(beIdenticalTo(expectedTableView))
                    expect(context.index).to(equal(expectedIndexPath))
                } else {
                    XCTAssert(false, "Original row event no sends")
                    return
                }

                if case .didSelect(let context)? = expectOnlyOneEvent(newRowEventsHandler.events) {
                    expect(context.table).to(beIdenticalTo(expectedTableView))
                    expect(context.index).to(equal(expectedIndexPath))
                } else {
                    XCTAssert(false, "New row event no sends")
                    return
                }
            }
        }

        describe(".withDidSelect(action:)") {
            it("should send didSelect event") {
                let newRowEventsHandler = EventsHandlerMock<TableRowEvent.Context>()
                let newRow = expectedRow.withDidSelect(action: newRowEventsHandler.onEvent)
                expectRowHasValidData(newRow)

                newRow.eventsHandler.onEvent(event: .didSelect(context: (table: expectedTableView, index: expectedIndexPath)))

                if let context = expectOnlyOneEvent(newRowEventsHandler.events) {
                    expect(context.table).to(beIdenticalTo(expectedTableView))
                    expect(context.index).to(equal(expectedIndexPath))
                } else {
                    XCTAssert(false, "New row event no sends")
                    return
                }
            }

            it("should not send any event") {
                let newRowEventsHandler = EventsHandlerMock<TableRowEvent.Context>()
                let newRow = expectedRow.withDidSelect(action: newRowEventsHandler.onEvent)
                newRow.eventsHandler.onEvent(event: .didDeselect(context: (table: expectedTableView, index: expectedIndexPath)))
                expectNoEvents(newRowEventsHandler.events)
            }
        }

        describe(".withDidDeselect(action:)") {
            it("should send didDeselect event") {
                let newRowEventsHandler = EventsHandlerMock<TableRowEvent.Context>()
                let newRow = expectedRow.withDidDeselect(action: newRowEventsHandler.onEvent)
                expectRowHasValidData(newRow)

                newRow.eventsHandler.onEvent(event: .didDeselect(context: (table: expectedTableView, index: expectedIndexPath)))

                if let context = expectOnlyOneEvent(newRowEventsHandler.events) {
                    expect(context.table).to(beIdenticalTo(expectedTableView))
                    expect(context.index).to(equal(expectedIndexPath))
                } else {
                    XCTAssert(false, "New row event no sends")
                    return
                }
            }

            it("should not send any event") {
                let newRowEventsHandler = EventsHandlerMock<TableRowEvent.Context>()
                let newRow = expectedRow.withDidDeselect(action: newRowEventsHandler.onEvent)
                newRow.eventsHandler.onEvent(event: .didSelect(context: (table: expectedTableView, index: expectedIndexPath)))
                expectNoEvents(newRowEventsHandler.events)
            }
        }

        describe(".withWillDisplay(action:)") {
            it("should send willDisplay event") {
                let newRowEventsHandler = EventsHandlerMock<TableRowEvent.CellContext>()
                let newRow = expectedRow.withWillDisplay(action: newRowEventsHandler.onEvent)
                expectRowHasValidData(newRow)

                newRow.eventsHandler.onEvent(event: .willDisplay(context: (table: expectedTableView,
                                                                           cell: expectedCell,
                                                                           index: expectedIndexPath)))

                if let context = expectOnlyOneEvent(newRowEventsHandler.events) {
                    expect(context.table).to(beIdenticalTo(expectedTableView))
                    expect(context.cell).to(beIdenticalTo(expectedCell))
                    expect(context.index).to(equal(expectedIndexPath))
                } else {
                    XCTAssert(false, "New row event no sends")
                    return
                }
            }

            it("should not send any event") {
                let newRowEventsHandler = EventsHandlerMock<TableRowEvent.CellContext>()
                let newRow = expectedRow.withWillDisplay(action: newRowEventsHandler.onEvent)
                newRow.eventsHandler.onEvent(event: .didSelect(context: (table: expectedTableView, index: expectedIndexPath)))
                expectNoEvents(newRowEventsHandler.events)
            }
        }

        describe(".withDidEndDisplaying(action:)") {
            it("should send didEndDisplaying event") {
                let newRowEventsHandler = EventsHandlerMock<TableRowEvent.CellContext>()
                let newRow = expectedRow.withDidEndDisplaying(action: newRowEventsHandler.onEvent)
                expectRowHasValidData(newRow)

                newRow.eventsHandler.onEvent(event: .didEndDisplaying(context: (table: expectedTableView,
                                                                                cell: expectedCell,
                                                                                index: expectedIndexPath)))

                if let context = expectOnlyOneEvent(newRowEventsHandler.events) {
                    expect(context.table).to(beIdenticalTo(expectedTableView))
                    expect(context.cell).to(beIdenticalTo(expectedCell))
                    expect(context.index).to(equal(expectedIndexPath))
                } else {
                    XCTAssert(false, "New row event no sends")
                    return
                }
            }

            it("should not send any event") {
                let newRowEventsHandler = EventsHandlerMock<TableRowEvent.CellContext>()
                let newRow = expectedRow.withDidEndDisplaying(action: newRowEventsHandler.onEvent)
                newRow.eventsHandler.onEvent(event: .didSelect(context: (table: expectedTableView, index: expectedIndexPath)))
                expectNoEvents(newRowEventsHandler.events)
            }
        }

        describe(".withDidConfigure(action:)") {
            it("should send didConfigure event") {
                let newRowEventsHandler = EventsHandlerMock<TableRowEvent.CellContext>()
                let newRow = expectedRow.withDidConfigure(action: newRowEventsHandler.onEvent)
                expectRowHasValidData(newRow)

                newRow.eventsHandler.onEvent(event: .didConfigure(context: (table: expectedTableView,
                                                                            cell: expectedCell,
                                                                            index: expectedIndexPath)))

                if let context = expectOnlyOneEvent(newRowEventsHandler.events) {
                    expect(context.table).to(beIdenticalTo(expectedTableView))
                    expect(context.cell).to(beIdenticalTo(expectedCell))
                    expect(context.index).to(equal(expectedIndexPath))
                } else {
                    XCTAssert(false, "New row event no sends")
                    return
                }
            }

            it("should not send any event") {
                let newRowEventsHandler = EventsHandlerMock<TableRowEvent.CellContext>()
                let newRow = expectedRow.withDidConfigure(action: newRowEventsHandler.onEvent)
                newRow.eventsHandler.onEvent(event: .didSelect(context: (table: expectedTableView, index: expectedIndexPath)))
                expectNoEvents(newRowEventsHandler.events)
            }
        }

        describe(".withMove(action:)") {
            it("should send didConfigure event") {
                let newRowEventsHandler = EventsHandlerMock<TableRowEvent.MoveContext>()
                let newRow = expectedRow.withMove(action: newRowEventsHandler.onEvent)
                expectRowHasValidData(newRow)

                newRow.eventsHandler.onEvent(event: .move(context: (table: expectedTableView,
                                                                    sourceIndex: expectedIndexPath,
                                                                    destinationIndex: expectedIndexPath)))

                if let context = expectOnlyOneEvent(newRowEventsHandler.events) {
                    expect(context.table).to(beIdenticalTo(expectedTableView))
                    expect(context.sourceIndex).to(equal(expectedIndexPath))
                    expect(context.destinationIndex).to(equal(expectedIndexPath))
                } else {
                    XCTAssert(false, "New row event no sends")
                    return
                }
            }

            it("should not send any event") {
                let newRowEventsHandler = EventsHandlerMock<TableRowEvent.MoveContext>()
                let newRow = expectedRow.withMove(action: newRowEventsHandler.onEvent)
                newRow.eventsHandler.onEvent(event: .didSelect(context: (table: expectedTableView, index: expectedIndexPath)))
                expectNoEvents(newRowEventsHandler.events)
            }
        }

        func expectRowHasValidData(_ row: TableRowProtocol) {
            expect(row.configuration.indentationLevel)
                .to(equal(expectedRow.configuration.indentationLevel))
            expect(row.heightCalculator).to(beIdenticalTo(expectedRow.heightCalculator))
            expect(row.cellFactory).to(beIdenticalTo(expectedRow.cellFactory))
        }
    }
}

// swiftlint:enable function_body_length

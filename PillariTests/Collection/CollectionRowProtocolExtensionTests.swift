import Quick
import Nimble
@testable import Pillari

// swiftlint:disable function_body_length

class CollectionRowProtocolExtensionTests: QuickSpec {
    override func spec() {
        let expectedCollectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
        let expectedIndexPath = IndexPath(row: 3, section: 0)
        let expectedCellFactory = CollectionCellFactory(CollectionCellMock.self)
        let expectedCell = UICollectionViewCell()

        var eventsHandler: EventsHandlerMock<CollectionRowEvent>!
        var expectedRow: CollectionRowProtocol!

        beforeEach {
            eventsHandler = EventsHandlerMock()
            expectedRow = CollectionRow(cellFactory: expectedCellFactory,
                                        configuration: .init(canMove: true),
                                        eventsHandler: .init(handler: eventsHandler.onEvent))
        }

        describe(".with(action:)") {
            it("should send didSelect event") {
                let newRowEventsHandler = EventsHandlerMock<CollectionRowEvent>()
                let newRow = expectedRow.with(action: newRowEventsHandler.onEvent)
                expectRowHasValidData(newRow)

                newRow.eventsHandler.onEvent(event: .didSelect(context: (collection: expectedCollectionView, index: expectedIndexPath)))

                if case .didSelect(let context)? = expectOnlyOneEvent(eventsHandler.events) {
                    expect(context.collection).to(beIdenticalTo(expectedCollectionView))
                    expect(context.index).to(equal(expectedIndexPath))
                } else {
                    XCTAssert(false, "Original row event no sends")
                    return
                }

                if case .didSelect(let context)? = expectOnlyOneEvent(newRowEventsHandler.events) {
                    expect(context.collection).to(beIdenticalTo(expectedCollectionView))
                    expect(context.index).to(equal(expectedIndexPath))
                } else {
                    XCTAssert(false, "New row event no sends")
                    return
                }
            }
        }

        describe(".withDidSelect(action:)") {
            it("should send didSelect event") {
                let newRowEventsHandler = EventsHandlerMock<CollectionRowEvent.Context>()
                let newRow = expectedRow.withDidSelect(action: newRowEventsHandler.onEvent)
                expectRowHasValidData(newRow)

                newRow.eventsHandler.onEvent(event: .didSelect(context: (collection: expectedCollectionView, index: expectedIndexPath)))

                if let context = expectOnlyOneEvent(newRowEventsHandler.events) {
                    expect(context.collection).to(beIdenticalTo(expectedCollectionView))
                    expect(context.index).to(equal(expectedIndexPath))
                } else {
                    XCTAssert(false, "New row event no sends")
                    return
                }
            }

            it("should not send any event") {
                let newRowEventsHandler = EventsHandlerMock<CollectionRowEvent.Context>()
                let newRow = expectedRow.withDidSelect(action: newRowEventsHandler.onEvent)
                newRow.eventsHandler.onEvent(event: .didDeselect(context: (collection: expectedCollectionView, index: expectedIndexPath)))
                expectNoEvents(newRowEventsHandler.events)
            }
        }

        describe(".withDidDeselect(action:)") {
            it("should send didDeselect event") {
                let newRowEventsHandler = EventsHandlerMock<CollectionRowEvent.Context>()
                let newRow = expectedRow.withDidDeselect(action: newRowEventsHandler.onEvent)
                expectRowHasValidData(newRow)

                newRow.eventsHandler.onEvent(event: .didDeselect(context: (collection: expectedCollectionView, index: expectedIndexPath)))

                if let context = expectOnlyOneEvent(newRowEventsHandler.events) {
                    expect(context.collection).to(beIdenticalTo(expectedCollectionView))
                    expect(context.index).to(equal(expectedIndexPath))
                } else {
                    XCTAssert(false, "New row event no sends")
                    return
                }
            }

            it("should not send any event") {
                let newRowEventsHandler = EventsHandlerMock<CollectionRowEvent.Context>()
                let newRow = expectedRow.withDidDeselect(action: newRowEventsHandler.onEvent)
                newRow.eventsHandler.onEvent(event: .didSelect(context: (collection: expectedCollectionView, index: expectedIndexPath)))
                expectNoEvents(newRowEventsHandler.events)
            }
        }

        describe(".withWillDisplay(action:)") {
            it("should send willDisplay event") {
                let newRowEventsHandler = EventsHandlerMock<CollectionRowEvent.CellContext>()
                let newRow = expectedRow.withWillDisplay(action: newRowEventsHandler.onEvent)
                expectRowHasValidData(newRow)

                newRow.eventsHandler.onEvent(event: .willDisplay(context: (collection: expectedCollectionView,
                                                                           cell: expectedCell,
                                                                           index: expectedIndexPath)))

                if let context = expectOnlyOneEvent(newRowEventsHandler.events) {
                    expect(context.collection).to(beIdenticalTo(expectedCollectionView))
                    expect(context.cell).to(beIdenticalTo(expectedCell))
                    expect(context.index).to(equal(expectedIndexPath))
                } else {
                    XCTAssert(false, "New row event no sends")
                    return
                }
            }

            it("should not send any event") {
                let newRowEventsHandler = EventsHandlerMock<CollectionRowEvent.CellContext>()
                let newRow = expectedRow.withWillDisplay(action: newRowEventsHandler.onEvent)
                newRow.eventsHandler.onEvent(event: .didSelect(context: (collection: expectedCollectionView, index: expectedIndexPath)))
                expectNoEvents(newRowEventsHandler.events)
            }
        }

        describe(".withDidEndDisplaying(action:)") {
            it("should send didEndDisplaying event") {
                let newRowEventsHandler = EventsHandlerMock<CollectionRowEvent.CellContext>()
                let newRow = expectedRow.withDidEndDisplaying(action: newRowEventsHandler.onEvent)
                expectRowHasValidData(newRow)

                newRow.eventsHandler.onEvent(event: .didEndDisplaying(context: (collection: expectedCollectionView,
                                                                                cell: expectedCell,
                                                                                index: expectedIndexPath)))

                if let context = expectOnlyOneEvent(newRowEventsHandler.events) {
                    expect(context.collection).to(beIdenticalTo(expectedCollectionView))
                    expect(context.cell).to(beIdenticalTo(expectedCell))
                    expect(context.index).to(equal(expectedIndexPath))
                } else {
                    XCTAssert(false, "New row event no sends")
                    return
                }
            }

            it("should not send any event") {
                let newRowEventsHandler = EventsHandlerMock<CollectionRowEvent.CellContext>()
                let newRow = expectedRow.withDidEndDisplaying(action: newRowEventsHandler.onEvent)
                newRow.eventsHandler.onEvent(event: .didSelect(context: (collection: expectedCollectionView, index: expectedIndexPath)))
                expectNoEvents(newRowEventsHandler.events)
            }
        }

        describe(".withDidConfigure(action:)") {
            it("should send didConfigure event") {
                let newRowEventsHandler = EventsHandlerMock<CollectionRowEvent.CellContext>()
                let newRow = expectedRow.withDidConfigure(action: newRowEventsHandler.onEvent)
                expectRowHasValidData(newRow)

                newRow.eventsHandler.onEvent(event: .didConfigure(context: (collection: expectedCollectionView,
                                                                            cell: expectedCell,
                                                                            index: expectedIndexPath)))

                if let context = expectOnlyOneEvent(newRowEventsHandler.events) {
                    expect(context.collection).to(beIdenticalTo(expectedCollectionView))
                    expect(context.cell).to(beIdenticalTo(expectedCell))
                    expect(context.index).to(equal(expectedIndexPath))
                } else {
                    XCTAssert(false, "New row event no sends")
                    return
                }
            }

            it("should not send any event") {
                let newRowEventsHandler = EventsHandlerMock<CollectionRowEvent.CellContext>()
                let newRow = expectedRow.withDidConfigure(action: newRowEventsHandler.onEvent)
                newRow.eventsHandler.onEvent(event: .didSelect(context: (collection: expectedCollectionView, index: expectedIndexPath)))
                expectNoEvents(newRowEventsHandler.events)
            }
        }

        describe(".withMove(action:)") {
            it("should send didConfigure event") {
                let newRowEventsHandler = EventsHandlerMock<CollectionRowEvent.MoveContext>()
                let newRow = expectedRow.withMove(action: newRowEventsHandler.onEvent)
                expectRowHasValidData(newRow)

                newRow.eventsHandler.onEvent(event: .move(context: (collection: expectedCollectionView,
                                                                    sourceIndex: expectedIndexPath,
                                                                    destinationIndex: expectedIndexPath)))

                if let context = expectOnlyOneEvent(newRowEventsHandler.events) {
                    expect(context.collection).to(beIdenticalTo(expectedCollectionView))
                    expect(context.sourceIndex).to(equal(expectedIndexPath))
                    expect(context.destinationIndex).to(equal(expectedIndexPath))
                } else {
                    XCTAssert(false, "New row event no sends")
                    return
                }
            }

            it("should not send any event") {
                let newRowEventsHandler = EventsHandlerMock<CollectionRowEvent.MoveContext>()
                let newRow = expectedRow.withMove(action: newRowEventsHandler.onEvent)
                newRow.eventsHandler.onEvent(event: .didSelect(context: (collection: expectedCollectionView, index: expectedIndexPath)))
                expectNoEvents(newRowEventsHandler.events)
            }
        }

        func expectRowHasValidData(_ row: CollectionRowProtocol) {
            expect(row.configuration.canMove)
                .to(equal(expectedRow.configuration.canMove))
            expect(row.cellFactory).to(beIdenticalTo(expectedRow.cellFactory))
        }
    }
}

// swiftlint:enable function_body_length

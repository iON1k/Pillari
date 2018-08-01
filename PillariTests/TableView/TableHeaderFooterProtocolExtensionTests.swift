import Quick
import Nimble
@testable import Pillari

// swiftlint:disable function_body_length

class TableHeaderFooterProtocolExtensionTests: QuickSpec {
    override func spec() {
        let expectedTableView = UITableView()
        let expectedSectionIndex = 3
        let expectedViewFactory = TableHeaderFooterFactory(TableHeaderFooterViewMock.self)
        let expectedView = UITableViewHeaderFooterView()
        let expectedHeightCalculator = TableElementHeightCalculator(height: 10, estimatedHeight: 10)

        var eventsHandler: EventsHandlerMock<TableHeaderFooterEvent>!
        var expectedHeader: TableHeaderFooterProtocol!

        beforeEach {
            eventsHandler = EventsHandlerMock()
            expectedHeader = TableHeaderFooter(viewFactory: expectedViewFactory,
                                               heightCalculator: expectedHeightCalculator,
                                               configuration: .init(title: "Test"),
                                               eventsHandler: .init(handler: eventsHandler.onEvent))
        }

        describe(".with(action:)") {
            it("should send didSelect event") {
                let newHeaderEventsHandler = EventsHandlerMock<TableHeaderFooterEvent>()
                let newHeader = expectedHeader.with(action: newHeaderEventsHandler.onEvent)
                expectHeaderHasValidData(newHeader)

                newHeader.eventsHandler.onEvent(event: .didConfigure(context: (table: expectedTableView,
                                                                               view: expectedView,
                                                                               section: expectedSectionIndex)))

                if case .didConfigure(let context)? = expectOnlyOneEvent(eventsHandler.events) {
                    expect(context.table).to(beIdenticalTo(expectedTableView))
                    expect(context.view).to(beIdenticalTo(expectedView))
                    expect(context.section).to(equal(expectedSectionIndex))
                } else {
                    XCTAssert(false, "Original header event no sends")
                    return
                }

                if case .didConfigure(let context)? = expectOnlyOneEvent(newHeaderEventsHandler.events) {
                    expect(context.table).to(beIdenticalTo(expectedTableView))
                    expect(context.view).to(beIdenticalTo(expectedView))
                    expect(context.section).to(equal(expectedSectionIndex))
                } else {
                    XCTAssert(false, "New header event no sends")
                    return
                }
            }
        }

        describe(".withWillDisplay(action:)") {
            it("should send willDisplay event") {
                let newHeaderEventsHandler = EventsHandlerMock<TableHeaderFooterEvent.Context>()
                let newHeader = expectedHeader.withWillDisplay(action: newHeaderEventsHandler.onEvent)
                expectHeaderHasValidData(newHeader)

                newHeader.eventsHandler.onEvent(event: .willDisplay(context: (table: expectedTableView,
                                                                              view: expectedView,
                                                                              section: expectedSectionIndex)))

                if let context = expectOnlyOneEvent(newHeaderEventsHandler.events) {
                    expect(context.table).to(beIdenticalTo(expectedTableView))
                    expect(context.view).to(beIdenticalTo(expectedView))
                    expect(context.section).to(equal(expectedSectionIndex))
                } else {
                    XCTAssert(false, "New row event no sends")
                    return
                }
            }

            it("should not send any event") {
                let newHeaderEventsHandler = EventsHandlerMock<TableHeaderFooterEvent.Context>()
                let newHeader = expectedHeader.withWillDisplay(action: newHeaderEventsHandler.onEvent)
                newHeader.eventsHandler.onEvent(event: .didConfigure(context: (table: expectedTableView,
                                                                               view: expectedView,
                                                                               section: expectedSectionIndex)))
                expectNoEvents(newHeaderEventsHandler.events)
            }
        }

        describe(".withDidEndDisplaying(action:)") {
            it("should send didEndDisplaying event") {
                let newHeaderEventsHandler = EventsHandlerMock<TableHeaderFooterEvent.Context>()
                let newHeader = expectedHeader.withDidEndDisplaying(action: newHeaderEventsHandler.onEvent)
                expectHeaderHasValidData(newHeader)

                newHeader.eventsHandler.onEvent(event: .didEndDisplaying(context: (table: expectedTableView,
                                                                                   view: expectedView,
                                                                                   section: expectedSectionIndex)))

                if let context = expectOnlyOneEvent(newHeaderEventsHandler.events) {
                    expect(context.table).to(beIdenticalTo(expectedTableView))
                    expect(context.view).to(beIdenticalTo(expectedView))
                    expect(context.section).to(equal(expectedSectionIndex))
                } else {
                    XCTAssert(false, "New row event no sends")
                    return
                }
            }

            it("should not send any event") {
                let newHeaderEventsHandler = EventsHandlerMock<TableHeaderFooterEvent.Context>()
                let newHeader = expectedHeader.withDidEndDisplaying(action: newHeaderEventsHandler.onEvent)
                newHeader.eventsHandler.onEvent(event: .didConfigure(context: (table: expectedTableView,
                                                                               view: expectedView,
                                                                               section: expectedSectionIndex)))
                expectNoEvents(newHeaderEventsHandler.events)
            }
        }

        describe(".withDidConfigure(action:)") {
            it("should send didConfigure event") {
                let newHeaderEventsHandler = EventsHandlerMock<TableHeaderFooterEvent.Context>()
                let newHeader = expectedHeader.withDidConfigure(action: newHeaderEventsHandler.onEvent)
                expectHeaderHasValidData(newHeader)

                newHeader.eventsHandler.onEvent(event: .didConfigure(context: (table: expectedTableView,
                                                                               view: expectedView,
                                                                               section: expectedSectionIndex)))

                if let context = expectOnlyOneEvent(newHeaderEventsHandler.events) {
                    expect(context.table).to(beIdenticalTo(expectedTableView))
                    expect(context.view).to(beIdenticalTo(expectedView))
                    expect(context.section).to(equal(expectedSectionIndex))
                } else {
                    XCTAssert(false, "New row event no sends")
                    return
                }
            }

            it("should not send any event") {
                let newHeaderEventsHandler = EventsHandlerMock<TableHeaderFooterEvent.Context>()
                let newHeader = expectedHeader.withDidConfigure(action: newHeaderEventsHandler.onEvent)
                newHeader.eventsHandler.onEvent(event: .willDisplay(context: (table: expectedTableView,
                                                                              view: expectedView,
                                                                              section: expectedSectionIndex)))
                expectNoEvents(newHeaderEventsHandler.events)
            }
        }

        func expectHeaderHasValidData(_ header: TableHeaderFooterProtocol) {
            expect(header.configuration.title)
                .to(equal(expectedHeader.configuration.title))
            expect(header.heightCalculator).to(beIdenticalTo(expectedHeader.heightCalculator))
            expect(header.viewFactory).to(beIdenticalTo(expectedHeader.viewFactory))
        }
    }
}

// swiftlint:enable function_body_length

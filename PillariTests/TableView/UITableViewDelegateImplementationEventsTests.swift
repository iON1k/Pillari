import Quickimport Nimble
@testable import Pillari

// swiftlint:disable cyclomatic_complexity
// swiftlint:disable function_body_length
// swiftlint:disable type_name

class UITableViewDelegateImplementationEventsTests: QuickSpec {
    override func spec() {
        let expectedTableView = UITableView()
        let expectedCell = UITableViewCell()
        let expectedView = UIView()
        let expectedSection = 4
        let expectedIndexPath = IndexPath(row: 3, section: 0)
        var tableDelegate: UITableViewDelegate!
        var rowEventsHandler: EventsHandlerMock<TableRowEvent>!
        var headerFooterEventsHandler: EventsHandlerMock<TableHeaderFooterEvent>!

        beforeEach {
            rowEventsHandler = EventsHandlerMock()
            headerFooterEventsHandler = EventsHandlerMock()

            let row = TableRow<TableVoidCellMock>(eventsHandler: rowEventsHandler.onEvent)
            let headerFooter = TableHeaderFooter<TableVoidHeaderFooterViewMock>(eventsHandler: headerFooterEventsHandler.onEvent)

            let section = Array(repeating: row, count: 5).asSection(header: headerFooter, footer: headerFooter)

            let dataSource = Array(repeating: section, count: 5).asDataSource()

            tableDelegate = UITableViewDelegateImplementation(dataSource: dataSource)
        }

        describe(".willDisplay") {
            it("should send willDisplay event") {
                tableDelegate.tableView?(expectedTableView, willDisplay: expectedCell, forRowAt: expectedIndexPath)
                expectNoEvents(headerFooterEventsHandler.events)
                let event = expectOnlyOneEvent(rowEventsHandler.events)
                guard case .willDisplay(let context)? = event else {
                    XCTAssert(false, "Event no sends")
                    return
                }

                expect(context.table).to(beIdenticalTo(expectedTableView))
                expect(context.cell).to(beIdenticalTo(expectedCell))
                expect(context.index).to(equal(expectedIndexPath))
            }
        }

        describe(".didEndDisplaying") {
            it("should send didEndDisplaying event") {
                tableDelegate.tableView?(expectedTableView, didEndDisplaying: expectedCell, forRowAt: expectedIndexPath)
                expectNoEvents(headerFooterEventsHandler.events)
                let event = expectOnlyOneEvent(rowEventsHandler.events)
                guard case .didEndDisplaying(let context)? = event else {
                    XCTAssert(false, "Event no sends")
                    return
                }

                expect(context.table).to(beIdenticalTo(expectedTableView))
                expect(context.cell).to(beIdenticalTo(expectedCell))
                expect(context.index).to(equal(expectedIndexPath))
            }
        }

        describe(".didHighlightRowAt") {
            it("should send didHighlight event") {
                tableDelegate.tableView?(expectedTableView, didHighlightRowAt: expectedIndexPath)
                expectNoEvents(headerFooterEventsHandler.events)
                let event = expectOnlyOneEvent(rowEventsHandler.events)
                guard case .didHighlight(let context)? = event else {
                    XCTAssert(false, "Event no sends")
                    return
                }

                expect(context.table).to(beIdenticalTo(expectedTableView))
                expect(context.index).to(equal(expectedIndexPath))
            }
        }

        describe(".didUnhighlightRowAt") {
            it("should send didHighlight event") {
                tableDelegate.tableView?(expectedTableView, didUnhighlightRowAt: expectedIndexPath)
                expectNoEvents(headerFooterEventsHandler.events)
                let event = expectOnlyOneEvent(rowEventsHandler.events)
                guard case .didUnhighlight(let context)? = event else {
                    XCTAssert(false, "Event no sends")
                    return
                }

                expect(context.table).to(beIdenticalTo(expectedTableView))
                expect(context.index).to(equal(expectedIndexPath))
            }
        }

        describe(".willSelectRowAt") {
            it("should send willSelect event") {
                _ = tableDelegate.tableView?(expectedTableView, willSelectRowAt: expectedIndexPath)
                expectNoEvents(headerFooterEventsHandler.events)
                let event = expectOnlyOneEvent(rowEventsHandler.events)
                guard case .willSelect(let context)? = event else {
                    XCTAssert(false, "Event no sends")
                    return
                }

                expect(context.table).to(beIdenticalTo(expectedTableView))
                expect(context.index).to(equal(expectedIndexPath))
            }
        }

        describe(".willDeselectRowAt") {
            it("should send willDeselect event") {
                _ = tableDelegate.tableView?(expectedTableView, willDeselectRowAt: expectedIndexPath)
                expectNoEvents(headerFooterEventsHandler.events)
                let event = expectOnlyOneEvent(rowEventsHandler.events)
                guard case .willDeselect(let context)? = event else {
                    XCTAssert(false, "Event no sends")
                    return
                }

                expect(context.table).to(beIdenticalTo(expectedTableView))
                expect(context.index).to(equal(expectedIndexPath))
            }
        }

        describe(".didSelectRowAt") {
            it("should send didSelect event") {
                tableDelegate.tableView?(expectedTableView, didSelectRowAt: expectedIndexPath)
                expectNoEvents(headerFooterEventsHandler.events)
                let event = expectOnlyOneEvent(rowEventsHandler.events)
                guard case .didSelect(let context)? = event else {
                    XCTAssert(false, "Event no sends")
                    return
                }

                expect(context.table).to(beIdenticalTo(expectedTableView))
                expect(context.index).to(equal(expectedIndexPath))
            }
        }

        describe(".didDeselectRowAt") {
            it("should send didDeselect event") {
                tableDelegate.tableView?(expectedTableView, didDeselectRowAt: expectedIndexPath)
                expectNoEvents(headerFooterEventsHandler.events)
                let event = expectOnlyOneEvent(rowEventsHandler.events)
                guard case .didDeselect(let context)? = event else {
                    XCTAssert(false, "Event no sends")
                    return
                }

                expect(context.table).to(beIdenticalTo(expectedTableView))
                expect(context.index).to(equal(expectedIndexPath))
            }
        }

        describe(".accessoryButtonTappedForRowWith") {
            it("should send accessoryButtonTapped event") {
                tableDelegate.tableView?(expectedTableView, accessoryButtonTappedForRowWith: expectedIndexPath)
                expectNoEvents(headerFooterEventsHandler.events)
                let event = expectOnlyOneEvent(rowEventsHandler.events)
                guard case .accessoryButtonTapped(let context)? = event else {
                    XCTAssert(false, "Event no sends")
                    return
                }

                expect(context.table).to(beIdenticalTo(expectedTableView))
                expect(context.index).to(equal(expectedIndexPath))
            }
        }

        describe(".willBeginEditingRowAt") {
            it("should send willBeginEditing event") {
                tableDelegate.tableView?(expectedTableView, willBeginEditingRowAt: expectedIndexPath)
                expectNoEvents(headerFooterEventsHandler.events)
                let event = expectOnlyOneEvent(rowEventsHandler.events)
                guard case .willBeginEditing(let context)? = event else {
                    XCTAssert(false, "Event no sends")
                    return
                }

                expect(context.table).to(beIdenticalTo(expectedTableView))
                expect(context.index).to(equal(expectedIndexPath))
            }
        }

        describe(".didEndEditingRowAt") {
            it("should send didEndEditing event") {
                tableDelegate.tableView?(expectedTableView, didEndEditingRowAt: expectedIndexPath)
                expectNoEvents(headerFooterEventsHandler.events)
                let event = expectOnlyOneEvent(rowEventsHandler.events)
                guard case .didEndEditing(let context)? = event else {
                    XCTAssert(false, "Event no sends")
                    return
                }

                expect(context.table).to(beIdenticalTo(expectedTableView))
                expect(context.index).to(equal(expectedIndexPath))
            }
        }

        describe(".performAction") {
            it("should send performAction event") {
                let expectedAction = #selector(UITableView.reloadData)
                tableDelegate.tableView?(expectedTableView, performAction: expectedAction,
                                        forRowAt: expectedIndexPath, withSender: self)
                expectNoEvents(headerFooterEventsHandler.events)
                let event = expectOnlyOneEvent(rowEventsHandler.events)
                guard case .performAction(let context)? = event else {
                    XCTAssert(false, "Event no sends")
                    return
                }

                expect(context.table).to(beIdenticalTo(expectedTableView))
                expect(context.action).to(equal(expectedAction))
                expect(context.index).to(equal(expectedIndexPath))
                expect(context.sender).to(beIdenticalTo(self))
            }
        }

        describe(".viewForHeaderInSection") {
            it("should send didConfigure event") {
                let view = tableDelegate.tableView?(expectedTableView, viewForHeaderInSection: expectedSection)
                expectOnlyHeaderFooterDidConfigureEvent(with: view)
            }
        }

        describe(".viewForFooterInSection") {
            it("should send didConfigure event") {
                let view = tableDelegate.tableView?(expectedTableView, viewForFooterInSection: expectedSection)
                expectOnlyHeaderFooterDidConfigureEvent(with: view)
            }
        }

        func expectOnlyHeaderFooterDidConfigureEvent(with expectedView: UIView?) {
            expectNoEvents(rowEventsHandler.events)
            let event = expectOnlyOneEvent(headerFooterEventsHandler.events)
            guard case .didConfigure(let context)? = event else {
                XCTAssert(false, "Event no sends")
                return
            }

            expect(context.table).to(beIdenticalTo(expectedTableView))
            expect(context.view).to(beIdenticalTo(expectedView))
            expect(context.section).to(equal(expectedSection))
        }

        describe(".willDisplayHeaderView") {
            it("should send willDisplay event") {
                tableDelegate.tableView?(expectedTableView,
                                        willDisplayHeaderView: expectedView, forSection: expectedSection)
                expectOnlyHeaderFooterWillDisplayEvent()
            }
        }

        describe(".willDisplayFooterView") {
            it("should send willDisplay event") {
                tableDelegate.tableView?(expectedTableView,
                                         willDisplayFooterView: expectedView, forSection: expectedSection)
                expectOnlyHeaderFooterWillDisplayEvent()
            }
        }

        func expectOnlyHeaderFooterWillDisplayEvent() {
            expectNoEvents(rowEventsHandler.events)
            let event = expectOnlyOneEvent(headerFooterEventsHandler.events)
            guard case .willDisplay(let context)? = event else {
                XCTAssert(false, "Event no sends")
                return
            }

            expect(context.table).to(beIdenticalTo(expectedTableView))
            expect(context.view).to(beIdenticalTo(expectedView))
            expect(context.section).to(equal(expectedSection))
        }

        describe(".didEndDisplayingHeaderView") {
            it("should send willDisplay event") {
                tableDelegate.tableView?(expectedTableView,
                                         didEndDisplayingHeaderView: expectedView, forSection: expectedSection)
                expectOnlyHeaderFooterDidEndDisplayingEvent()
            }
        }

        describe(".didEndDisplayingFooterView") {
            it("should send willDisplay event") {
                tableDelegate.tableView?(expectedTableView,
                                         didEndDisplayingFooterView: expectedView, forSection: expectedSection)
                expectOnlyHeaderFooterDidEndDisplayingEvent()
            }
        }

        func expectOnlyHeaderFooterDidEndDisplayingEvent() {
            expectNoEvents(rowEventsHandler.events)
            let event = expectOnlyOneEvent(headerFooterEventsHandler.events)
            guard case .didEndDisplaying(let context)? = event else {
                XCTAssert(false, "Event no sends")
                return
            }

            expect(context.table).to(beIdenticalTo(expectedTableView))
            expect(context.view).to(beIdenticalTo(expectedView))
            expect(context.section).to(equal(expectedSection))
        }
    }
}

// swiftlint:enable cyclomatic_complexity
// swiftlint:enable function_body_length
// swiftlint:enable type_name

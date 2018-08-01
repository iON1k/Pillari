import Quick
import Nimble
@testable import Pillari

// swiftlint:disable function_body_length
// swiftlint:disable cyclomatic_complexity

class UITableViewReuseTests: QuickSpec {
    override func spec() {
        let customReuseId = "TestReuseId"

        var tableView: UITableViewMock!

        beforeEach {
            tableView = UITableViewMock()
        }

        describe(".registerCell") {
            it("should register cell class with default reuse identifier") {
                tableView.registerCell(TableCellMock.self)
                let event = expectOnlyOneEvent(tableView.events)
                guard case .registerCell(let cellType, let identifier)? = event else {
                    XCTAssert(false, "Method not called")
                    return
                }

                expect(cellType).to(beIdenticalTo(TableCellMock.self))
                expect(identifier).to(equal(UITableView.defaultReuseId(for: TableCellMock.self)))
            }

            it("should register cell class with custom reuse identifier") {
                tableView.registerCell(TableCellMock.self, reuseId: customReuseId)
                let event = expectOnlyOneEvent(tableView.events)
                guard case .registerCell(let cellType, let identifier)? = event else {
                    XCTAssert(false, "Method not called")
                    return
                }

                expect(cellType).to(beIdenticalTo(TableCellMock.self))
                expect(identifier).to(equal(customReuseId))
            }

            it("should register cell nib with default reuse identifier") {
                tableView.registerCell(TableNibCellMock.self)
                let event = expectOnlyOneEvent(tableView.events)
                guard case .registerCellNib(let nib, let identifier)? = event else {
                    XCTAssert(false, "Method not called")
                    return
                }

                expect(nib).to(equal(TableNibCellMock.nib))
                expect(identifier).to(equal(UITableView.defaultReuseId(for: TableNibCellMock.self)))
            }

            it("should register cell nib with custom reuse identifier") {
                tableView.registerCell(TableNibCellMock.self, reuseId: customReuseId)
                let event = expectOnlyOneEvent(tableView.events)
                guard case .registerCellNib(let nib, let identifier)? = event else {
                    XCTAssert(false, "Method not called")
                    return
                }

                expect(nib).to(equal(TableNibCellMock.nib))
                expect(identifier).to(equal(customReuseId))
            }
        }

        describe(".registerHeaderFooter") {
            it("should register header/footer class with default reuse identifier") {
                tableView.registerHeaderFooterView(TableHeaderFooterViewMock.self)
                let event = expectOnlyOneEvent(tableView.events)
                guard case .registerHeaderFooter(let headerFooterType, let identifier)? = event else {
                    XCTAssert(false, "Method not called")
                    return
                }

                expect(headerFooterType).to(beIdenticalTo(TableHeaderFooterViewMock.self))
                expect(identifier).to(equal(UITableView.defaultReuseId(for: TableHeaderFooterViewMock.self)))
            }

            it("should register header/footer class with custom reuse identifier") {
                tableView.registerHeaderFooterView(TableHeaderFooterViewMock.self, reuseId: customReuseId)
                let event = expectOnlyOneEvent(tableView.events)
                guard case .registerHeaderFooter(let headerFooterType, let identifier)? = event else {
                    XCTAssert(false, "Method not called")
                    return
                }

                expect(headerFooterType).to(beIdenticalTo(TableHeaderFooterViewMock.self))
                expect(identifier).to(equal(customReuseId))
            }

            it("should register header/footer nib with default reuse identifier") {
                tableView.registerHeaderFooterView(TableNibHeaderFooterViewMock.self)
                let event = expectOnlyOneEvent(tableView.events)
                guard case .registerHeaderFooterNib(let nib, let identifier)? = event else {
                    XCTAssert(false, "Method not called")
                    return
                }

                expect(nib).to(equal(TableNibHeaderFooterViewMock.nib))
                expect(identifier).to(equal(UITableView.defaultReuseId(for: TableNibHeaderFooterViewMock.self)))
            }

            it("should register header/footer nib with custom reuse identifier") {
                tableView.registerHeaderFooterView(TableNibHeaderFooterViewMock.self, reuseId: customReuseId)
                let event = expectOnlyOneEvent(tableView.events)
                guard case .registerHeaderFooterNib(let nib, let identifier)? = event else {
                    XCTAssert(false, "Method not called")
                    return
                }

                expect(nib).to(equal(TableNibHeaderFooterViewMock.nib))
                expect(identifier).to(equal(customReuseId))
            }
        }

        describe(".dequeueReusableCell") {
            it("should try to dequeue cell with default reuse identifier") {
                let cell = tableView.dequeueReusableCell(TableCellMock.self)
                let event = expectOnlyOneEvent(tableView.events)
                guard case .dequeueReusableCell(let identifier)? = event else {
                    XCTAssert(false, "Method not called")
                    return
                }

                expect(identifier).to(equal(UITableView.defaultReuseId(for: TableCellMock.self)))
                expect(cell).to(beNil())
            }

            it("should try to dequeue cell with custom reuse identifier") {
                let cell = tableView.dequeueReusableCell(TableCellMock.self, reuseId: customReuseId)
                let event = expectOnlyOneEvent(tableView.events)
                guard case .dequeueReusableCell(let identifier)? = event else {
                    XCTAssert(false, "Method not called")
                    return
                }

                expect(identifier).to(equal(customReuseId))
                expect(cell).to(beNil())
            }

            it("should dequeue cell with default reuse identifier") {
                tableView.register(TableCellMock.self,
                                   forCellReuseIdentifier: UITableView.defaultReuseId(for: TableCellMock.self))
                let cell = tableView.dequeueReusableCell(TableCellMock.self)
                expect(cell).notTo(beNil())
            }

            it("should dequeue cell with custom reuse identifier") {
                tableView.register(TableCellMock.self, forCellReuseIdentifier: customReuseId)
                let cell = tableView.dequeueReusableCell(TableCellMock.self, reuseId: customReuseId)
                expect(cell).notTo(beNil())
            }
        }

        describe(".dequeueReusableHeaderFooterView") {
            it("should try to dequeue header/footer with default reuse identifier") {
                let header = tableView.dequeueReusableHeaderFooterView(TableHeaderFooterViewMock.self)
                let event = expectOnlyOneEvent(tableView.events)
                guard case .dequeueReusableHeaderFooterView(let identifier)? = event else {
                    XCTAssert(false, "Method not called")
                    return
                }

                expect(identifier).to(equal(UITableView.defaultReuseId(for: TableHeaderFooterViewMock.self)))
                expect(header).to(beNil())
            }

            it("should try to dequeue header/footer with custom reuse identifier") {
                let header = tableView.dequeueReusableHeaderFooterView(TableHeaderFooterViewMock.self, reuseId: customReuseId)
                let event = expectOnlyOneEvent(tableView.events)
                guard case .dequeueReusableHeaderFooterView(let identifier)? = event else {
                    XCTAssert(false, "Method not called")
                    return
                }

                expect(identifier).to(equal(customReuseId))
                expect(header).to(beNil())
            }

            it("should dequeue header/footer with default reuse identifier") {
                tableView.register(TableHeaderFooterViewMock.self,
                                   forHeaderFooterViewReuseIdentifier: UITableView.defaultReuseId(for: TableHeaderFooterViewMock.self))
                let header = tableView.dequeueReusableHeaderFooterView(TableHeaderFooterViewMock.self)
                expect(header).notTo(beNil())
            }

            it("should dequeue header/footer with custom reuse identifier") {
                tableView.register(TableHeaderFooterViewMock.self, forHeaderFooterViewReuseIdentifier: customReuseId)
                let header = tableView.dequeueReusableHeaderFooterView(TableHeaderFooterViewMock.self,
                                                                       reuseId: customReuseId)
                expect(header).notTo(beNil())
            }
        }

        describe(".dequeueReusableCellWithAutoregistration") {
            it("should dequeue cell with default reuse identifier") {
                let cell = tableView.dequeueReusableCellWithAutoregistration(TableCellMock.self)
                expect(cell).notTo(beNil())
            }

            it("should dequeue cell with custom reuse identifier") {
                let cell = tableView.dequeueReusableCellWithAutoregistration(TableCellMock.self,
                                                                             reuseId: customReuseId)
                expect(cell).notTo(beNil())
            }

            it("should throw assertion") {
                tableView.shouldRegisterCellsAndViews = false
                expect {
                    _ = tableView.dequeueReusableCellWithAutoregistration(TableCellMock.self)
                }
                .to(throwAssertion())
            }
        }

        describe(".dequeueReusableHeaderFooterViewWithAutoregistration") {
            it("should dequeue header/footer with default reuse identifier") {
                let header = tableView.dequeueReusableHeaderFooterViewWithAutoregistration(
                    TableHeaderFooterViewMock.self
                )
                expect(header).notTo(beNil())
            }

            it("should dequeue header/footer with custom reuse identifier") {
                let header = tableView.dequeueReusableHeaderFooterViewWithAutoregistration(
                    TableHeaderFooterViewMock.self,
                    reuseId: customReuseId
                )
                expect(header).notTo(beNil())
            }

            it("should throw assertion") {
                tableView.shouldRegisterCellsAndViews = false
                expect {
                    _ = tableView.dequeueReusableHeaderFooterViewWithAutoregistration(TableHeaderFooterViewMock.self)
                }
                .to(throwAssertion())
            }
        }
    }
}

// swiftlint:enable function_body_length
// swiftlint:enable cyclomatic_complexity

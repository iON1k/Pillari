//  Created by Anton Popkov on 25.08.17.

import Quick
import Nimble

@testable import Pillari

// swiftlint:disable function_body_length
// swiftlint:disable type_name

class UITableViewDataSourceImplementationForwardDataSourceTests: QuickSpec {
    override func spec() {
        let expectedTableView = UITableView()
        let expectedSection = 0
        let expectedIndexPath = IndexPath(row: 3, section: 0)
        var tableDataSource: UITableViewDataSource!
        var forwardTableDataSourceMock: UITableViewDataSourceMock!

        beforeEach {
            let dataSource =
                Array(repeating: TableRow<TableVoidCellMock>(), count: 5)
                    .asSections()
                    .asDataSource()

            let tableDataSourceImpl = UITableViewDataSourceImplementation(dataSource: dataSource)
            forwardTableDataSourceMock = UITableViewDataSourceMock()
            tableDataSourceImpl.forwardDataSource = forwardTableDataSourceMock
            tableDataSource = tableDataSourceImpl
        }

        describe(".forwardDataSource") {
            it("should equals to expected value") {
                expect((tableDataSource as? UITableViewDataSourceImplementation)?.forwardDataSource).to(beIdenticalTo(forwardTableDataSourceMock))
            }

            it("should to be nil") {
                let tableDataSourceImpl = tableDataSource as? UITableViewDataSourceImplementation
                tableDataSourceImpl?.forwardDataSource = UITableViewDataSourceMock()
                expect(tableDataSourceImpl?.forwardDataSource).to(beNil())
            }
        }

        describe(".numberOfRows") {
            it("should not call forward data source method") {
                _ = tableDataSource.tableView(expectedTableView, numberOfRowsInSection: expectedSection)
                expect(forwardTableDataSourceMock.events).to(beEmpty())
            }
        }

        describe(".cellForRow") {
            it("should not call forward data source method") {
                _ = tableDataSource.tableView(expectedTableView, cellForRowAt: expectedIndexPath)
                expect(forwardTableDataSourceMock.events).to(beEmpty())
            }
        }

        describe(".numberOfSections") {
            it("should call forward data source method") {
                let numberOfSections = tableDataSource.numberOfSections?(in: expectedTableView)
                expect(numberOfSections).to(equal(forwardTableDataSourceMock.numberOfSections))

                let event = expectOnlyOneEvent(forwardTableDataSourceMock.events)
                guard case .numberOfSections(let tableView)? = event else {
                    XCTAssert(false, "Method not called")
                    return
                }

                expect(tableView).to(beIdenticalTo(expectedTableView))
            }
        }

        describe(".titleForHeader") {
            it("should call forward data source method") {
                let titleForHeader = tableDataSource.tableView?(expectedTableView, titleForHeaderInSection: expectedSection)
                expect(titleForHeader).to(equal(forwardTableDataSourceMock.titleForHeader))

                let event = expectOnlyOneEvent(forwardTableDataSourceMock.events)
                guard case .titleForHeader(let tableView, let section)? = event else {
                    XCTAssert(false, "Method not called")
                    return
                }

                expect(tableView).to(beIdenticalTo(expectedTableView))
                expect(section).to(equal(expectedSection))
            }
        }

        describe(".titleForFooter") {
            it("should call forward data source method") {
                let titleForFooter = tableDataSource.tableView?(expectedTableView, titleForFooterInSection: expectedSection)
                expect(titleForFooter).to(equal(forwardTableDataSourceMock.titleForFooter))

                let event = expectOnlyOneEvent(forwardTableDataSourceMock.events)
                guard case .titleForFooter(let tableView, let section)? = event else {
                    XCTAssert(false, "Method not called")
                    return
                }

                expect(tableView).to(beIdenticalTo(expectedTableView))
                expect(section).to(equal(expectedSection))
            }
        }

        describe(".canEditRow") {
            it("should call forward data source method") {
                let canEditRow = tableDataSource.tableView?(expectedTableView, canEditRowAt: expectedIndexPath)
                expect(canEditRow).to(equal(forwardTableDataSourceMock.canEditRow))

                let event = expectOnlyOneEvent(forwardTableDataSourceMock.events)
                guard case .canEditRow(let tableView, let indexPath)? = event else {
                    XCTAssert(false, "Method not called")
                    return
                }

                expect(tableView).to(beIdenticalTo(expectedTableView))
                expect(indexPath).to(equal(expectedIndexPath))
            }
        }

        describe(".canMoveRow") {
            it("should call forward data source method") {
                let canMoveRow = tableDataSource.tableView?(expectedTableView, canMoveRowAt: expectedIndexPath)
                expect(canMoveRow).to(equal(forwardTableDataSourceMock.canMoveRow))

                let event = expectOnlyOneEvent(forwardTableDataSourceMock.events)
                guard case .canMoveRow(let tableView, let indexPath)? = event else {
                    XCTAssert(false, "Method not called")
                    return
                }

                expect(tableView).to(beIdenticalTo(expectedTableView))
                expect(indexPath).to(equal(expectedIndexPath))
            }
        }

        describe(".sectionIndexTitles") {
            it("should call forward data source method") {
                let sectionIndexTitles = tableDataSource.sectionIndexTitles?(for: expectedTableView)
                expect(sectionIndexTitles).to(equal(forwardTableDataSourceMock.sectionIndexTitles))

                let event = expectOnlyOneEvent(forwardTableDataSourceMock.events)
                guard case .sectionIndexTitles(let tableView)? = event else {
                    XCTAssert(false, "Method not called")
                    return
                }

                expect(tableView).to(beIdenticalTo(expectedTableView))
            }
        }

        describe(".sectionForSectionIndexTitle") {
            it("should call forward data source method") {
                let expectedIndexTitle = "TestIndexTitle"
                let sectionForSectionIndexTitle =
                    tableDataSource.tableView?(expectedTableView,
                                               sectionForSectionIndexTitle: expectedIndexTitle, at: expectedSection)
                expect(sectionForSectionIndexTitle).to(equal(forwardTableDataSourceMock.sectionForSectionIndexTitle))

                let event = expectOnlyOneEvent(forwardTableDataSourceMock.events)
                guard case .sectionForSectionIndexTitle(let tableView, let indexTitle, let section)? = event else {
                    XCTAssert(false, "Method not called")
                    return
                }

                expect(tableView).to(beIdenticalTo(expectedTableView))
                expect(indexTitle).to(equal(indexTitle))
                expect(section).to(equal(expectedSection))
            }
        }

        describe(".commitEditingStyle") {
            it("should call forward data source method") {
                let expectedEditingStyle = UITableViewCellEditingStyle.delete
                tableDataSource.tableView?(expectedTableView, commit: expectedEditingStyle, forRowAt: expectedIndexPath)

                let event = expectOnlyOneEvent(forwardTableDataSourceMock.events)
                guard case .commitEditingStyle(let tableView, let editingStyle, let indexPath)? = event else {
                    XCTAssert(false, "Method not called")
                    return
                }

                expect(tableView).to(beIdenticalTo(expectedTableView))
                expect(editingStyle).to(equal(expectedEditingStyle))
                expect(indexPath).to(equal(expectedIndexPath))
            }
        }

        describe(".moveRow") {
            it("should call forward data source method") {
                let expectedDestIndexPath = IndexPath(row: 3, section: 4)
                tableDataSource.tableView?(expectedTableView, moveRowAt: expectedIndexPath, to: expectedDestIndexPath)

                let event = expectOnlyOneEvent(forwardTableDataSourceMock.events)
                guard case .moveRow(let tableView, let indexPath, let destIndexPath)? = event else {
                    XCTAssert(false, "Method not called")
                    return
                }

                expect(tableView).to(beIdenticalTo(expectedTableView))
                expect(indexPath).to(equal(expectedIndexPath))
                expect(destIndexPath).to(equal(expectedDestIndexPath))
            }
        }
    }
}

// swiftlint:enable function_body_length
// swiftlint:enable type_name

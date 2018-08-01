import Quickimport Nimble
@testable import Pillari

// swiftlint:disable function_body_length

class UITableViewDataSourceImplementationTests: QuickSpec {
    override func spec() {
        let tableView = UITableView()
        let sectionIndex2 = 2
        let rowIndex4 = 4
        let indexPath24 = IndexPath(row: rowIndex4, section: sectionIndex2)
        let cell24 = TableCellMock()
        let cellFactory24 = TableCellFactory { _, _ in
            return cell24
        }
        let configuration24 =
            TableRowConfiguration(
                editing: TableRowConfiguration.Editing(
                    canEdit: true,
                    canMove: true
                )
            )

        let row24 = TableRow<TableCellMock>(cellFactory: cellFactory24,
                                          heightCalculator: CGFloat(10),
                                          configuration: configuration24)

        let header2 = TableHeaderFooter<TableVoidHeaderFooterViewMock>(configuration: TableHeaderFooterConfiguration(title: "Header"))
        let footer2 = TableHeaderFooter<TableVoidHeaderFooterViewMock>(configuration: TableHeaderFooterConfiguration(title: "Footer"))

        let defaultRow = TableRow<TableVoidCellMock>()
        let defaultSection = Array(repeating: defaultRow, count: 5).asSection()
        let section2 = [
            defaultRow,
            defaultRow,
            defaultRow,
            defaultRow,
            row24
        ]
        .asSection(header: header2, footer: footer2)

        let dataSource = [
            defaultSection,
            defaultSection,
            section2
        ]
        .asDataSource()

        let tableDataSource: UITableViewDataSource = UITableViewDataSourceImplementation(dataSource: dataSource)

        describe(".init(dataSource:)") {
            it("should return valid value") {
                expect((tableDataSource as? UITableViewDataSourceImplementation)?.dataSource).to(beIdenticalTo(dataSource))
            }
        }

        describe(".numberOfRows") {
            it("should result equals to expected value") {
                let numberOfRows = tableDataSource.tableView(tableView, numberOfRowsInSection: sectionIndex2)
                expect(numberOfRows).to(equal(section2.rows.count))
            }
        }

        describe(".cellForRow") {
            it("should result equals to expected value") {
                let cell = tableDataSource.tableView(tableView, cellForRowAt: indexPath24)
                expect(cell).to(beIdenticalTo(cell24))
            }
        }

        describe(".numberOfSections") {
            it("should result equals to expected value") {
                let numberOfSections = tableDataSource.numberOfSections?(in: tableView)
                expect(numberOfSections).to(equal(dataSource.sections.count))
            }
        }

        describe(".titleForHeader") {
            it("should result equals to expected value") {
                let titleForHeader = tableDataSource.tableView?(tableView, titleForHeaderInSection: sectionIndex2)
                expect(titleForHeader).to(equal(header2.configuration.title))
            }
        }

        describe(".titleForFooter") {
            it("should result equals to expected value") {
                let titleForFooter = tableDataSource.tableView?(tableView, titleForFooterInSection: sectionIndex2)
                expect(titleForFooter).to(equal(footer2.configuration.title))
            }
        }

        describe(".canEditRow") {
            it("should result equals to expected value") {
                let canEditRow = tableDataSource.tableView?(tableView, canEditRowAt: indexPath24)
                expect(canEditRow).to(equal(configuration24.editing.canEdit))
            }
        }

        describe(".canMoveRow") {
            it("should result equals to expected value") {
                let canMoveRow = tableDataSource.tableView?(tableView, canMoveRowAt: indexPath24)
                expect(canMoveRow).to(equal(configuration24.editing.canMove))
            }
        }
    }
}

// swiftlint:enable function_body_length

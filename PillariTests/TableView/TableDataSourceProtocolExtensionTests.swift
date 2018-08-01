//  Created by Anton Popkov on 08.11.17.

import Quick
import Nimble

@testable import Pillari

class TableDataSourceProtocolExtensionTests: QuickSpec {
    override func spec() {
        let dataSource = (0...4).map { _ -> TableSection in
            return (0...4).map { _ in
                return TableRow<TableVoidCellMock>()
                }.asSection(
                    header: TableHeaderFooter<TableVoidHeaderFooterViewMock>(),
                    footer: TableHeaderFooter<TableVoidHeaderFooterViewMock>()
            )
        }
        .asDataSource()

        describe(".row(section, row)") {
            it("should result equals to expected row") {
                let row = dataSource.row(section: 0, row: 2)
                expect(row).to(beIdenticalTo(dataSource.sections[0].rows[2]))
            }
        }

        describe(".row(for)") {
            it("should result equals to expected row") {
                let row = dataSource.row(for: IndexPath(row: 2, section: 0))
                expect(row).to(beIdenticalTo(dataSource.sections[0].rows[2]))
            }
        }

        describe(".section(for)") {
            it("should result equals to expected section") {
                let section = dataSource.section(for: 1)
                expect(section).to(beIdenticalTo(dataSource.sections[1]))
            }
        }

        describe(".header(for)") {
            it("should result equals to expected header") {
                let header = dataSource.header(for: 1)
                expect(header).to(beIdenticalTo(dataSource.sections[1].header))
            }
        }

        describe(".footer(for)") {
            it("should result equals to expected footer") {
                let footer = dataSource.footer(for: 1)
                expect(footer).to(beIdenticalTo(dataSource.sections[1].footer))
            }
        }

        describe(".asTablePillar(tableView:)") {
            it("should create valid table director") {
                let tableView = UITableView()
                let tablePillar = dataSource.asTablePillar(tableView: tableView)

                expect(tablePillar.dataSource).to(beIdenticalTo(dataSource))
                expect(tablePillar.tableView).to(beIdenticalTo(tableView))
            }
        }
    }
}

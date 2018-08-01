import Quickimport Nimble
@testable import Pillari

class ArrayTablePillarTests: QuickSpec {
    override func spec() {
        let rows = gerenateRows(count: 5)

        let sections = (0...4).map { _ in
            return self.gerenateRows(count: 5).asSection()
        }

        let header = TableHeaderFooter<TableVoidHeaderFooterViewMock>()
        let footer = TableHeaderFooter<TableVoidHeaderFooterViewMock>()

        describe(".asSection") {
            it("should return valid value") {
                let section = rows.asSection(header: header, footer: footer)
                check(section: section)
            }

            it("[TableRowProtocol] should return valid value") {
                let section = (rows as [TableRowProtocol]).asSection(header: header, footer: footer)
                check(section: section)
            }
        }

        describe(".asSections") {
            it("should return valid value") {
                let sections = rows.asSections(header: header, footer: footer)
                check(sections: sections)
            }

            it("[TableRowProtocol] should return valid value") {
                let sections = (rows as [TableRowProtocol]).asSections(header: header, footer: footer)
                check(sections: sections)
            }
        }

        describe(".asDataSource") {
            it("should return valid value") {
                let dataSource = sections.asDataSource()
                expectToIdential(dataSource.sections, to: sections)
            }

            it("[TableSectionProtocol] should return valid value") {
                let dataSource = (sections as [TableSectionProtocol]).asDataSource()
                expectToIdential(dataSource.sections, to: sections)
            }
        }

        func check(section: TableSection) {
            expectToIdential(section.rows, to: rows)
            expect(section.header).to(beIdenticalTo(header))
            expect(section.footer).to(beIdenticalTo(footer))
        }

        func check(sections: [TableSection]) {
            expect(sections.count).to(equal(1))
            check(section: sections[0])
        }
    }

    func gerenateRows(count: Int) -> [TableRowProtocol] {
        return (0...count - 1).map { _ in
            return TableRow<TableVoidCellMock>()
        }
    }
}

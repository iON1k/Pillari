import Quick
import Nimble
@testable import Pillari

class TableSectionTests: QuickSpec {
    override func spec() {
        describe(".init") {
            it("should return valid section") {
                let rows = (0...4).map {_ in TableRow<TableVoidCellMock>() }
                let header = TableHeaderFooter<TableVoidHeaderFooterViewMock>()
                let footer = TableHeaderFooter<TableVoidHeaderFooterViewMock>()
                let section = TableSection(rows: rows, header: header, footer: footer)

                expectToIdential(section.rows, to: rows)
                expect(section.header).to(beIdenticalTo(header))
                expect(section.footer).to(beIdenticalTo(footer))
            }
        }
    }
}

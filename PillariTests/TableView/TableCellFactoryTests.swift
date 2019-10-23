import Quick
import Nimble
@testable import Pillari

class TableCellFactoryTests: QuickSpec {
    override func spec() {
        describe(".createCell(for: with:)") {
            it("should result equals to expected cell") {
                let expectedCell = UITableViewCell()
                let expectedTableView = UITableView()
                let expectedIndexPath = IndexPath(row: 10, section: 5)

                var tableView: UITableView?
                var indexPath: IndexPath?

                let cellFactory = TableCellFactory { table, index in
                    tableView = table
                    indexPath = index
                    return expectedCell
                }

                let cell = cellFactory.createCell(for: expectedTableView, with: expectedIndexPath)
                expect(cell).to(beIdenticalTo(expectedCell))
                expect(tableView).to(beIdenticalTo(expectedTableView))
                expect(indexPath).to(equal(expectedIndexPath))
            }
        }
    }
}

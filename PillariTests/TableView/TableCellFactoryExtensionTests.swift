import Quickimport Nimble
@testable import Pillari

class TableCellFactoryExtensionTests: QuickSpec {
    override func spec() {
        let expectedReuseId = "Test"
        let indexPath = IndexPath()
        let expectedViewModel = ViewModelMock()
        var tableView: UITableView!

        beforeEach {
            tableView = UITableView()
        }

        describe(".init(_: reuseId:)") {
            it("should created cell is kind of expected class") {
                let cellFactory = TableCellFactory(TableCellMock.self)
                let cell = cellFactory.createCell(for: tableView, with: indexPath)
                expect(cell).to(beAKindOf(TableCellMock.self))
            }

            it("should created cell reuse id equals to expected reuse id") {
                let cellFactory = TableCellFactory(TableCellMock.self, reuseId: expectedReuseId)
                let cell = cellFactory.createCell(for: tableView, with: indexPath)
                expect(cell).to(beAKindOf(TableCellMock.self))
                expect(cell.reuseIdentifier).to(equal(expectedReuseId))
            }
        }

        describe(".init(_: item: reuseId:)") {
            it("should created cell is configurated") {
                let cellFactory = TableCellFactory(TableCellMock.self, item: expectedViewModel)
                let cell = cellFactory.createCell(for: tableView, with: indexPath)
                expect(cell).to(beAKindOf(TableCellMock.self))
                expect((cell as? TableCellMock)?.viewModel).to(beIdenticalTo(expectedViewModel))
            }

            it("should created view reuse id equals to expected reuse id") {
                let cellFactory = TableCellFactory(TableCellMock.self, item: expectedViewModel, reuseId: expectedReuseId)
                let cell = cellFactory.createCell(for: tableView, with: indexPath)
                expect(cell).to(beAKindOf(TableCellMock.self))
                expect((cell as? TableCellMock)?.viewModel).to(beIdenticalTo(expectedViewModel))
                expect(cell.reuseIdentifier).to(equal(expectedReuseId))
            }
        }
    }
}

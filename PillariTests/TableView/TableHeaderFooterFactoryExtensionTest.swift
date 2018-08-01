import Quickimport Nimble
@testable import Pillari

class TableHeaderFooterFactoryExtensionTest: QuickSpec {
    override func spec() {
        let expectedReuseId = "Test"
        let expectedViewModel = ViewModelMock()
        var tableView: UITableView!

        beforeEach {
            tableView = UITableView()
        }

        describe(".init(_: reuseId:)") {
            it("should created view is kind of expected class") {
                let viewFactory = TableHeaderFooterFactory(TableHeaderFooterViewMock.self)
                let view = viewFactory.createView(for: tableView, with: 0)
                expect(view).to(beAKindOf(TableHeaderFooterViewMock.self))
            }

            it("should created view reuse id equals to expected reuse id") {
                let viewFactory = TableHeaderFooterFactory(TableHeaderFooterViewMock.self, reuseId: expectedReuseId)
                let view = viewFactory.createView(for: tableView, with: 0)
                expect((view as? UITableViewHeaderFooterView)?.reuseIdentifier).to(equal(expectedReuseId))
            }
        }

        describe(".init(_: item: reuseId:)") {
            it("should created view is configurated") {
                let viewFactory = TableHeaderFooterFactory(TableHeaderFooterViewMock.self, item: expectedViewModel)
                let view = viewFactory.createView(for: tableView, with: 0)
                expect(view).to(beAKindOf(TableHeaderFooterViewMock.self))
                expect((view as? TableHeaderFooterViewMock)?.viewModel).to(beIdenticalTo(expectedViewModel))
            }

            it("should created view reuse id equals to expected reuse id") {
                let viewFactory = TableHeaderFooterFactory(TableHeaderFooterViewMock.self, item: expectedViewModel, reuseId: expectedReuseId)
                let view = viewFactory.createView(for: tableView, with: 0)
                expect((view as? UITableViewHeaderFooterView)?.reuseIdentifier).to(equal(expectedReuseId))
            }
        }
    }
}

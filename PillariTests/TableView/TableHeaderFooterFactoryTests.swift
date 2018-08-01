import Quickimport Nimble
@testable import Pillari

class TableHeaderFooterFactoryTests: QuickSpec {
    override func spec() {
        describe(".createView(for: with)") {
            it("should created view equals to expected view") {
                let expectedView = UIView()
                let expectedTableView = UITableView()
                let expectedSection = 5

                var tableView: UITableView? = nil
                var section: Int? = nil

                let headerFooterFactory = TableHeaderFooterFactory { table, sectionParam in
                    tableView = table
                    section = sectionParam
                    return expectedView
                }

                let view = headerFooterFactory.createView(for: expectedTableView, with: expectedSection)
                expect(view).to(beIdenticalTo(expectedView))
                expect(tableView).to(beIdenticalTo(expectedTableView))
                expect(section).to(equal(expectedSection))
            }
        }
    }
}

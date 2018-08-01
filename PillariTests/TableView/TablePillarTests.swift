//  Created by Anton Popkov on 11.11.17.

import Quick
import Nimble

@testable import Pillari

// swiftlint:disable function_body_length

class TablePillarTests: QuickSpec {
    override func spec() {
        var tablePillar: TablePillar!
        var tableView: UITableView!

        beforeEach {
            tablePillar = TablePillar()
            tableView = UITableView()
            tablePillar.tableView = tableView
        }

        describe(".tableView") {
            it("should not to be nil") {
                expect(tablePillar.tableView).notTo(beNil())
            }

            it("should to be nil") {
                tableView = nil
                expect(tablePillar.tableView).to(beNil())
            }

            it("should has expected delegate/dataSource") {
                expect(tableView.delegate).to(beIdenticalTo(tablePillar.tableViewDelegateImpl))
                expect(tableView.dataSource).to(beIdenticalTo(tablePillar.tableViewDataSourceImpl))
            }

            it("should has nil delegate/dataSource") {
                tablePillar = nil
                expect(tableView.delegate).to(beNil())
                expect(tableView.dataSource).to(beNil())
            }

            it("should prev value has nil delegate/dataSource") {
                tablePillar.tableView = UITableView()
                expect(tableView.delegate).to(beNil())
                expect(tableView.dataSource).to(beNil())
            }
        }

        describe(".dataSource") {
            it("should equals to expected value") {
                let dataSource = TableDataSource()
                tablePillar.dataSource = dataSource
                expect(tablePillar.dataSource).to(beIdenticalTo(dataSource))
                expect(tablePillar.tableViewDataSourceImpl.dataSource).to(beIdenticalTo(dataSource))
                expect(tablePillar.tableViewDelegateImpl.dataSource).to(beIdenticalTo(dataSource))
            }
        }

        describe(".forwardDelegate") {
            it("should to be nil") {
                expect(tablePillar.forwardDelegate).to(beNil())
            }

            it("should equals to expected value") {
                let forwardDelegate = UITableViewDelegateMock()
                tablePillar.forwardDelegate = forwardDelegate
                expect(tablePillar.forwardDelegate).to(beIdenticalTo(forwardDelegate))
                expect(tablePillar.tableViewDelegateImpl.forwardDelegate).to(beIdenticalTo(forwardDelegate))
            }
        }

        describe(".forwardDataSource") {
            it("should to be nil") {
                expect(tablePillar.forwardDataSource).to(beNil())
            }

            it("should equals to expected value") {
                let forwardDataSource = UITableViewDataSourceMock()
                tablePillar.forwardDataSource = forwardDataSource
                expect(tablePillar.forwardDataSource).to(beIdenticalTo(forwardDataSource))
                expect(tablePillar.tableViewDataSourceImpl.forwardDataSource).to(beIdenticalTo(forwardDataSource))
            }
        }

        describe(".init(tableView: dataSource:)") {
            it("should return valid instance") {
                let dataSource = TableDataSource()
                let customTablePillar = TablePillar(tableView: tableView, dataSource: dataSource)

                expect(customTablePillar.tableView).to(beIdenticalTo(tableView))
                expect(customTablePillar.dataSource).to(beIdenticalTo(dataSource))
                expect(customTablePillar.tableViewDataSourceImpl.dataSource).to(beIdenticalTo(dataSource))
                expect(customTablePillar.tableViewDelegateImpl.dataSource).to(beIdenticalTo(dataSource))
                expect(tableView.delegate).to(beIdenticalTo(customTablePillar.tableViewDelegateImpl))
                expect(tableView.dataSource).to(beIdenticalTo(customTablePillar.tableViewDataSourceImpl))
            }
        }
    }
}

// swiftlint:enable function_body_length

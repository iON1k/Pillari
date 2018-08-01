import Quickimport Nimble
@testable import Pillari

// swiftlint:disable function_body_length

class TableRowExtensionTests: QuickSpec {
    override func spec() {
        let expectedReuseId = "Test"
        let expectedViewModel = ViewModelMock()
        let expectedIndentationLevel = 10
        let expectedRowConfiguration = TableRowConfiguration(indentationLevel: expectedIndentationLevel)
        let indexPath = IndexPath()
        let heightCalculator: TableElementHeightCalculatorProtocol = CGFloat(50)

        var didSelectEventHandled = false
        let eventsHandler: (TableRowEvent) -> Void = { event in
            if case .didSelect = event {
                didSelectEventHandled = true
            }
        }

        var tableView: UITableView!

        beforeEach {
            tableView = UITableView()
            didSelectEventHandled = false
        }

        describe(".init(heightCalculator: configuration: reuseId: eventsHadnler:)") {
            it("should return valid row") {
                let row = TableRow<TableCellMock>(heightCalculator: heightCalculator, configuration: expectedRowConfiguration,
                                                  reuseId: expectedReuseId, eventsHandler: eventsHandler)

                checkRow(row: row, cellType: TableCellMock.self)
                checkRowHeightCalculator(row: row)
            }
        }

        describe(".init(item: heightCalculator: configuration: reuseId: eventsHadnler:)") {
            it("should return valid row") {
                let row = TableRow<TableCellMock>(
                    item: expectedViewModel,
                    heightCalculator: heightCalculator,
                    configuration: expectedRowConfiguration,
                    reuseId: expectedReuseId,
                    eventsHandler: eventsHandler
                )

                checkRow(row: row, cellType: TableCellMock.self)
                checkRowHeightCalculator(row: row)
                checkRowViewModel(row: row)
            }
        }

        describe(".init(item: configuration: reuseId: eventsHadnler:)") {
            it("should return valid row") {
                let row = TableRow<TableCellMock>(item: expectedViewModel, configuration: expectedRowConfiguration,
                                                  reuseId: expectedReuseId, eventsHandler: eventsHandler)

                checkRow(row: row, cellType: TableCellMock.self)
                checkRowViewModel(row: row)
                expect(row.heightCalculator.calculateHeight(with: tableView)).to(equal(TableCellMock.defaultHeight))
                expect(row.heightCalculator.calculateEstimatedHeight(with: tableView)).to(equal(TableCellMock.defaultEstimatedHeight))
            }

            it("should return valid row with void configuration") {
                let row = TableRow<TableVoidCellMock>(configuration: expectedRowConfiguration,
                                                      reuseId: expectedReuseId, eventsHandler: eventsHandler)

                checkRow(row: row, cellType: TableVoidCellMock.self)
                expect(row.heightCalculator.calculateHeight(with: tableView)).to(equal(TableVoidCellMock.defaultHeight))
                expect(row.heightCalculator.calculateEstimatedHeight(with: tableView)).to(equal(TableVoidCellMock.defaultEstimatedHeight))
            }
        }

        func checkRowViewModel(row: TableRowProtocol) {
            let cell = row.cellFactory.createCell(for: tableView, with: indexPath)
            expect((cell as? TableCellMock)?.viewModel).to(beIdenticalTo(expectedViewModel))
        }

        func checkRowHeightCalculator(row: TableRowProtocol) {
            expect(row.heightCalculator).to(beIdenticalTo(heightCalculator))
        }

        func checkRow(row: TableRowProtocol, cellType: UITableViewCell.Type) {
            let cell = row.cellFactory.createCell(for: tableView, with: indexPath)
            expect(cell.reuseIdentifier).to(equal(expectedReuseId))
            expect(cell).to(beAKindOf(cellType))

            expect(row.configuration.indentationLevel).to(equal(expectedIndentationLevel))

            row.eventsHandler.onEvent(event: .didSelect(context: (table: tableView, index: indexPath)))
            expect(didSelectEventHandled).to(beTrue())
        }
    }
}

// swiftlint:enable function_body_length

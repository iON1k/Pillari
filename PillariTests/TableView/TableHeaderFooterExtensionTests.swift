//  Created by Anton Popkov on 10.11.17.

import Quick
import Nimble

// swiftlint:disable function_body_length

@testable import Pillari

class TableHeaderFooterExtensionTests: QuickSpec {
    override func spec() {
        let expectedReuseId = "Test"
        let expectedViewModel = ViewModelMock()
        let expectedTitle = "TestTitle"
        let expectedHeaderConfiguration = TableHeaderFooterConfiguration(title: expectedTitle)
        let heightCalculator: TableElementHeightCalculatorProtocol = CGFloat(50)

        var willDisplayEventHandled = false
        let eventsHandler: (TableHeaderFooterEvent) -> Void = { event in
            if case .willDisplay = event {
                willDisplayEventHandled = true
            }
        }

        var tableView: UITableView!

        beforeEach {
            tableView = UITableView()
            willDisplayEventHandled = false
        }

        describe(".init(heightCalculator: configuration: reuseId: eventsHadnler:)") {
            it("should return valid header") {
                let header = TableHeaderFooter<TableHeaderFooterViewMock>(
                    heightCalculator: heightCalculator,
                    configuration: expectedHeaderConfiguration,
                    reuseId: expectedReuseId,
                    eventsHandler: eventsHandler
                )

                checkHeader(header: header, viewType: TableHeaderFooterViewMock.self)
                checkHeaderHeightCalculator(header: header)
            }
        }

        describe(".init(item: heightCalculator: configuration: reuseId: eventsHadnler:)") {
            it("should return valid header") {
                let header = TableHeaderFooter<TableHeaderFooterViewMock>(
                    item: expectedViewModel,
                    heightCalculator: heightCalculator,
                    configuration: expectedHeaderConfiguration,
                    reuseId: expectedReuseId,
                    eventsHandler: eventsHandler
                )

                checkHeader(header: header, viewType: TableHeaderFooterViewMock.self)
                checkHeaderHeightCalculator(header: header)
                checkHeaderViewModel(header: header)
            }
        }

        describe(".init(item: configuration: reuseId: eventsHadnler:)") {
            it("should return valid header") {
                let header = TableHeaderFooter<TableHeaderFooterViewMock>(item: expectedViewModel, configuration: expectedHeaderConfiguration,
                                                  reuseId: expectedReuseId, eventsHandler: eventsHandler)

                checkHeader(header: header, viewType: TableHeaderFooterViewMock.self)
                checkHeaderViewModel(header: header)
                expect(header.heightCalculator.calculateHeight(with: tableView)).to(equal(TableHeaderFooterViewMock.defaultHeight))
                expect(header.heightCalculator.calculateEstimatedHeight(with: tableView)).to(equal(TableHeaderFooterViewMock.defaultEstimatedHeight))
            }

            it("should return valid header with void configuration") {
                let header = TableHeaderFooter<TableVoidHeaderFooterViewMock>(configuration: expectedHeaderConfiguration,
                                                                              reuseId: expectedReuseId, eventsHandler: eventsHandler)

                checkHeader(header: header, viewType: TableVoidHeaderFooterViewMock.self)
                expect(header.heightCalculator.calculateHeight(with: tableView)).to(equal(TableVoidHeaderFooterViewMock.defaultHeight))
                expect(header.heightCalculator.calculateEstimatedHeight(with: tableView))
                    .to(equal(TableVoidHeaderFooterViewMock.defaultEstimatedHeight))
            }
        }

        func checkHeaderViewModel(header: TableHeaderFooterProtocol) {
            let view = header.viewFactory.createView(for: tableView, with: 0)
            expect((view as? TableHeaderFooterViewMock)?.viewModel).to(beIdenticalTo(expectedViewModel))
        }

        func checkHeaderHeightCalculator(header: TableHeaderFooterProtocol) {
            expect(header.heightCalculator).to(beIdenticalTo(heightCalculator))
        }

        func checkHeader(header: TableHeaderFooterProtocol, viewType: UIView.Type) {
            let view = header.viewFactory.createView(for: tableView, with: 0)
            expect((view as? UITableViewHeaderFooterView)?.reuseIdentifier).to(equal(expectedReuseId))
            expect(view).to(beAKindOf(viewType))

            expect(header.configuration.title).to(equal(expectedTitle))

            header.eventsHandler.onEvent(event: .willDisplay(context:
                (table: tableView, view: UIView(), section: 0)))
            expect(willDisplayEventHandled).to(beTrue())
        }
    }
}

// swiftlint:enable function_body_length

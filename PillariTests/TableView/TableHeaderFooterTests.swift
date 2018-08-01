import Quickimport Nimble
@testable import Pillari

class TableHeaderFooterTests: QuickSpec {
    override func spec() {
        describe(".init") {
            it("should return valid header/footer") {
                let viewFactory = TableHeaderFooterFactory(UITableViewHeaderFooterView.self)
                let heightCalculator = TableElementHeightCalculator { _ in 0 }
                let title = "TestTitle"
                let configuration = TableHeaderFooterConfiguration(title: title)
                let eventsHandler = TableHeaderFooter.HeaderFooterEventsHandler()
                let headerFooter = TableHeaderFooter(
                    viewFactory: viewFactory,
                    heightCalculator: heightCalculator,
                    configuration: configuration,
                    eventsHandler: eventsHandler
                )

                expect(headerFooter.viewFactory).to(beIdenticalTo(viewFactory))
                expect(headerFooter.heightCalculator).to(beIdenticalTo(heightCalculator))
                expect(headerFooter.configuration.title).to(equal(title))
                expect(headerFooter.eventsHandler).to(beIdenticalTo(eventsHandler))
            }
        }
    }
}

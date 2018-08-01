//  Created by Anton Popkov on 26.09.17.

public final class TableHeaderFooter<TView: UITableViewHeaderFooterView>: TableHeaderFooterProtocol {
    public typealias HeaderFooterEventsHandler = EventsHandler<TableHeaderFooterEvent>

    public let heightCalculator: TableElementHeightCalculatorProtocol
    public let viewFactory: TableHeaderFooterFactoryProtocol
    public let eventsHandler: HeaderFooterEventsHandler
    public let configuration: TableHeaderFooterConfiguration

    public init(viewFactory: TableHeaderFooterFactoryProtocol,
                heightCalculator: TableElementHeightCalculatorProtocol,
                configuration: TableHeaderFooterConfiguration = .default,
                eventsHandler: HeaderFooterEventsHandler = HeaderFooterEventsHandler()) {

        self.viewFactory = viewFactory
        self.heightCalculator = heightCalculator
        self.configuration = configuration
        self.eventsHandler = eventsHandler
    }
}

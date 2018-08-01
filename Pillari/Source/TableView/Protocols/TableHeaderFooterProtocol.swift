//  Created by Anton Popkov on 29.09.17.

public protocol TableHeaderFooterProtocol {
    var heightCalculator: TableElementHeightCalculatorProtocol { get }

    var viewFactory: TableHeaderFooterFactoryProtocol { get }

    var eventsHandler: EventsHandler<TableHeaderFooterEvent> { get }

    var configuration: TableHeaderFooterConfiguration { get }
}

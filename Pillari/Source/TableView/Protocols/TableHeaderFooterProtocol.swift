public protocol TableHeaderFooterProtocol {
    var heightCalculator: TableElementHeightCalculatorProtocol { get }

    var viewFactory: TableHeaderFooterFactoryProtocol { get }

    var eventsHandler: EventsHandler<TableHeaderFooterEvent> { get }

    var configuration: TableHeaderFooterConfiguration { get }
}

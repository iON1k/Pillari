public protocol TableRowProtocol {
    var heightCalculator: TableElementHeightCalculatorProtocol { get }

    var cellFactory: TableCellFactoryProtocol { get }

    var eventsHandler: EventsHandler<TableRowEvent> { get }

    var configuration: TableRowConfiguration { get }
}

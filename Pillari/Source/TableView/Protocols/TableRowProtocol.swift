//  Created by Anton Popkov on 29.09.17.

/// Протокол для описания поведения ячейки в таблице

public protocol TableRowProtocol {
    var heightCalculator: TableElementHeightCalculatorProtocol { get }

    var cellFactory: TableCellFactoryProtocol { get }

    var eventsHandler: EventsHandler<TableRowEvent> { get }

    var configuration: TableRowConfiguration { get }
}

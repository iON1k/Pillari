//  Created by Anton Popkov on 26.09.17.

public final class TableRow<TCell: UITableViewCell>: TableRowProtocol {
    public typealias RowEventsHandler = EventsHandler<TableRowEvent>

    public let heightCalculator: TableElementHeightCalculatorProtocol
    public let cellFactory: TableCellFactoryProtocol
    public let eventsHandler: RowEventsHandler
    public let configuration: TableRowConfiguration

    public init(cellFactory: TableCellFactoryProtocol,
                heightCalculator: TableElementHeightCalculatorProtocol,
                configuration: TableRowConfiguration = .default,
                eventsHandler: RowEventsHandler = RowEventsHandler()) {

        self.cellFactory = cellFactory
        self.heightCalculator = heightCalculator
        self.configuration = configuration
        self.eventsHandler = eventsHandler
    }
}

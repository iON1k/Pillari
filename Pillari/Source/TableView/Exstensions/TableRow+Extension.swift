public extension TableRow where TCell: TableElementViewProtocol {
    convenience init(
        item: TCell.Configuration,
        configuration: TableRowConfiguration = .default,
        reuseId: String? = nil,
        eventsHandler: RowEventsHandler.Handler? = nil) {

        self.init(
            cellFactory: TableCellFactory(TCell.self, item: item, reuseId: reuseId),
            heightCalculator: TableElementHeightCalculator(TCell.self, item: item),
            configuration: configuration,
            eventsHandler: RowEventsHandler(handler: eventsHandler)
        )
    }
}

public extension TableRow where TCell: Configurable {
    convenience init(
        item: TCell.Configuration,
        heightCalculator: TableElementHeightCalculatorProtocol,
        configuration: TableRowConfiguration = .default,
        reuseId: String? = nil,
        eventsHandler: RowEventsHandler.Handler? = nil) {

        self.init(
            cellFactory: TableCellFactory(TCell.self, item: item, reuseId: reuseId),
            heightCalculator: heightCalculator,
            configuration: configuration,
            eventsHandler: RowEventsHandler(handler: eventsHandler)
        )
    }
}

public extension TableRow where TCell: HeightCalculator, TCell.Configuration == Void {
    convenience init(
        configuration: TableRowConfiguration = .default,
        reuseId: String? = nil,
        eventsHandler: RowEventsHandler.Handler? = nil) {

        self.init(
            cellFactory: TableCellFactory(TCell.self, reuseId: reuseId),
            heightCalculator: TableElementHeightCalculator(TCell.self, item: Void()),
            configuration: configuration,
            eventsHandler: RowEventsHandler(handler: eventsHandler)
        )
    }
}

public extension TableRow {
    convenience init(
        heightCalculator: TableElementHeightCalculatorProtocol,
        configuration: TableRowConfiguration = .default,
        reuseId: String? = nil,
        eventsHandler: RowEventsHandler.Handler? = nil) {

        self.init(
            cellFactory: TableCellFactory(TCell.self, reuseId: reuseId),
            heightCalculator: heightCalculator,
            configuration: configuration,
            eventsHandler: RowEventsHandler(handler: eventsHandler)
        )
    }
}

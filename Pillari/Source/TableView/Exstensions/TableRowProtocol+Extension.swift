public extension TableRowProtocol {
    func withAction(_ eventsHandler: @escaping EventsHandler<TableRowEvent>.Handler) -> TableRowProtocol {
        return TableRow<UITableViewCell>(
            cellFactory: cellFactory,
            heightCalculator: heightCalculator,
            configuration: configuration,
            eventsHandler: EventsHandler { event in
                self.eventsHandler.onEvent(event: event)
                eventsHandler(event)
            }
        )
    }
}

//  Created by Anton Popkov on 27.10.17.

public extension CollectionRow where TCell: Configurable {
    convenience init(item: TCell.Configuration,
                     configuration: CollectionRowConfiguration = .default,
                     reuseId: String? = nil,
                     eventsHandler: RowEventsHandler.Handler? = nil) {

        self.init(
            cellFactory: CollectionCellFactory(TCell.self, item: item, reuseId: reuseId),
            configuration: configuration,
            eventsHandler: RowEventsHandler(handler: eventsHandler)
        )
    }
}

public extension CollectionRow {
    convenience init(
        configuration: CollectionRowConfiguration = .default,
        reuseId: String? = nil,
        eventsHandler: RowEventsHandler.Handler? = nil) {

        self.init(
            cellFactory: CollectionCellFactory(TCell.self, reuseId: reuseId),
            configuration: configuration,
            eventsHandler: RowEventsHandler(handler: eventsHandler)
        )
    }
}

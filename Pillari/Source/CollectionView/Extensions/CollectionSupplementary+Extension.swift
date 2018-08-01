//  Created by Anton Popkov on 27.10.17.

public extension CollectionSupplementary where TView: Configurable {
    convenience init(item: TView.Configuration,
                     reuseId: String? = nil,
                     eventsHandler: SupplementaryEventsHandler.Handler? = nil) {

        self.init(
            viewFactory: CollectionSupplementaryFactory(TView.self, item: item, reuseId: reuseId),
            eventsHandler: SupplementaryEventsHandler(handler: eventsHandler)
        )
    }
}

public extension CollectionSupplementary {
    convenience init(reuseId: String? = nil,
                     eventsHandler: SupplementaryEventsHandler.Handler? = nil) {

        self.init(
            viewFactory: CollectionSupplementaryFactory(TView.self, reuseId: reuseId),
            eventsHandler: SupplementaryEventsHandler(handler: eventsHandler)
        )
    }
}

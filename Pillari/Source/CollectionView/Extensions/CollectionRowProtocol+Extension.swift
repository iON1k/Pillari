public extension CollectionRowProtocol {
    func withAction(_ eventsHandler: @escaping EventsHandler<CollectionRowEvent>.Handler) -> CollectionRowProtocol {
        return CollectionRow<UICollectionViewCell>(
            cellFactory: cellFactory,
            configuration: configuration,
            eventsHandler: EventsHandler { event in
                self.eventsHandler.onEvent(event: event)
                eventsHandler(event)
            }
        )
    }
}

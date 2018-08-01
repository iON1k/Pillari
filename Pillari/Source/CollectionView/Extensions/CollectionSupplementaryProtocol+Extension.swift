public extension CollectionSupplementaryProtocol {
    func withAction(_ eventsHandler: @escaping EventsHandler<CollectionSupplementaryEvent>.Handler) -> CollectionSupplementaryProtocol {
        return CollectionSupplementary<UICollectionReusableView>(
            viewFactory: viewFactory,
            eventsHandler: EventsHandler { event in
                self.eventsHandler.onEvent(event: event)
                eventsHandler(event)
            }
        )
    }
}

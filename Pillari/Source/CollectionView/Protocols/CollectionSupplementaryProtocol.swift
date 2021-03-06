public protocol CollectionSupplementaryProtocol {
    var viewFactory: CollectionSupplementaryFactoryProtocol { get }

    var eventsHandler: EventsHandler<CollectionSupplementaryEvent> { get }
}

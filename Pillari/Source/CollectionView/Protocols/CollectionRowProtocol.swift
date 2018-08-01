public protocol CollectionRowProtocol {
    var cellFactory: CollectionCellFactoryProtocol { get }

    var eventsHandler: EventsHandler<CollectionRowEvent> { get }

    var configuration: CollectionRowConfiguration { get }
}

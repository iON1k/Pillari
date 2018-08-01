//  Created by Anton Popkov on 23.10.17.

public protocol CollectionRowProtocol {
    var cellFactory: CollectionCellFactoryProtocol { get }

    var eventsHandler: EventsHandler<CollectionRowEvent> { get }

    var configuration: CollectionRowConfiguration { get }
}

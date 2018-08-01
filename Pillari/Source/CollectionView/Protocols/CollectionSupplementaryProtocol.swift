//  Created by Anton Popkov on 24.10.17.

public protocol CollectionSupplementaryProtocol {
    var viewFactory: CollectionSupplementaryFactoryProtocol { get }

    var eventsHandler: EventsHandler<CollectionSupplementaryEvent> { get }
}

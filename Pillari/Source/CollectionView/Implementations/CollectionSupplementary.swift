//  Created by Anton Popkov on 24.10.17.

public final class CollectionSupplementary<TView: UICollectionReusableView>: CollectionSupplementaryProtocol {
    public typealias SupplementaryEventsHandler = EventsHandler<CollectionSupplementaryEvent>

    public let viewFactory: CollectionSupplementaryFactoryProtocol
    public let eventsHandler: SupplementaryEventsHandler

    public init(viewFactory: CollectionSupplementaryFactoryProtocol,
                eventsHandler: SupplementaryEventsHandler = SupplementaryEventsHandler()) {

        self.viewFactory = viewFactory
        self.eventsHandler = eventsHandler
    }
}

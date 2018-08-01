//  Created by Anton Popkov on 24.10.17.

public final class CollectionRow<TCell: UICollectionViewCell>: CollectionRowProtocol {
    public typealias RowEventsHandler = EventsHandler<CollectionRowEvent>

    public let cellFactory: CollectionCellFactoryProtocol
    public let eventsHandler: RowEventsHandler
    public let configuration: CollectionRowConfiguration

    public init(cellFactory: CollectionCellFactoryProtocol,
                configuration: CollectionRowConfiguration = .default,
                eventsHandler: RowEventsHandler = RowEventsHandler()) {

        self.cellFactory = cellFactory
        self.eventsHandler = eventsHandler
        self.configuration = configuration
    }
}

public extension CollectionRowProtocol {
    func with(action: @escaping EventsHandler<CollectionRowEvent>.Handler) -> CollectionRowProtocol {
        return CollectionRow<UICollectionViewCell>(
            cellFactory: cellFactory,
            configuration: configuration,
            eventsHandler: EventsHandler { event in
                self.eventsHandler.onEvent(event: event)
                action(event)
            }
        )
    }

    func withDidSelect(action: @escaping (CollectionRowEvent.Context) -> Void) -> CollectionRowProtocol {
        return with { event in
            guard case let .didSelect(context) = event else {
                return
            }

            action(context)
        }
    }

    func withDidDeselect(action: @escaping (CollectionRowEvent.Context) -> Void) -> CollectionRowProtocol {
        return with { event in
            guard case let .didDeselect(context) = event else {
                return
            }

            action(context)
        }
    }

    func withDidConfigure(action: @escaping (CollectionRowEvent.CellContext) -> Void) -> CollectionRowProtocol {
        return with { event in
            guard case let .didConfigure(context) = event else {
                return
            }

            action(context)
        }
    }

    func withWillDisplay(action: @escaping (CollectionRowEvent.CellContext) -> Void) -> CollectionRowProtocol {
        return with { event in
            guard case let .willDisplay(context) = event else {
                return
            }

            action(context)
        }
    }

    func withDidEndDisplaying(action: @escaping (CollectionRowEvent.CellContext) -> Void) -> CollectionRowProtocol {
        return with { event in
            guard case let .didEndDisplaying(context) = event else {
                return
            }

            action(context)
        }
    }

    func withMove(action: @escaping (CollectionRowEvent.MoveContext) -> Void) -> CollectionRowProtocol {
        return with { event in
            guard case let .move(context) = event else {
                return
            }

            action(context)
        }
    }
}

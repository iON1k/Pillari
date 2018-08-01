public extension CollectionSupplementaryProtocol {
    func with(action: @escaping EventsHandler<CollectionSupplementaryEvent>.Handler) -> CollectionSupplementaryProtocol {
        return CollectionSupplementary<UICollectionReusableView>(
            viewFactory: viewFactory,
            eventsHandler: EventsHandler { event in
                self.eventsHandler.onEvent(event: event)
                action(event)
            }
        )
    }

    func withDidConfigure(action: @escaping (CollectionSupplementaryEvent.Context) -> Void) -> CollectionSupplementaryProtocol {
        return with { event in
            guard case let .didConfigure(context) = event else {
                return
            }

            action(context)
        }
    }

    func withWillDisplay(action: @escaping (CollectionSupplementaryEvent.Context) -> Void) -> CollectionSupplementaryProtocol {
        return with { event in
            guard case let .willDisplay(context) = event else {
                return
            }

            action(context)
        }
    }

    func withDidEndDisplaying(action: @escaping (CollectionSupplementaryEvent.Context) -> Void) -> CollectionSupplementaryProtocol {
        return with { event in
            guard case let .didEndDisplaying(context) = event else {
                return
            }

            action(context)
        }
    }
}

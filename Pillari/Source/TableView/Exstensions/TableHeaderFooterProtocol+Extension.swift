public extension TableHeaderFooterProtocol {
    func with(action: @escaping EventsHandler<TableHeaderFooterEvent>.Handler) -> TableHeaderFooterProtocol {
        return TableHeaderFooter<UITableViewHeaderFooterView>(
            viewFactory: viewFactory,
            heightCalculator: heightCalculator,
            configuration: configuration,
            eventsHandler: EventsHandler { event in
                self.eventsHandler.onEvent(event: event)
                action(event)
            }
        )
    }

    func withDidConfigure(action: @escaping (TableHeaderFooterEvent.Context) -> Void) -> TableHeaderFooterProtocol {
        return with { event in
            guard case let .didConfigure(context) = event else {
                return
            }

            action(context)
        }
    }

    func withWillDisplay(action: @escaping (TableHeaderFooterEvent.Context) -> Void) -> TableHeaderFooterProtocol {
        return with { event in
            guard case let .willDisplay(context) = event else {
                return
            }

            action(context)
        }
    }

    func withDidEndDisplaying(action: @escaping (TableHeaderFooterEvent.Context) -> Void) -> TableHeaderFooterProtocol {
        return with { event in
            guard case let .didEndDisplaying(context) = event else {
                return
            }

            action(context)
        }
    }
}

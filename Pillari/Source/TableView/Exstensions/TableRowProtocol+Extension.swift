public extension TableRowProtocol {
    func with(action: @escaping EventsHandler<TableRowEvent>.Handler) -> TableRowProtocol {
        return TableRow<UITableViewCell>(
            cellFactory: cellFactory,
            heightCalculator: heightCalculator,
            configuration: configuration,
            eventsHandler: EventsHandler { event in
                self.eventsHandler.onEvent(event: event)
                action(event)
            }
        )
    }

    func withDidSelect(action: @escaping (TableRowEvent.Context) -> Void) -> TableRowProtocol {
        return with { event in
            guard case let .didSelect(context) = event else {
                return
            }

            action(context)
        }
    }

    func withDidDeselect(action: @escaping (TableRowEvent.Context) -> Void) -> TableRowProtocol {
        return with { event in
            guard case let .didDeselect(context) = event else {
                return
            }

            action(context)
        }
    }

    func withDidConfigure(action: @escaping (TableRowEvent.CellContext) -> Void) -> TableRowProtocol {
        return with { event in
            guard case let .didConfigure(context) = event else {
                return
            }

            action(context)
        }
    }

    func withWillDisplay(action: @escaping (TableRowEvent.CellContext) -> Void) -> TableRowProtocol {
        return with { event in
            guard case let .willDisplay(context) = event else {
                return
            }

            action(context)
        }
    }

    func withDidEndDisplaying(action: @escaping (TableRowEvent.CellContext) -> Void) -> TableRowProtocol {
        return with { event in
            guard case let .didEndDisplaying(context) = event else {
                return
            }

            action(context)
        }
    }

    func withMove(action: @escaping (TableRowEvent.MoveContext) -> Void) -> TableRowProtocol {
        return with { event in
            guard case let .move(context) = event else {
                return
            }

            action(context)
        }
    }
}

public extension TableHeaderFooter where TView: TableElementViewProtocol {
    convenience init(
        item: TView.Configuration,
        configuration: TableHeaderFooterConfiguration = .default,
        reuseId: String? = nil,
        eventsHandler: HeaderFooterEventsHandler.Handler? = nil) {

        self.init(
            viewFactory: TableHeaderFooterFactory(TView.self, item: item, reuseId: reuseId),
            heightCalculator: TableElementHeightCalculator(TView.self, item: item),
            configuration: configuration,
            eventsHandler: HeaderFooterEventsHandler(handler: eventsHandler)
        )
    }
}

public extension TableHeaderFooter where TView: Configurable {
    convenience init(
        item: TView.Configuration,
        heightCalculator: TableElementHeightCalculatorProtocol,
        configuration: TableHeaderFooterConfiguration = .default,
        reuseId: String? = nil,
        eventsHandler: HeaderFooterEventsHandler.Handler? = nil) {

        self.init(
            viewFactory: TableHeaderFooterFactory(TView.self, item: item, reuseId: reuseId),
            heightCalculator: heightCalculator,
            configuration: configuration,
            eventsHandler: HeaderFooterEventsHandler(handler: eventsHandler)
        )
    }
}

public extension TableHeaderFooter where TView: HeightCalculator, TView.Configuration == Void {
    convenience init(
        configuration: TableHeaderFooterConfiguration = .default,
        reuseId: String? = nil,
        eventsHandler: HeaderFooterEventsHandler.Handler? = nil) {

        self.init(
            viewFactory: TableHeaderFooterFactory(TView.self, reuseId: reuseId),
            heightCalculator: TableElementHeightCalculator(TView.self, item: Void()),
            configuration: configuration,
            eventsHandler: HeaderFooterEventsHandler(handler: eventsHandler)
        )
    }
}

public extension TableHeaderFooter {
    convenience init(
        heightCalculator: TableElementHeightCalculatorProtocol,
        configuration: TableHeaderFooterConfiguration = .default,
        reuseId: String? = nil,
        eventsHandler: HeaderFooterEventsHandler.Handler? = nil) {

        self.init(
            viewFactory: TableHeaderFooterFactory(TView.self, reuseId: reuseId),
            heightCalculator: heightCalculator,
            configuration: configuration,
            eventsHandler: HeaderFooterEventsHandler(handler: eventsHandler)
        )
    }
}

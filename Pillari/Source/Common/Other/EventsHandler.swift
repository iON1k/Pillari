public final class EventsHandler<TEvent> {
    public typealias Handler = (TEvent) -> Void

    private let handler: Handler?

    public func onEvent(event: TEvent) {
        handler?(event)
    }

    public init(handler: Handler? = nil) {
        self.handler = handler
    }
}

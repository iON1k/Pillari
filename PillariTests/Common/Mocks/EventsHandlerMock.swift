class EventsHandlerMock<TEvent> {
    var events: [TEvent] = []

    func onEvent(event: TEvent) {
        events.append(event)
    }

    func resetEvents() {
        events = []
    }
}

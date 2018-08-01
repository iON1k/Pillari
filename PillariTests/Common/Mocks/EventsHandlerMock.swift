//  Created by Anton Popkov on 10.11.17.

class EventsHandlerMock<TEvent> {
    var events: [TEvent] = []

    func onEvent(event: TEvent) {
        events.append(event)
    }

    func resetEvents() {
        events = []
    }
}

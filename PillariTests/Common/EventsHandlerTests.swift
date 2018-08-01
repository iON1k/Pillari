//  Created by Anton Popkov on 02.10.17.

import Quick
import Nimble

@testable import Pillari

class EventsHandlerTests: QuickSpec {
    override func spec() {
        describe(".onEvent(event:)") {
            it("should handle actions") {
                var handledEvents: [EventMock] = []
                let eventsHandler = EventsHandler<EventMock> { event in
                    handledEvents.append(event)
                }

                for event in EventMock.allValues {
                    eventsHandler.onEvent(event: event)
                }

                expect(handledEvents).to(equal(EventMock.allValues))
            }
        }
    }

    enum EventMock {
        case event1
        case event2
        case event3
        case event4
        case event5

        static let allValues = [event1, event2, event3, event4, event5]
    }
}

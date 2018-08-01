//  Created by Anton Popkov on 10.11.17.

import Nimble

func expectOnlyOneEvent<TEvent>(_ events: [TEvent]) -> TEvent? {
    expect(events.count).to(equal(1))
    return events.first
}

func expectNoEvents<TEvent>(_ events: [TEvent]) {
    expect(events).to(beEmpty())
}

func expectToIdential<TElement>(_ source: [TElement]?, to other: [TElement]?) {
    guard let other = other else {
        expect(source).to(beNil())
        return
    }

    expect(source?.count).to(equal(other.count))
    for (index, element) in other.enumerated() {
        expect(source?[index]).to(beIdenticalTo(element))
    }
}

import Quick
import Nimble
@testable import Pillari

// swiftlint:disable function_body_length
// swiftlint:disable type_name

class CollectionSupplementaryProtocolExtensionTests: QuickSpec {
    override func spec() {
        let expectedCollectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
        let expectedIndexPath = IndexPath(row: 3, section: 0)
        let expectedKind = "Test"
        let expectedViewFactory = CollectionSupplementaryFactory(CollectionSupplementaryViewMock.self)
        let expectedView = UICollectionReusableView()

        var eventsHandler: EventsHandlerMock<CollectionSupplementaryEvent>!
        var expectedSupplementary: CollectionSupplementaryProtocol!

        beforeEach {
            eventsHandler = EventsHandlerMock()
            expectedSupplementary = CollectionSupplementary(viewFactory: expectedViewFactory,
                                                            eventsHandler: .init(handler: eventsHandler.onEvent))
        }

        describe(".with(action:)") {
            it("should send didSelect event") {
                let newSupplementaryEventsHandler = EventsHandlerMock<CollectionSupplementaryEvent>()
                let newSupplementary = expectedSupplementary.with(action: newSupplementaryEventsHandler.onEvent)
                expectSupplementaryHasValidData(newSupplementary)

                newSupplementary.eventsHandler.onEvent(event: .didConfigure(context: (collection: expectedCollectionView,
                                                                                      view: expectedView,
                                                                                      kind: expectedKind,
                                                                                      index: expectedIndexPath)))

                if case .didConfigure(let context)? = expectOnlyOneEvent(eventsHandler.events) {
                    expect(context.collection).to(beIdenticalTo(expectedCollectionView))
                    expect(context.view).to(beIdenticalTo(expectedView))
                    expect(context.index).to(equal(expectedIndexPath))
                } else {
                    XCTAssert(false, "Original Supplementary event no sends")
                    return
                }

                if case .didConfigure(let context)? = expectOnlyOneEvent(newSupplementaryEventsHandler.events) {
                    expect(context.collection).to(beIdenticalTo(expectedCollectionView))
                    expect(context.view).to(beIdenticalTo(expectedView))
                    expect(context.index).to(equal(expectedIndexPath))
                } else {
                    XCTAssert(false, "New Supplementary event no sends")
                    return
                }
            }
        }

        describe(".withWillDisplay(action:)") {
            it("should send willDisplay event") {
                let newSupplementaryEventsHandler = EventsHandlerMock<CollectionSupplementaryEvent.Context>()
                let newSupplementary = expectedSupplementary.withWillDisplay(action: newSupplementaryEventsHandler.onEvent)
                expectSupplementaryHasValidData(newSupplementary)

                newSupplementary.eventsHandler.onEvent(event: .willDisplay(context: (collection: expectedCollectionView,
                                                                                     view: expectedView,
                                                                                     kind: expectedKind,
                                                                                     index: expectedIndexPath)))

                if let context = expectOnlyOneEvent(newSupplementaryEventsHandler.events) {
                    expect(context.collection).to(beIdenticalTo(expectedCollectionView))
                    expect(context.view).to(beIdenticalTo(expectedView))
                    expect(context.index).to(equal(expectedIndexPath))
                } else {
                    XCTAssert(false, "New row event no sends")
                    return
                }
            }

            it("should not send any event") {
                let newSupplementaryEventsHandler = EventsHandlerMock<CollectionSupplementaryEvent.Context>()
                let newSupplementary = expectedSupplementary.withWillDisplay(action: newSupplementaryEventsHandler.onEvent)
                newSupplementary.eventsHandler.onEvent(event: .didConfigure(context: (collection: expectedCollectionView,
                                                                                      view: expectedView,
                                                                                      kind: expectedKind,
                                                                                      index: expectedIndexPath)))
                expectNoEvents(newSupplementaryEventsHandler.events)
            }
        }

        describe(".withDidEndDisplaying(action:)") {
            it("should send didEndDisplaying event") {
                let newSupplementaryEventsHandler = EventsHandlerMock<CollectionSupplementaryEvent.Context>()
                let newSupplementary = expectedSupplementary.withDidEndDisplaying(action: newSupplementaryEventsHandler.onEvent)
                expectSupplementaryHasValidData(newSupplementary)

                newSupplementary.eventsHandler.onEvent(event: .didEndDisplaying(context: (collection: expectedCollectionView,
                                                                                          view: expectedView,
                                                                                          kind: expectedKind,
                                                                                          index: expectedIndexPath)))

                if let context = expectOnlyOneEvent(newSupplementaryEventsHandler.events) {
                    expect(context.collection).to(beIdenticalTo(expectedCollectionView))
                    expect(context.view).to(beIdenticalTo(expectedView))
                    expect(context.index).to(equal(expectedIndexPath))
                } else {
                    XCTAssert(false, "New row event no sends")
                    return
                }
            }

            it("should not send any event") {
                let newSupplementaryEventsHandler = EventsHandlerMock<CollectionSupplementaryEvent.Context>()
                let newSupplementary = expectedSupplementary.withDidEndDisplaying(action: newSupplementaryEventsHandler.onEvent)
                newSupplementary.eventsHandler.onEvent(event: .didConfigure(context: (collection: expectedCollectionView,
                                                                                      view: expectedView,
                                                                                      kind: expectedKind,
                                                                                      index: expectedIndexPath)))
                expectNoEvents(newSupplementaryEventsHandler.events)
            }
        }

        describe(".withDidConfigure(action:)") {
            it("should send didConfigure event") {
                let newSupplementaryEventsHandler = EventsHandlerMock<CollectionSupplementaryEvent.Context>()
                let newSupplementary = expectedSupplementary.withDidConfigure(action: newSupplementaryEventsHandler.onEvent)
                expectSupplementaryHasValidData(newSupplementary)

                newSupplementary.eventsHandler.onEvent(event: .didConfigure(context: (collection: expectedCollectionView,
                                                                                      view: expectedView,
                                                                                      kind: expectedKind,
                                                                                      index: expectedIndexPath)))

                if let context = expectOnlyOneEvent(newSupplementaryEventsHandler.events) {
                    expect(context.collection).to(beIdenticalTo(expectedCollectionView))
                    expect(context.view).to(beIdenticalTo(expectedView))
                    expect(context.index).to(equal(expectedIndexPath))
                } else {
                    XCTAssert(false, "New row event no sends")
                    return
                }
            }

            it("should not send any event") {
                let newSupplementaryEventsHandler = EventsHandlerMock<CollectionSupplementaryEvent.Context>()
                let newSupplementary = expectedSupplementary.withDidConfigure(action: newSupplementaryEventsHandler.onEvent)
                newSupplementary.eventsHandler.onEvent(event: .willDisplay(context: (collection: expectedCollectionView,
                                                                                     view: expectedView,
                                                                                     kind: expectedKind,
                                                                                     index: expectedIndexPath)))
                expectNoEvents(newSupplementaryEventsHandler.events)
            }
        }

        func expectSupplementaryHasValidData(_ supplementary: CollectionSupplementaryProtocol) {
            expect(supplementary.viewFactory).to(beIdenticalTo(expectedSupplementary.viewFactory))
        }
    }
}

// swiftlint:enable type_name
// swiftlint:enable function_body_length

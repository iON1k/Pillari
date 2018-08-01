import Quickimport Nimble
@testable import Pillari

// swiftlint:disable type_name
// swiftlint:disable function_body_length

class UICollectionViewDelegateImplementationEventsTests: QuickSpec {
    override func spec() {
        let layout = UICollectionViewFlowLayout()
        let expectedCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        let expectedCell = UICollectionViewCell()
        let expectedSupplementaryView = UICollectionReusableView()
        let expectedIndexPath = IndexPath(row: 3, section: 0)
        let expectedSupplementaryIndexPath = IndexPath(row: 0, section: 2)
        var collectionDelegate: UICollectionViewDelegate!
        var rowEventsHandler: EventsHandlerMock<CollectionRowEvent>!
        var supplementaryEventsHandler: EventsHandlerMock<CollectionSupplementaryEvent>!

        beforeEach {
            rowEventsHandler = EventsHandlerMock()
            supplementaryEventsHandler = EventsHandlerMock()

            let row = CollectionRow<CollectionVoidCellMock>(eventsHandler: rowEventsHandler.onEvent).withFlowLayout()
            let supplementary = CollectionSupplementary<CollectionVoidSupplementaryViewMock>(
                eventsHandler: supplementaryEventsHandler.onEvent
            ).withFlowLayout()

            let section = Array(repeating: row, count: 5).asFlowLayoutSection(header: supplementary)
            let dataSource = Array(repeating: section, count: 5).asCollectionFlowLayoutDataProvider(layout: layout)

            collectionDelegate = UICollectionViewDelegateImplementation(dataSource: dataSource)
        }

        describe(".didHighlightItemAt") {
            it("should send didHighlight event") {
                collectionDelegate.collectionView?(expectedCollectionView, didHighlightItemAt: expectedIndexPath)
                expectNoEvents(supplementaryEventsHandler.events)
                let event = expectOnlyOneEvent(rowEventsHandler.events)
                guard case .didHighlight(let context)? = event else {
                    XCTAssert(false, "Event no sends")
                    return
                }

                expect(context.collection).to(beIdenticalTo(expectedCollectionView))
                expect(context.index).to(equal(expectedIndexPath))
            }
        }

        describe(".didUnhighlightItemAt") {
            it("should send didUnhighlight event") {
                collectionDelegate.collectionView?(expectedCollectionView, didUnhighlightItemAt: expectedIndexPath)
                expectNoEvents(supplementaryEventsHandler.events)
                let event = expectOnlyOneEvent(rowEventsHandler.events)
                guard case .didUnhighlight(let context)? = event else {
                    XCTAssert(false, "Event no sends")
                    return
                }

                expect(context.collection).to(beIdenticalTo(expectedCollectionView))
                expect(context.index).to(equal(expectedIndexPath))
            }
        }

        describe(".didSelectItemAt") {
            it("should send didSelect event") {
                collectionDelegate.collectionView?(expectedCollectionView, didSelectItemAt: expectedIndexPath)
                expectNoEvents(supplementaryEventsHandler.events)
                let event = expectOnlyOneEvent(rowEventsHandler.events)
                guard case .didSelect(let context)? = event else {
                    XCTAssert(false, "Event no sends")
                    return
                }

                expect(context.collection).to(beIdenticalTo(expectedCollectionView))
                expect(context.index).to(equal(expectedIndexPath))
            }
        }

        describe(".didDeselectItemAt") {
            it("should send didDeselect event") {
                collectionDelegate.collectionView?(expectedCollectionView, didDeselectItemAt: expectedIndexPath)
                expectNoEvents(supplementaryEventsHandler.events)
                let event = expectOnlyOneEvent(rowEventsHandler.events)
                guard case .didDeselect(let context)? = event else {
                    XCTAssert(false, "Event no sends")
                    return
                }

                expect(context.collection).to(beIdenticalTo(expectedCollectionView))
                expect(context.index).to(equal(expectedIndexPath))
            }
        }

        describe(".willDisplayCell") {
            it("should send willDisplayCell event") {
                collectionDelegate.collectionView?(expectedCollectionView, willDisplay: expectedCell, forItemAt: expectedIndexPath)
                expectNoEvents(supplementaryEventsHandler.events)
                let event = expectOnlyOneEvent(rowEventsHandler.events)
                guard case .willDisplay(let context)? = event else {
                    XCTAssert(false, "Event no sends")
                    return
                }

                expect(context.collection).to(beIdenticalTo(expectedCollectionView))
                expect(context.cell).to(beIdenticalTo(expectedCell))
                expect(context.index).to(equal(expectedIndexPath))
            }
        }

        describe(".didEndDisplayingCell") {
            it("should send didEndDisplayingCell event") {
                collectionDelegate.collectionView?(expectedCollectionView, didEndDisplaying: expectedCell, forItemAt: expectedIndexPath)
                expectNoEvents(supplementaryEventsHandler.events)
                let event = expectOnlyOneEvent(rowEventsHandler.events)
                guard case .didEndDisplaying(let context)? = event else {
                    XCTAssert(false, "Event no sends")
                    return
                }

                expect(context.collection).to(beIdenticalTo(expectedCollectionView))
                expect(context.cell).to(beIdenticalTo(expectedCell))
                expect(context.index).to(equal(expectedIndexPath))
            }
        }

        describe(".willDisplaySupplementaryView") {
            it("should send willDisplay event") {
                collectionDelegate.collectionView?(
                    expectedCollectionView,
                    willDisplaySupplementaryView: expectedSupplementaryView,
                    forElementKind: UICollectionElementKindSectionHeader,
                    at: expectedSupplementaryIndexPath
                )

                expectNoEvents(rowEventsHandler.events)
                let event = expectOnlyOneEvent(supplementaryEventsHandler.events)
                guard case .willDisplay(let context)? = event else {
                    XCTAssert(false, "Event no sends")
                    return
                }

                expect(context.collection).to(beIdenticalTo(expectedCollectionView))
                expect(context.view).to(beIdenticalTo(expectedSupplementaryView))
                expect(context.kind).to(equal(UICollectionElementKindSectionHeader))
                expect(context.index).to(equal(expectedSupplementaryIndexPath))
            }
        }

        describe(".didEndDisplayingSupplementaryView") {
            it("should send didEndDisplaying event") {
                collectionDelegate.collectionView?(
                    expectedCollectionView,
                    didEndDisplayingSupplementaryView: expectedSupplementaryView,
                    forElementOfKind: UICollectionElementKindSectionHeader,
                    at: expectedSupplementaryIndexPath
                )

                expectNoEvents(rowEventsHandler.events)
                let event = expectOnlyOneEvent(supplementaryEventsHandler.events)
                guard case .didEndDisplaying(let context)? = event else {
                    XCTAssert(false, "Event no sends")
                    return
                }

                expect(context.collection).to(beIdenticalTo(expectedCollectionView))
                expect(context.view).to(beIdenticalTo(expectedSupplementaryView))
                expect(context.kind).to(equal(UICollectionElementKindSectionHeader))
                expect(context.index).to(equal(expectedSupplementaryIndexPath))
            }
        }

        describe(".performAction") {
            it("should send performAction event") {
                let expectedAction = #selector(UICollectionViewDelegate.collectionView(_:canFocusItemAt:))
                collectionDelegate.collectionView?(
                    expectedCollectionView,
                    performAction: expectedAction,
                    forItemAt: expectedIndexPath,
                    withSender: self
                )
                expectNoEvents(supplementaryEventsHandler.events)
                let event = expectOnlyOneEvent(rowEventsHandler.events)
                guard case .performAction(let context)? = event else {
                    XCTAssert(false, "Event no sends")
                    return
                }

                expect(context.collection).to(beIdenticalTo(expectedCollectionView))
                expect(context.action).to(equal(expectedAction))
                expect(context.index).to(equal(expectedIndexPath))
                expect(context.sender).to(beIdenticalTo(self))
            }
        }
    }
}

// swiftlint:enable type_name
// swiftlint:enable function_body_length

import Quickimport Nimble
@testable import Pillari

// swiftlint:disable type_name

class UICollectionViewDataSourceImplementationEventsTests: QuickSpec {
    override func spec() {
        let layout = UICollectionViewFlowLayout()
        let expectedCollectionView = UICollectionViewMock(frame: .zero, collectionViewLayout: layout)
        let expectedIndexPath = IndexPath(row: 3, section: 0)
        var collectionDataSource: UICollectionViewDataSource!
        var eventsHandler: EventsHandlerMock<CollectionRowEvent>!

        beforeEach {
            eventsHandler = EventsHandlerMock()

            let row = CollectionRow<CollectionVoidCellMock>(eventsHandler: eventsHandler.onEvent).withFlowLayout()
            let dataProvider = Array(
                repeating: row,
                count: 5
            )
            .asFlowLayoutSections()
            .asCollectionFlowLayoutDataProvider(layout: layout)

            collectionDataSource = UICollectionViewDataSourceImplementation(dataSource: dataProvider)
        }

        describe(".cellForItemAt") {
            it("should send didConfigure event") {
                let expectedCell = collectionDataSource.collectionView(expectedCollectionView, cellForItemAt: expectedIndexPath)
                let event = expectOnlyOneEvent(eventsHandler.events)
                guard case .didConfigure(let context)? = event else {
                    XCTAssert(false, "Event no sends")
                    return
                }

                expect(context.collection).to(beIdenticalTo(expectedCollectionView))
                expect(context.cell).to(beIdenticalTo(expectedCell))
                expect(context.index).to(equal(expectedIndexPath))
            }
        }

        describe(".moveItemAt") {
            it("should send move event") {
                let expectedDestIndexPath = IndexPath(row: 3, section: 4)
                collectionDataSource.collectionView?(expectedCollectionView, moveItemAt: expectedIndexPath, to: expectedDestIndexPath)

                let event = expectOnlyOneEvent(eventsHandler.events)
                guard case .move(let context)? = event else {
                    XCTAssert(false, "Event no sends")
                    return
                }

                expect(context.collection).to(beIdenticalTo(expectedCollectionView))
                expect(context.sourceIndex).to(equal(expectedIndexPath))
                expect(context.destinationIndex).to(equal(expectedDestIndexPath))
            }
        }
    }
}

// swiftlint:enable type_name

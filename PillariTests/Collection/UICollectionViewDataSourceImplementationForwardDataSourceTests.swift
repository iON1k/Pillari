//  Created by Anton Popkov on 27.11.2017.

import Quick
import Nimble

@testable import Pillari

// swiftlint:disable function_body_length
// swiftlint:disable type_name

class UICollectionViewDataSourceImplementationForwardDataSourceTests: QuickSpec {
    override func spec() {
        let layout = UICollectionViewFlowLayout()
        let expectedCollectionView = UICollectionViewMock(frame: .zero, collectionViewLayout: layout)
        let expectedSection = 0
        let expectedSupplementaryKind = "TestKind"
        let expectedIndexPath = IndexPath(row: 3, section: 0)
        var collectionDataSource: UICollectionViewDataSource!
        var forwardCollectionDataSourceMock: UICollectionViewDataSourceMock!

        beforeEach {
            let dataProvider = Array(
                repeating: CollectionRow<CollectionVoidCellMock>().withFlowLayout(),
                count: 5
                )
                .asFlowLayoutSections()
                .asCollectionFlowLayoutDataProvider(layout: layout)

            let collectionDataSourceImpl = UICollectionViewDataSourceImplementation(dataSource: dataProvider)
            forwardCollectionDataSourceMock = UICollectionViewDataSourceMock()
            collectionDataSourceImpl.forwardDataSource = forwardCollectionDataSourceMock
            collectionDataSource = collectionDataSourceImpl
        }

        describe(".forwardDataSource") {
            it("should equals to expected value") {
                expect((collectionDataSource as? UICollectionViewDataSourceImplementation)?.forwardDataSource)
                    .to(beIdenticalTo(forwardCollectionDataSourceMock))
            }

            it("should to be nil") {
                let collectionDataSourceImpl = collectionDataSource as? UICollectionViewDataSourceImplementation
                collectionDataSourceImpl?.forwardDataSource = UICollectionViewDataSourceMock()
                expect(collectionDataSourceImpl?.forwardDataSource).to(beNil())
            }
        }

        describe(".numberOfItemsInSection") {
            it("should not call forward data source method") {
                _ = collectionDataSource.collectionView(expectedCollectionView, numberOfItemsInSection: expectedSection)
                expect(forwardCollectionDataSourceMock.events).to(beEmpty())
            }
        }

        describe(".cellForItemAt") {
            it("should not call forward data source method") {
                _ = collectionDataSource.collectionView(expectedCollectionView, cellForItemAt: expectedIndexPath)
                expect(forwardCollectionDataSourceMock.events).to(beEmpty())
            }
        }

        describe(".numberOfSections") {
            it("should call forward data source method") {
                let numberOfSections = collectionDataSource.numberOfSections?(in: expectedCollectionView)
                expect(numberOfSections).to(equal(forwardCollectionDataSourceMock.numberOfSections))

                let event = expectOnlyOneEvent(forwardCollectionDataSourceMock.events)
                guard case .numberOfSections(let collectionView)? = event else {
                    XCTAssert(false, "Method not called")
                    return
                }

                expect(collectionView).to(beIdenticalTo(expectedCollectionView))
            }
        }

        describe(".viewForSupplementaryElement") {
            it("should call forward data source method") {
                let viewForSupplementaryElement = collectionDataSource.collectionView?(
                    expectedCollectionView,
                    viewForSupplementaryElementOfKind: expectedSupplementaryKind,
                    at: expectedIndexPath
                )

                expect(viewForSupplementaryElement).to(beIdenticalTo(forwardCollectionDataSourceMock.viewForSupplementaryElement))

                let event = expectOnlyOneEvent(forwardCollectionDataSourceMock.events)
                guard case .viewForSupplementaryElement(let collectionView, let kind, let index)? = event else {
                    XCTAssert(false, "Method not called")
                    return
                }

                expect(collectionView).to(beIdenticalTo(expectedCollectionView))
                expect(kind).to(equal(expectedSupplementaryKind))
                expect(index).to(equal(expectedIndexPath))
            }
        }

        describe(".canMoveItemAt") {
            it("should call forward data source method") {
                let canMoveItem = collectionDataSource.collectionView?(expectedCollectionView, canMoveItemAt: expectedIndexPath)
                expect(canMoveItem).to(equal(forwardCollectionDataSourceMock.canMoveItem))

                let event = expectOnlyOneEvent(forwardCollectionDataSourceMock.events)
                guard case .canMoveItem(let collectionView, let indexPath)? = event else {
                    XCTAssert(false, "Method not called")
                    return
                }

                expect(collectionView).to(beIdenticalTo(expectedCollectionView))
                expect(indexPath).to(equal(expectedIndexPath))
            }
        }

        describe(".moveItemAt") {
            it("should call forward data source method") {
                let expectedDestIndexPath = IndexPath(row: 3, section: 4)
                collectionDataSource.collectionView?(expectedCollectionView, moveItemAt: expectedIndexPath, to: expectedDestIndexPath)

                let event = expectOnlyOneEvent(forwardCollectionDataSourceMock.events)
                guard case .moveItem(let collectionView, let indexPath, let destIndexPath)? = event else {
                    XCTAssert(false, "Method not called")
                    return
                }

                expect(collectionView).to(beIdenticalTo(expectedCollectionView))
                expect(indexPath).to(equal(expectedIndexPath))
                expect(destIndexPath).to(equal(expectedDestIndexPath))
            }
        }

        describe(".indexTitles") {
            it("should call forward data source method") {
                let indexTitles = collectionDataSource.indexTitles?(for: expectedCollectionView)
                expect(indexTitles).to(equal(forwardCollectionDataSourceMock.indexTitles))

                let event = expectOnlyOneEvent(forwardCollectionDataSourceMock.events)
                guard case .indexTitles(let collectionView)? = event else {
                    XCTAssert(false, "Method not called")
                    return
                }

                expect(collectionView).to(beIdenticalTo(expectedCollectionView))
            }
        }

        describe(".indexPathForIndexTitle") {
            it("should call forward data source method") {
                let expectedIndexTitle = "TestIndexTitle"
                let indexPathForIndexTitle =
                    collectionDataSource.collectionView?(expectedCollectionView,
                                                        indexPathForIndexTitle: expectedIndexTitle, at: expectedSection)
                expect(indexPathForIndexTitle).to(equal(forwardCollectionDataSourceMock.indexPathForIndexTitle))

                let event = expectOnlyOneEvent(forwardCollectionDataSourceMock.events)
                guard case .indexPathForIndexTitle(let collectionView, let indexTitle, let section)? = event else {
                    XCTAssert(false, "Method not called")
                    return
                }

                expect(collectionView).to(beIdenticalTo(expectedCollectionView))
                expect(indexTitle).to(equal(indexTitle))
                expect(section).to(equal(expectedSection))
            }
        }
    }
}

// swiftlint:enable function_body_length
// swiftlint:enable type_name

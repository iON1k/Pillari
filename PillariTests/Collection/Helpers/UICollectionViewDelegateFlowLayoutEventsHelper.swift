//  Created by Anton Popkov on 14.11.17.

import Quick
import Nimble

@testable import Pillari

// swiftlint:disable function_body_length

func collectionViewDelegateFlowLayoutEventsTest(sourceDelegate: UICollectionViewDelegateFlowLayout,
                                                forwardDelegateMock: UICollectionViewDelegateFlowLayoutMock,
                                                layout expectedLayout: UICollectionViewLayout) {

    let expectedIndexPath = IndexPath(row: 13, section: 4)
    let expectedSection = 15
    let expectedCollection = UICollectionView(frame: .zero, collectionViewLayout: expectedLayout)

    beforeEach {
        forwardDelegateMock.resetEvents()
    }

    describe(".sizeForItemAt") {
        it("should call forward delegate method") {
            let sizeForItem = sourceDelegate.collectionView?(
                expectedCollection,
                layout: expectedLayout,
                sizeForItemAt: expectedIndexPath
            )

            expect(sizeForItem).to(equal(forwardDelegateMock.sizeForItem))

            let event = expectOnlyOneEvent(forwardDelegateMock.events)
            guard case .sizeForItem(let collection, let layout, let index)? = event else {
                XCTAssert(false, "Method not called")
                return
            }

            expect(collection).to(beIdenticalTo(expectedCollection))
            expect(layout).to(beIdenticalTo(expectedLayout))
            expect(index).to(equal(expectedIndexPath))
        }
    }

    describe(".insetForSectionAt") {
        it("should call forward delegate method") {
            let insetForSection = sourceDelegate.collectionView?(
                expectedCollection,
                layout: expectedLayout,
                insetForSectionAt: expectedSection
            )

            expect(insetForSection).to(equal(forwardDelegateMock.insetForSection))

            let event = expectOnlyOneEvent(forwardDelegateMock.events)
            guard case .insetForSection(let collection, let layout, let section)? = event else {
                XCTAssert(false, "Method not called")
                return
            }

            expect(collection).to(beIdenticalTo(expectedCollection))
            expect(layout).to(beIdenticalTo(expectedLayout))
            expect(section).to(equal(expectedSection))
        }
    }

    describe(".minimumLineSpacingForSectionAt") {
        it("should call forward delegate method") {
            let minimumLineSpacingForSection = sourceDelegate.collectionView?(
                expectedCollection,
                layout: expectedLayout,
                minimumLineSpacingForSectionAt: expectedSection
            )

            expect(minimumLineSpacingForSection).to(equal(forwardDelegateMock.minimumLineSpacingForSection))

            let event = expectOnlyOneEvent(forwardDelegateMock.events)
            guard case .minimumLineSpacingForSection(let collection, let layout, let section)? = event else {
                XCTAssert(false, "Method not called")
                return
            }

            expect(collection).to(beIdenticalTo(expectedCollection))
            expect(layout).to(beIdenticalTo(expectedLayout))
            expect(section).to(equal(expectedSection))
        }
    }

    describe(".minimumInteritemSpacingForSectionAt") {
        it("should call forward delegate method") {
            let minimumInteritemSpacingForSection = sourceDelegate.collectionView?(
                expectedCollection,
                layout: expectedLayout,
                minimumInteritemSpacingForSectionAt: expectedSection
            )

            expect(minimumInteritemSpacingForSection).to(equal(forwardDelegateMock.minimumInteritemSpacingForSection))

            let event = expectOnlyOneEvent(forwardDelegateMock.events)
            guard case .minimumInteritemSpacingForSection(let collection, let layout, let section)? = event else {
                XCTAssert(false, "Method not called")
                return
            }

            expect(collection).to(beIdenticalTo(expectedCollection))
            expect(layout).to(beIdenticalTo(expectedLayout))
            expect(section).to(equal(expectedSection))
        }
    }

    describe(".referenceSizeForHeaderInSection") {
        it("should call forward delegate method") {
            let referenceSizeForHeader = sourceDelegate.collectionView?(
                expectedCollection,
                layout: expectedLayout,
                referenceSizeForHeaderInSection: expectedSection
            )

            expect(referenceSizeForHeader).to(equal(forwardDelegateMock.referenceSizeForHeader))

            let event = expectOnlyOneEvent(forwardDelegateMock.events)
            guard case .referenceSizeForHeader(let collection, let layout, let section)? = event else {
                XCTAssert(false, "Method not called")
                return
            }

            expect(collection).to(beIdenticalTo(expectedCollection))
            expect(layout).to(beIdenticalTo(expectedLayout))
            expect(section).to(equal(expectedSection))
        }
    }

    describe(".referenceSizeForFooterInSection") {
        it("should call forward delegate method") {
            let referenceSizeForFooter = sourceDelegate.collectionView?(
                expectedCollection,
                layout: expectedLayout,
                referenceSizeForFooterInSection: expectedSection
            )

            expect(referenceSizeForFooter).to(equal(forwardDelegateMock.referenceSizeForFooter))

            let event = expectOnlyOneEvent(forwardDelegateMock.events)
            guard case .referenceSizeForFooter(let collection, let layout, let section)? = event else {
                XCTAssert(false, "Method not called")
                return
            }

            expect(collection).to(beIdenticalTo(expectedCollection))
            expect(layout).to(beIdenticalTo(expectedLayout))
            expect(section).to(equal(expectedSection))
        }
    }
}

// swiftlint:enable function_body_length

import Quick
import Nimble
@testable import Pillari

// swiftlint:disable file_length
// swiftlint:disable function_body_length
// swiftlint:disable type_name
// swiftlint:disable cyclomatic_complexity
// swiftlint:disable type_body_length

class UICollectionViewDelegateImplementationForwardDelegateTests: QuickSpec {
    override func spec() {
        let layout = UICollectionViewFlowLayout()
        let expectedCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        let expectedCell = UICollectionViewCell()
        let expectedSupplementaryView = UICollectionReusableView()
        let expectedSupplementaryKind = "TestKind"
        let expectedIndexPath = IndexPath(row: 3, section: 0)
        let expectedAction = #selector(UICollectionViewDelegate.collectionView(_:canFocusItemAt:))
        var collectionDelegate: UICollectionViewDelegate!
        var forwardCollectionDelegateMock: UICollectionViewDelegateMock!

        let dataProvider =
            Array(repeating: CollectionRow<CollectionVoidCellMock>().withFlowLayout(), count: 5)
                .asFlowLayoutSections()
                .asCollectionFlowLayoutDataProvider(layout: layout)

        beforeEach {
            let collectionDelegateImpl = UICollectionViewDelegateImplementation(dataSource: dataProvider)
            forwardCollectionDelegateMock = UICollectionViewDelegateMock()
            collectionDelegateImpl.forwardDelegate = forwardCollectionDelegateMock
            collectionDelegate = collectionDelegateImpl
        }

        describe(".forwardDelegate") {
            it("should equals to expected value") {
                let collectionDelegateImpl = UICollectionViewDelegateImplementation(dataSource: dataProvider)
                let expectedForwardCollectionDelegate = UICollectionViewDelegateMock()
                collectionDelegateImpl.forwardDelegate = expectedForwardCollectionDelegate
                expect(collectionDelegateImpl.forwardDelegate).to(beIdenticalTo(expectedForwardCollectionDelegate))
                expect(collectionDelegateImpl.forwardScrollDelegate).to(beIdenticalTo(expectedForwardCollectionDelegate))
            }

            it("should to be nil") {
                let collectionDelegateImpl = UICollectionViewDelegateImplementation(dataSource: dataProvider)
                expect(collectionDelegateImpl.forwardDelegate).to(beNil())
                expect(collectionDelegateImpl.forwardScrollDelegate).to(beNil())
                collectionDelegateImpl.forwardDelegate = UICollectionViewDelegateMock()
                expect(collectionDelegateImpl.forwardDelegate).to(beNil())
                expect(collectionDelegateImpl.forwardScrollDelegate).to(beNil())
            }
        }

        describe(".shouldHighlightItemAt") {
            it("should call forward delegate method") {
                let shouldHighlightItem = collectionDelegate.collectionView?(expectedCollectionView, shouldHighlightItemAt: expectedIndexPath)

                expect(shouldHighlightItem).to(equal(forwardCollectionDelegateMock.shouldHighlightItem))

                let event = expectOnlyOneEvent(forwardCollectionDelegateMock.events)
                guard case .shouldHighlightItem(let collectionView, let indexPath)? = event else {
                    XCTAssert(false, "Method not called")
                    return
                }

                expect(collectionView).to(beIdenticalTo(expectedCollectionView))
                expect(indexPath).to(equal(expectedIndexPath))
            }
        }

        describe(".didHighlightItemAt") {
            it("should call forward delegate method") {
                collectionDelegate.collectionView?(expectedCollectionView, didHighlightItemAt: expectedIndexPath)

                let event = expectOnlyOneEvent(forwardCollectionDelegateMock.events)
                guard case .didHighlightItem(let collectionView, let indexPath)? = event else {
                    XCTAssert(false, "Method not called")
                    return
                }

                expect(collectionView).to(beIdenticalTo(expectedCollectionView))
                expect(indexPath).to(equal(expectedIndexPath))
            }
        }

        describe(".didUnhighlightItemAt") {
            it("should call forward delegate method") {
                collectionDelegate.collectionView?(expectedCollectionView, didUnhighlightItemAt: expectedIndexPath)

                let event = expectOnlyOneEvent(forwardCollectionDelegateMock.events)
                guard case .didUnhighlightItem(let collectionView, let indexPath)? = event else {
                    XCTAssert(false, "Method not called")
                    return
                }

                expect(collectionView).to(beIdenticalTo(expectedCollectionView))
                expect(indexPath).to(equal(expectedIndexPath))
            }
        }

        describe(".shouldSelectItemAt") {
            it("should call forward delegate method") {
                let shouldSelectItem = collectionDelegate.collectionView?(expectedCollectionView, shouldSelectItemAt: expectedIndexPath)

                expect(shouldSelectItem).to(equal(forwardCollectionDelegateMock.shouldSelectItem))

                let event = expectOnlyOneEvent(forwardCollectionDelegateMock.events)
                guard case .shouldSelectItem(let collectionView, let indexPath)? = event else {
                    XCTAssert(false, "Method not called")
                    return
                }

                expect(collectionView).to(beIdenticalTo(expectedCollectionView))
                expect(indexPath).to(equal(expectedIndexPath))
            }
        }

        describe(".shouldDeselectItemAt") {
            it("should call forward delegate method") {
                let shouldDeselectItem = collectionDelegate.collectionView?(expectedCollectionView, shouldDeselectItemAt: expectedIndexPath)

                expect(shouldDeselectItem).to(equal(forwardCollectionDelegateMock.shouldDeselectItem))

                let event = expectOnlyOneEvent(forwardCollectionDelegateMock.events)
                guard case .shouldDeselectItem(let collectionView, let indexPath)? = event else {
                    XCTAssert(false, "Method not called")
                    return
                }

                expect(collectionView).to(beIdenticalTo(expectedCollectionView))
                expect(indexPath).to(equal(expectedIndexPath))
            }
        }

        describe(".didSelectItemAt") {
            it("should call forward delegate method") {
                collectionDelegate.collectionView?(expectedCollectionView, didSelectItemAt: expectedIndexPath)

                let event = expectOnlyOneEvent(forwardCollectionDelegateMock.events)
                guard case .didSelectItem(let collectionView, let indexPath)? = event else {
                    XCTAssert(false, "Method not called")
                    return
                }

                expect(collectionView).to(beIdenticalTo(expectedCollectionView))
                expect(indexPath).to(equal(expectedIndexPath))
            }
        }

        describe(".didDeselectItemAt") {
            it("should call forward delegate method") {
                collectionDelegate.collectionView?(expectedCollectionView, didDeselectItemAt: expectedIndexPath)

                let event = expectOnlyOneEvent(forwardCollectionDelegateMock.events)
                guard case .didDeselectItem(let collectionView, let indexPath)? = event else {
                    XCTAssert(false, "Method not called")
                    return
                }

                expect(collectionView).to(beIdenticalTo(expectedCollectionView))
                expect(indexPath).to(equal(expectedIndexPath))
            }
        }

        describe(".willDisplayCell") {
            it("should call forward delegate method") {
                collectionDelegate.collectionView?(expectedCollectionView, willDisplay: expectedCell, forItemAt: expectedIndexPath)

                let event = expectOnlyOneEvent(forwardCollectionDelegateMock.events)
                guard case .willDisplayCell(let collectionView, let cell, let indexPath)? = event else {
                    XCTAssert(false, "Method not called")
                    return
                }

                expect(collectionView).to(beIdenticalTo(expectedCollectionView))
                expect(cell).to(beIdenticalTo(expectedCell))
                expect(indexPath).to(equal(expectedIndexPath))
            }
        }

        describe(".didEndDisplayingCell") {
            it("should call forward delegate method") {
                collectionDelegate.collectionView?(expectedCollectionView, didEndDisplaying: expectedCell, forItemAt: expectedIndexPath)

                let event = expectOnlyOneEvent(forwardCollectionDelegateMock.events)
                guard case .didEndDisplayingCell(let collectionView, let cell, let indexPath)? = event else {
                    XCTAssert(false, "Method not called")
                    return
                }

                expect(collectionView).to(beIdenticalTo(expectedCollectionView))
                expect(cell).to(beIdenticalTo(expectedCell))
                expect(indexPath).to(equal(expectedIndexPath))
            }
        }

        describe(".willDisplaySupplementaryView") {
            it("should call forward delegate method") {
                collectionDelegate.collectionView?(
                    expectedCollectionView,
                    willDisplaySupplementaryView: expectedSupplementaryView,
                    forElementKind: expectedSupplementaryKind,
                    at: expectedIndexPath
                )

                let event = expectOnlyOneEvent(forwardCollectionDelegateMock.events)
                guard case .willDisplaySupplementaryView(let collectionView, let view, let kind, let indexPath)? = event else {
                    XCTAssert(false, "Method not called")
                    return
                }

                expect(collectionView).to(beIdenticalTo(expectedCollectionView))
                expect(view).to(beIdenticalTo(expectedSupplementaryView))
                expect(kind).to(equal(expectedSupplementaryKind))
                expect(indexPath).to(equal(expectedIndexPath))
            }
        }

        describe(".didEndDisplayingSupplementaryView") {
            it("should call forward delegate method") {
                collectionDelegate.collectionView?(
                    expectedCollectionView,
                    didEndDisplayingSupplementaryView: expectedSupplementaryView,
                    forElementOfKind: expectedSupplementaryKind,
                    at: expectedIndexPath
                )

                let event = expectOnlyOneEvent(forwardCollectionDelegateMock.events)
                guard case .didEndDisplayingSupplementaryView(let collectionView, let view, let kind, let indexPath)? = event else {
                    XCTAssert(false, "Method not called")
                    return
                }

                expect(collectionView).to(beIdenticalTo(expectedCollectionView))
                expect(view).to(beIdenticalTo(expectedSupplementaryView))
                expect(kind).to(equal(expectedSupplementaryKind))
                expect(indexPath).to(equal(expectedIndexPath))
            }
        }

        describe(".shouldShowMenuForItemAt") {
            it("should call forward delegate method") {
                let shouldShowMenuForItem = collectionDelegate.collectionView?(expectedCollectionView, shouldShowMenuForItemAt: expectedIndexPath)

                expect(shouldShowMenuForItem).to(equal(forwardCollectionDelegateMock.shouldShowMenuForItem))

                let event = expectOnlyOneEvent(forwardCollectionDelegateMock.events)
                guard case .shouldShowMenuForItem(let collectionView, let indexPath)? = event else {
                    XCTAssert(false, "Method not called")
                    return
                }

                expect(collectionView).to(beIdenticalTo(expectedCollectionView))
                expect(indexPath).to(equal(expectedIndexPath))
            }
        }

        describe(".canPerformAction") {
            it("should call forward delegate method") {
                let canPerformAction = collectionDelegate.collectionView?(
                    expectedCollectionView,
                    canPerformAction: expectedAction,
                    forItemAt: expectedIndexPath,
                    withSender: self
                )

                expect(canPerformAction).to(equal(forwardCollectionDelegateMock.canPerformAction))

                let event = expectOnlyOneEvent(forwardCollectionDelegateMock.events)
                guard case .canPerformAction(let collectionView, let action, let indexPath, let sender)? = event else {
                    XCTAssert(false, "Method not called")
                    return
                }

                expect(collectionView).to(beIdenticalTo(expectedCollectionView))
                expect(action).to(equal(expectedAction))
                expect(indexPath).to(equal(expectedIndexPath))
                expect(sender).to(beIdenticalTo(self))
            }
        }

        describe(".performAction") {
            it("should call forward delegate method") {
                collectionDelegate.collectionView?(
                    expectedCollectionView,
                    performAction: expectedAction,
                    forItemAt: expectedIndexPath,
                    withSender: self
                )

                let event = expectOnlyOneEvent(forwardCollectionDelegateMock.events)
                guard case .performAction(let collectionView, let action, let indexPath, let sender)? = event else {
                    XCTAssert(false, "Method not called")
                    return
                }

                expect(collectionView).to(beIdenticalTo(expectedCollectionView))
                expect(action).to(equal(expectedAction))
                expect(indexPath).to(equal(expectedIndexPath))
                expect(sender).to(beIdenticalTo(self))
            }
        }

        describe(".transitionLayoutForOldLayout") {
            it("should call forward delegate method") {
                let expectedFromLayout = UICollectionViewLayout()
                let expectedToLayout = UICollectionViewLayout()
                let transitionLayout = collectionDelegate.collectionView?(
                    expectedCollectionView,
                    transitionLayoutForOldLayout: expectedFromLayout,
                    newLayout: expectedToLayout
                )

                expect(transitionLayout).to(equal(forwardCollectionDelegateMock.transitionLayout))

                let event = expectOnlyOneEvent(forwardCollectionDelegateMock.events)
                guard case .transitionLayout(let collectionView, let fromLayout, let toLayout)? = event else {
                    XCTAssert(false, "Method not called")
                    return
                }

                expect(collectionView).to(beIdenticalTo(expectedCollectionView))
                expect(fromLayout).to(beIdenticalTo(expectedFromLayout))
                expect(toLayout).to(beIdenticalTo(expectedToLayout))
            }
        }

        describe(".canFocusItemAt") {
            it("should call forward delegate method") {
                let canFocusItem = collectionDelegate.collectionView?(expectedCollectionView, canFocusItemAt: expectedIndexPath)

                expect(canFocusItem).to(equal(forwardCollectionDelegateMock.canFocusItem))

                let event = expectOnlyOneEvent(forwardCollectionDelegateMock.events)
                guard case .canFocusItem(let collectionView, let indexPath)? = event else {
                    XCTAssert(false, "Method not called")
                    return
                }

                expect(collectionView).to(beIdenticalTo(expectedCollectionView))
                expect(indexPath).to(equal(expectedIndexPath))
            }
        }

        describe(".indexPathForPreferredFocusedView") {
            it("should call forward delegate method") {
                let indexPathForPreferredFocusedView = collectionDelegate.indexPathForPreferredFocusedView?(in: expectedCollectionView)

                expect(indexPathForPreferredFocusedView).to(equal(forwardCollectionDelegateMock.indexPathForPreferredFocusedView))

                let event = expectOnlyOneEvent(forwardCollectionDelegateMock.events)
                guard case .indexPathForPreferredFocusedView(let collectionView)? = event else {
                    XCTAssert(false, "Method not called")
                    return
                }

                expect(collectionView).to(beIdenticalTo(expectedCollectionView))
            }
        }

        describe(".targetIndexPathForMoveFromItemAt") {
            it("should call forward delegate method") {
                let expectedProposedIndexPath = IndexPath(row: 12, section: 4)
                let targetIndexPathForMoveFromItem = collectionDelegate.collectionView?(
                    expectedCollectionView,
                    targetIndexPathForMoveFromItemAt: expectedIndexPath,
                    toProposedIndexPath: expectedProposedIndexPath
                )

                expect(targetIndexPathForMoveFromItem).to(equal(forwardCollectionDelegateMock.targetIndexPathForMoveFromItem))

                let event = expectOnlyOneEvent(forwardCollectionDelegateMock.events)
                guard case .targetIndexPathForMoveFromItem(let collectionView, let targetIndexPath, let proposedIndexPath)? = event else {
                    XCTAssert(false, "Method not called")
                    return
                }

                expect(collectionView).to(beIdenticalTo(expectedCollectionView))
                expect(targetIndexPath).to(equal(expectedIndexPath))
                expect(proposedIndexPath).to(equal(expectedProposedIndexPath))
            }
        }

        describe(".proposedContentOffset") {
            it("should call forward delegate method") {
                let expectedTargetContentOffset = CGPoint(x: 123, y: 434)
                let targetContentOffset = collectionDelegate.collectionView?(
                    expectedCollectionView,
                    targetContentOffsetForProposedContentOffset: expectedTargetContentOffset
                )

                expect(targetContentOffset)
                    .to(equal(forwardCollectionDelegateMock.targetContentOffsetForProposedContentOffset))

                let event = expectOnlyOneEvent(forwardCollectionDelegateMock.events)
                guard case .targetContentOffsetForProposedContentOffset(let collectionView, let proposedTargetContentOffset)? = event else {
                    XCTAssert(false, "Method not called")
                    return
                }

                expect(collectionView).to(beIdenticalTo(expectedCollectionView))
                expect(proposedTargetContentOffset).to(equal(expectedTargetContentOffset))
            }
        }
    }
}

// swiftlint:enable function_body_length
// swiftlint:enable type_name
// swiftlint:enable cyclomatic_complexity
// swiftlint:enable type_body_length
// swiftlint:enable file_length

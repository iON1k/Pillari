//  Created by Anton Popkov on 29.11.2017.

import Quick
import Nimble

@testable import Pillari

// swiftlint:disable type_name
// swiftlint:disable function_body_length

class UICollectionViewDelegateImplementationTests: QuickSpec {
    override func spec() {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        let indexPath24 = IndexPath(row: 4, section: 2)

        let configuration24 = CollectionRowConfiguration(
            should: CollectionRowConfiguration.Should(
                highlight: false,
                select: false,
                deselect: false,
                showMenu: true
            ),
            canFocus: false
        )

        let row24 = CollectionRow<CollectionVoidCellMock>(configuration: configuration24).withFlowLayout()
        let defaultRow = CollectionRow<CollectionVoidCellMock>().withFlowLayout()
        let defaultSection = Array(repeating: defaultRow, count: 5).asFlowLayoutSection()

        let section2 = [
            defaultRow,
            defaultRow,
            defaultRow,
            defaultRow,
            row24
        ]
        .asFlowLayoutSection()

        let dataProvider = [
            defaultSection,
            defaultSection,
            section2
        ]
        .asCollectionFlowLayoutDataProvider(layout: layout)

        let collectionDelegate: UICollectionViewDelegate
            = UICollectionViewDelegateImplementation(dataSource: dataProvider)

        describe(".init(dataSource:)") {
            it("should return valid value") {
                expect((collectionDelegate as? UICollectionViewDelegateImplementation)?.dataSource).to(beIdenticalTo(dataProvider))
            }
        }

        describe(".shouldHighlightItemAt") {
            it("should result equals to expected value") {
                let shouldHighlightItem = collectionDelegate.collectionView?(collectionView,
                                                                             shouldHighlightItemAt: indexPath24)
                expect(shouldHighlightItem).to(equal(configuration24.should.highlight))
            }
        }

        describe(".shouldSelectItemAt") {
            it("should result equals to expected value") {
                let shouldSelectItem = collectionDelegate.collectionView?(collectionView,
                                                                             shouldSelectItemAt: indexPath24)
                expect(shouldSelectItem).to(equal(configuration24.should.select))
            }
        }

        describe(".shouldDeselectItemAt") {
            it("should result equals to expected value") {
                let shouldDeselectItem = collectionDelegate.collectionView?(collectionView,
                                                                          shouldDeselectItemAt: indexPath24)
                expect(shouldDeselectItem).to(equal(configuration24.should.deselect))
            }
        }

        describe(".shouldShowMenuForItemAt") {
            it("should result equals to expected value") {
                let shouldShowMenuForItem = collectionDelegate.collectionView?(collectionView,
                                                                            shouldShowMenuForItemAt: indexPath24)
                expect(shouldShowMenuForItem).to(equal(configuration24.should.showMenu))
            }
        }

        describe(".canFocusItemAt") {
            it("should result equals to expected value") {
                let canFocusItem = collectionDelegate.collectionView?(collectionView,
                                                                               canFocusItemAt: indexPath24)
                expect(canFocusItem).to(equal(configuration24.canFocus))
            }
        }
    }
}

// swiftlint:enable type_name
// swiftlint:enable function_body_length

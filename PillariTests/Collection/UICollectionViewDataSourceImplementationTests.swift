import Quick
import Nimble
@testable import Pillari

// swiftlint:disable type_name
// swiftlint:disable function_body_length

class UICollectionViewDataSourceImplementationTests: QuickSpec {
    override func spec() {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionViewMock(frame: .zero, collectionViewLayout: layout)
        let sectionIndex2 = 2
        let rowIndex4 = 4
        let indexPath24 = IndexPath(row: rowIndex4, section: sectionIndex2)
        let cell24 = CollectionCellMock()
        let cellFactory24 = CollectionCellFactory { _, _ in
            return cell24
        }
        let configuration24 = CollectionRowConfiguration(
            canMove: true
        )

        let row24 = CollectionRow<CollectionCellMock>(
            cellFactory: cellFactory24,
            configuration: configuration24
        )
        .withFlowLayout(sizeCalculator: CGSize(width: 10, height: 10))

        let headerView2 = UICollectionReusableView()
        let headerViewFactory2 = CollectionSupplementaryFactory { _, _, _ in
            return headerView2
        }
        let header2 = CollectionSupplementary(viewFactory: headerViewFactory2).withFlowAutomaticLayout()

        let defaultRow = CollectionRow<CollectionVoidCellMock>().withFlowAutomaticLayout()
        let defaultSection = Array(repeating: defaultRow, count: 5).asFlowLayoutSection()
        let section2 = [
            defaultRow,
            defaultRow,
            defaultRow,
            defaultRow,
            row24
        ]
        .asFlowLayoutSection(header: header2)

        let dataSource = [
            defaultSection,
            defaultSection,
            section2
        ]
        .asCollectionFlowLayoutDataProvider(layout: layout)

        let collectionDataSource: UICollectionViewDataSource = UICollectionViewDataSourceImplementation(dataSource: dataSource)

        describe(".init(dataSource:)") {
            it("should return valid value") {
                expect((collectionDataSource as? UICollectionViewDataSourceImplementation)?.dataSource).to(beIdenticalTo(dataSource))
            }
        }

        describe(".numberOfItemsInSection") {
            it("should result equals to expected value") {
                let numberOfItems = collectionDataSource.collectionView(collectionView, numberOfItemsInSection: sectionIndex2)
                expect(numberOfItems).to(equal(section2.rows.count))
            }
        }

        describe(".cellForItem") {
            it("should result equals to expected value") {
                let cell = collectionDataSource.collectionView(collectionView, cellForItemAt: indexPath24)
                expect(cell).to(beIdenticalTo(cell24))
            }
        }

        describe(".numberOfSections") {
            it("should result equals to expected value") {
                let numberOfSections = collectionDataSource.numberOfSections?(in: collectionView)
                expect(numberOfSections).to(equal(dataSource.sections.count))
            }
        }

        describe(".canMoveItem") {
            it("should result equals to expected value") {
                let canMoveItem = collectionDataSource.collectionView?(collectionView, canMoveItemAt: indexPath24)
                expect(canMoveItem).to(equal(configuration24.canMove))
            }
        }

        describe(".viewForSupplementaryElement") {
            it("should result equals to expected value") {
                let viewForSupplementaryElement = collectionDataSource.collectionView?(
                    collectionView,
                    viewForSupplementaryElementOfKind: UICollectionView.elementKindSectionHeader,
                    at: IndexPath(row: 0, section: sectionIndex2)
                )

                expect(viewForSupplementaryElement).to(beIdenticalTo(headerView2))
            }
        }

        describe(".indexPathForIndexTitle") {
            it("should no responds to selector") {
                let selector = #selector(UICollectionViewDataSource.collectionView(_:indexPathForIndexTitle:at:))
                expect(collectionDataSource.responds(to: selector)).to(beFalse())
            }
        }
    }
}

// swiftlint:enable type_name
// swiftlint:enable function_body_length

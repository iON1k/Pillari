//  Created by Anton Popkov on 16.11.17.

import Quick
import Nimble

@testable import Pillari

class CollectionRowFlowLayoutTests: QuickSpec {
    override func spec() {
        let viewModel = ViewModelMock()
        let collectionFrame = CGRect(x: 0, y: 0, width: 300, height: 240)
        let collectionView = UICollectionView(frame: collectionFrame, collectionViewLayout: UICollectionViewLayout())

        describe(".withFlowLayout(item:)") {
            it("should return valid value") {
                let row = CollectionRow<CollectionCellMock>()
                let flowRow = row.withFlowLayout(item: viewModel)
                expect(flowRow.row).to(beIdenticalTo(row))

                let expectedSize = CGSize(width: collectionView.bounds.width, height: CollectionCellMock.defaultHeight)
                expect(flowRow.sizeCalculator.calculateSize(with: collectionView)).to(equal(expectedSize))
            }
        }

        describe(".withFlowLayout(item: width:)") {
            it("should return valid value") {
                let row = CollectionRow<CollectionCellMock>()
                let width: CGFloat = 150
                let flowRow = row.withFlowLayout(item: viewModel, width: width)
                expect(flowRow.row).to(beIdenticalTo(row))

                let expectedSize = CGSize(width: width, height: CollectionCellMock.defaultHeight)
                expect(flowRow.sizeCalculator.calculateSize(with: collectionView)).to(equal(expectedSize))
            }
        }

        describe(".withFlowLayout(width:)") {
            it("should return valid value") {
                let row = CollectionRow<CollectionVoidCellMock>()
                let width: CGFloat = 150
                let flowRow = row.withFlowLayout(width: width)
                expect(flowRow.row).to(beIdenticalTo(row))

                let expectedSize = CGSize(width: width, height: CollectionVoidCellMock.defaultHeight)
                expect(flowRow.sizeCalculator.calculateSize(with: collectionView)).to(equal(expectedSize))
            }
        }

        describe(".withFlowLayout()") {
            it("should return valid value") {
                let row = CollectionRow<CollectionVoidCellMock>()
                let flowRow = row.withFlowLayout()
                expect(flowRow.row).to(beIdenticalTo(row))

                let expectedSize = CGSize(width: collectionView.bounds.width, height: CollectionVoidCellMock.defaultHeight)
                expect(flowRow.sizeCalculator.calculateSize(with: collectionView)).to(equal(expectedSize))
            }
        }
    }
}

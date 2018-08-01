//  Created by Anton Popkov on 16.11.17.

import Quick
import Nimble

@testable import Pillari

class CollectionSupplementaryFlowLayoutTests: QuickSpec {
    override func spec() {
        let viewModel = ViewModelMock()
        let collectionFrame = CGRect(x: 0, y: 0, width: 300, height: 240)
        let collectionView = UICollectionView(frame: collectionFrame, collectionViewLayout: UICollectionViewLayout())

        describe(".withFlowLayout(item:)") {
            it("should return valid value") {
                let supplementary = CollectionSupplementary<CollectionSupplementaryViewMock>()
                let flowSupplementary = supplementary.withFlowLayout(item: viewModel)
                expect(flowSupplementary.supplementary).to(beIdenticalTo(supplementary))

                let expectedSize = CGSize(width: collectionView.bounds.width, height: CollectionSupplementaryViewMock.defaultHeight)
                expect(flowSupplementary.sizeCalculator.calculateSize(with: collectionView)).to(equal(expectedSize))
            }
        }

        describe(".withFlowLayout(item: width:)") {
            it("should return valid value") {
                let supplementary = CollectionSupplementary<CollectionSupplementaryViewMock>()
                let width: CGFloat = 150
                let flowSupplementary = supplementary.withFlowLayout(item: viewModel, width: width)
                expect(flowSupplementary.supplementary).to(beIdenticalTo(supplementary))

                let expectedSize = CGSize(width: width, height: CollectionSupplementaryViewMock.defaultHeight)
                expect(flowSupplementary.sizeCalculator.calculateSize(with: collectionView)).to(equal(expectedSize))
            }
        }

        describe(".withFlowLayout(width:)") {
            it("should return valid value") {
                let supplementary = CollectionSupplementary<CollectionVoidSupplementaryViewMock>()
                let width: CGFloat = 150
                let flowSupplementary = supplementary.withFlowLayout(width: width)
                expect(flowSupplementary.supplementary).to(beIdenticalTo(supplementary))

                let expectedSize = CGSize(width: width, height: CollectionVoidSupplementaryViewMock.defaultHeight)
                expect(flowSupplementary.sizeCalculator.calculateSize(with: collectionView)).to(equal(expectedSize))
            }
        }

        describe(".withFlowLayout()") {
            it("should return valid value") {
                let supplementary = CollectionSupplementary<CollectionVoidSupplementaryViewMock>()
                let flowSupplementary = supplementary.withFlowLayout()
                expect(flowSupplementary.supplementary).to(beIdenticalTo(supplementary))

                let expectedSize = CGSize(width: collectionView.bounds.width, height: CollectionVoidSupplementaryViewMock.defaultHeight)
                expect(flowSupplementary.sizeCalculator.calculateSize(with: collectionView)).to(equal(expectedSize))
            }
        }
    }
}

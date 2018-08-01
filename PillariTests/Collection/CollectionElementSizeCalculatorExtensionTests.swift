import Quickimport Nimble
@testable import Pillari

// swiftlint:disable type_name

class CollectionElementSizeCalculatorExtensionTests: QuickSpec {
    override func spec() {
        let collectionViewFrame = CGRect(x: 0, y: 0, width: 300, height: 400)
        let collectionView = UICollectionView(
            frame: collectionViewFrame,
            collectionViewLayout: UICollectionViewLayout()
        )

        describe(".init(_: item:)") {
            it("should return valid size calculator") {
                let sizeCalculator = CollectionElementSizeCalculator(CollectionCellMock.self, item: ViewModelMock())
                let expectedSize = CGSize(width: collectionViewFrame.width, height: CollectionCellMock.defaultHeight)
                expect(sizeCalculator.calculateSize(with: collectionView)).to(equal(expectedSize))
            }
        }

        describe(".init(_: item: width)") {
            it("should return valid size calculator") {
                let expectedWidth: CGFloat = 100
                let sizeCalculator = CollectionElementSizeCalculator(
                    CollectionCellMock.self,
                    item: ViewModelMock(),
                    width: expectedWidth
                )

                let expectedSize = CGSize(width: expectedWidth, height: CollectionCellMock.defaultHeight)
                expect(sizeCalculator.calculateSize(with: collectionView)).to(equal(expectedSize))
            }
        }
    }
}

// swiftlint:enable type_name

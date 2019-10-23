import Quick
import Nimble
@testable import Pillari

class CollectionCellFactoryTests: QuickSpec {
    override func spec() {
        describe(".createCell(for: with:)") {
            it("should result equals to expected cell") {
                let expectedCell = UICollectionViewCell()
                let expectedCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
                let expectedIndexPath = IndexPath(row: 10, section: 5)

                var collectionView: UICollectionView?
                var indexPath: IndexPath?

                let cellFactory = CollectionCellFactory { collection, index in
                    collectionView = collection
                    indexPath = index
                    return expectedCell
                }

                let cell = cellFactory.createCell(for: expectedCollectionView, with: expectedIndexPath)
                expect(cell).to(beIdenticalTo(expectedCell))
                expect(collectionView).to(beIdenticalTo(expectedCollectionView))
                expect(indexPath).to(equal(expectedIndexPath))
            }
        }
    }
}

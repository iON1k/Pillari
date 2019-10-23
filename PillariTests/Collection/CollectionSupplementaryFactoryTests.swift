import Quick
import Nimble
@testable import Pillari

class CollectionSupplementaryFactoryTests: QuickSpec {
    override func spec() {
        describe(".createView(for: with)") {
            it("should created view equals to expected view") {
                let expectedView = UICollectionReusableView()
                let expectedKind = "TestKind"
                let expectedCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
                let expectedIndexPath = IndexPath(row: 10, section: 5)

                var collectionView: UICollectionView?
                var kind: String?
                var indexPath: IndexPath?

                let supplementaryFactory = CollectionSupplementaryFactory { collection, kindParam, index in
                    collectionView = collection
                    kind = kindParam
                    indexPath = index
                    return expectedView
                }

                let view = supplementaryFactory.createView(for: expectedCollectionView, kind: expectedKind, with: expectedIndexPath)
                expect(view).to(beIdenticalTo(expectedView))
                expect(collectionView).to(beIdenticalTo(expectedCollectionView))
                expect(kind).to(equal(expectedKind))
                expect(indexPath).to(equal(expectedIndexPath))
            }
        }
    }
}

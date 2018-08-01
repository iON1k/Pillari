import Quick
import Nimble
@testable import Pillari

class CollectionCellFactoryExtensionTests: QuickSpec {
    override func spec() {
        let expectedReuseId = "Test"
        let indexPath = IndexPath()
        let expectedViewModel = ViewModelMock()
        var collectionView: UICollectionView!

        beforeEach {
            collectionView = UICollectionViewMock(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        }

        describe(".init(_: reuseId:)") {
            it("should created cell is kind of expected class") {
                let cellFactory = CollectionCellFactory(CollectionCellMock.self)
                let cell = cellFactory.createCell(for: collectionView, with: indexPath)
                expect(cell).to(beAKindOf(CollectionCellMock.self))
            }

            it("should created cell reuse id equals to expected reuse id") {
                let cellFactory = CollectionCellFactory(CollectionCellMock.self, reuseId: expectedReuseId)
                let cell = cellFactory.createCell(for: collectionView, with: indexPath)
                expect(cell).to(beAKindOf(CollectionCellMock.self))
                expect(cell.reuseIdentifier).to(equal(expectedReuseId))
            }
        }

        describe(".init(_: item: reuseId:)") {
            it("should created cell is configurated") {
                let cellFactory = CollectionCellFactory(CollectionCellMock.self, item: expectedViewModel)
                let cell = cellFactory.createCell(for: collectionView, with: indexPath)
                expect(cell).to(beAKindOf(CollectionCellMock.self))
                expect((cell as? CollectionCellMock)?.viewModel).to(beIdenticalTo(expectedViewModel))
            }

            it("should created view reuse id equals to expected reuse id") {
                let cellFactory = CollectionCellFactory(CollectionCellMock.self, item: expectedViewModel, reuseId: expectedReuseId)
                let cell = cellFactory.createCell(for: collectionView, with: indexPath)
                expect(cell).to(beAKindOf(CollectionCellMock.self))
                expect((cell as? CollectionCellMock)?.viewModel).to(beIdenticalTo(expectedViewModel))
                expect(cell.reuseIdentifier).to(equal(expectedReuseId))
            }
        }
    }
}

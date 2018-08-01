//  Created by Anton Popkov on 22.11.17.

import Quick
import Nimble

@testable import Pillari

// swiftlint:disable type_name

class CollectionSupplementaryFactoryExtensionTests: QuickSpec {
    override func spec() {
        let expectedReuseId = "Test"
        let kind = "TestKind"
        let indexPath = IndexPath()
        let expectedViewModel = ViewModelMock()
        var collectionView: UICollectionView!

        beforeEach {
            collectionView = UICollectionViewMock(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        }

        describe(".init(_: reuseId:)") {
            it("should created supplementary is kind of expected class") {
                let supplementaryFactory = CollectionSupplementaryFactory(CollectionSupplementaryViewMock.self)
                let supplementary = supplementaryFactory.createView(for: collectionView, kind: kind, with: indexPath)
                expect(supplementary).to(beAKindOf(CollectionSupplementaryViewMock.self))
            }

            it("should created supplementary reuse id equals to expected reuse id") {
                let supplementaryFactory = CollectionSupplementaryFactory(CollectionSupplementaryViewMock.self, reuseId: expectedReuseId)
                let supplementary = supplementaryFactory.createView(for: collectionView, kind: kind, with: indexPath)
                expect(supplementary).to(beAKindOf(CollectionSupplementaryViewMock.self))
                expect(supplementary.reuseIdentifier).to(equal(expectedReuseId))
            }
        }

        describe(".init(_: item: reuseId:)") {
            it("should created supplementary is configurated") {
                let supplementaryFactory = CollectionSupplementaryFactory(CollectionSupplementaryViewMock.self, item: expectedViewModel)
                let supplementary = supplementaryFactory.createView(for: collectionView, kind: kind, with: indexPath)
                expect(supplementary).to(beAKindOf(CollectionSupplementaryViewMock.self))
                expect((supplementary as? CollectionSupplementaryViewMock)?.viewModel).to(beIdenticalTo(expectedViewModel))
            }

            it("should created view reuse id equals to expected reuse id") {
                let supplementaryFactory = CollectionSupplementaryFactory(
                    CollectionSupplementaryViewMock.self,
                    item: expectedViewModel,
                    reuseId: expectedReuseId
                )
                let supplementary = supplementaryFactory.createView(for: collectionView, kind: kind, with: indexPath)
                expect(supplementary).to(beAKindOf(CollectionSupplementaryViewMock.self))
                expect((supplementary as? CollectionSupplementaryViewMock)?.viewModel).to(beIdenticalTo(expectedViewModel))
                expect(supplementary.reuseIdentifier).to(equal(expectedReuseId))
            }
        }
    }
}

// swiftlint:enable type_name

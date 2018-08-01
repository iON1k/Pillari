import Quickimport Nimble
@testable import Pillari

// swiftlint:disable type_name

class CollectionDataProviderProtocolExtensionTests: QuickSpec {
    override func spec() {
        let layout = UICollectionViewFlowLayout()
        let dataSource: CollectionDataProviderProtocol = [
            CollectionFlowLayoutSection()
        ]
        .asCollectionFlowLayoutDataProvider(layout: layout)

        describe(".asCollectionPillar(collectionView:)") {
            it("should create valid table director") {
                let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
                let colectionDirector = dataSource.asCollectionPillar(collectionView: collectionView)

                expect(colectionDirector.dataProvider).to(beIdenticalTo(dataSource))
                expect(colectionDirector.collectionView).to(beIdenticalTo(collectionView))
            }
        }
    }
}

// swiftlint:enable type_name

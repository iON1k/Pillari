//  Created by Anton Popkov on 29.11.2017.

import Quick
import Nimble

@testable import Pillari

// swiftlint:disable function_body_length

class CollectionPillarTests: QuickSpec {
    override func spec() {
        let layout = UICollectionViewFlowLayout()
        let dataProvider = CollectionFlowLayoutDataProvider(layout: layout)
        var collectionPillar: CollectionPillar!
        var collectionView: UICollectionView!

        beforeEach {
            collectionPillar = CollectionPillar(dataProvider: dataProvider)
            collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
            collectionPillar.collectionView = collectionView
        }

        describe(".collectionView") {
            it("should not to be nil") {
                expect(collectionPillar.collectionView).notTo(beNil())
            }

            it("should to be nil") {
                autoreleasepool {
                    collectionPillar.collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
                }

                expect(collectionPillar.collectionView).to(beNil())
            }

            it("should has expected delegate/dataSource") {
                expect(collectionView.delegate).to(beIdenticalTo(collectionPillar.collectionViewDelegateImpl))
                expect(collectionView.dataSource).to(beIdenticalTo(collectionPillar.collectionViewDataSourceImpl))
            }

            it("should has nil delegate/dataSource") {
                collectionPillar = nil
                expect(collectionView.delegate).to(beNil())
                expect(collectionView.dataSource).to(beNil())
            }

            it("should prev value has nil delegate/dataSource") {
                collectionPillar.collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
                expect(collectionView.delegate).to(beNil())
                expect(collectionView.dataSource).to(beNil())
            }
        }

        describe(".dataSource") {
            it("should equals to expected value") {
                let layout = UICollectionViewFlowLayout()
                let dataProvider = CollectionFlowLayoutDataProvider(layout: layout)
                collectionPillar.dataProvider = dataProvider
                expect(collectionPillar.dataProvider).to(beIdenticalTo(dataProvider))
                expect(collectionView.collectionViewLayout).to(beIdenticalTo(dataProvider.flowLayout))
                expect(collectionPillar.collectionViewDataSourceImpl.dataSource)
                    .to(beIdenticalTo(dataProvider.dataSource))
                expect(collectionPillar.collectionViewDelegateImpl.dataSource)
                    .to(beIdenticalTo(dataProvider.dataSource))
            }
        }

        describe(".forwardDelegate") {
            it("should to be nil") {
                expect(collectionPillar.forwardDelegate).to(beNil())
            }

            it("should equals to expected value") {
                let forwardDelegate = UICollectionViewDelegateMock()
                collectionPillar.forwardDelegate = forwardDelegate
                expect(collectionPillar.forwardDelegate).to(beIdenticalTo(forwardDelegate))
                expect(collectionPillar.collectionViewDelegateImpl.forwardDelegate).to(beIdenticalTo(forwardDelegate))
            }
        }

        describe(".forwardDataSource") {
            it("should to be nil") {
                expect(collectionPillar.forwardDataSource).to(beNil())
            }

            it("should equals to expected value") {
                let forwardDataSource = UICollectionViewDataSourceMock()
                collectionPillar.forwardDataSource = forwardDataSource
                expect(collectionPillar.forwardDataSource).to(beIdenticalTo(forwardDataSource))
                expect(collectionPillar.collectionViewDataSourceImpl.forwardDataSource).to(beIdenticalTo(forwardDataSource))
            }
        }

        describe(".init(collectionView: dataSource:)") {
            it("should return valid instance") {
                let dataProvider = CollectionFlowLayoutDataProvider(layout: layout)
                let customCollectionPillar = CollectionPillar(
                    collectionView: collectionView,
                    dataProvider: dataProvider
                )

                expect(customCollectionPillar.collectionView).to(beIdenticalTo(collectionView))
                expect(customCollectionPillar.dataProvider).to(beIdenticalTo(dataProvider))
                expect(collectionView.collectionViewLayout).to(beIdenticalTo(dataProvider.flowLayout))
                expect(customCollectionPillar.collectionViewDataSourceImpl.dataSource)
                    .to(beIdenticalTo(dataProvider.dataSource))
                expect(customCollectionPillar.collectionViewDelegateImpl.dataSource)
                    .to(beIdenticalTo(dataProvider.dataSource))
                expect(collectionView.delegate).to(beIdenticalTo(customCollectionPillar.collectionViewDelegateImpl))
                expect(collectionView.dataSource).to(beIdenticalTo(customCollectionPillar.collectionViewDataSourceImpl))
            }
        }
    }
}

// swiftlint:enable function_body_length

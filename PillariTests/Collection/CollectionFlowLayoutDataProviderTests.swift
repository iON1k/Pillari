import Quick
import Nimble
@testable import Pillari

// swiftlint:disable function_body_length

class CollectionFlowLayoutDataProviderTests: QuickSpec {
    override func spec() {
        let flowLayout = UICollectionViewFlowLayout()

        let indexPath20 = IndexPath(row: 0, section: 2)
        let header2 = CollectionSupplementary<CollectionVoidSupplementaryViewMock>()
        let footer2 = CollectionSupplementary<CollectionVoidSupplementaryViewMock>()

        let section2 = CollectionFlowLayoutSection(
            header: header2.withFlowLayout(),
            footer: footer2.withFlowLayout()
        )

        let sections = [
            CollectionFlowLayoutSection(),
            CollectionFlowLayoutSection(),
            section2
        ]

        var dataProvider: CollectionFlowLayoutDataProvider!

        beforeEach {
            dataProvider = CollectionFlowLayoutDataProvider(layout: flowLayout, flowSections: sections)
        }

        describe(".dataSource") {
            it("should has expected sections") {
                expectToIdential(dataProvider.dataSource.sections, to: sections)
            }
        }

        describe(".flowLayout") {
            it("should equals to expected layout") {
                expect(dataProvider.flowLayout).to(beIdenticalTo(flowLayout))
            }
        }

        describe(".layout") {
            it("should equals to expected layout") {
                expect(dataProvider.layout).to(beIdenticalTo(flowLayout))
            }
        }

        describe(".flowSections") {
            it("should equals to expected sections") {
                expectToIdential(dataProvider.flowSections, to: sections)
            }
        }

        describe(".sectionsLayout") {
            it("should equals to expected sections") {
                expectToIdential(dataProvider.sectionsLayout, to: sections)
            }
        }

        describe(".layoutForwardDelegate") {
            it("should equals to expected value") {
                let layoutForwardDelegate = UICollectionViewDelegateFlowLayoutMock()
                dataProvider.layoutForwardDelegate = layoutForwardDelegate
                expect(dataProvider.layoutForwardDelegate).to(beIdenticalTo(layoutForwardDelegate))
            }

            it("should to be nil") {
                dataProvider.layoutForwardDelegate = UICollectionViewDelegateFlowLayoutMock()
                expect(dataProvider.layoutForwardDelegate).to(beNil())
            }
        }

        describe(".collectionViewFlowLayout") {
            it("should setting up as flow layout custom delegate") {
                let collectionViewFlowLayout = dataProvider.collectionViewFlowLayout
                expect(collectionViewFlowLayout).to(beIdenticalTo(flowLayout.customDelegate))
            }

            it("should has forward delegate") {
                let layoutForwardDelegate = UICollectionViewDelegateFlowLayoutMock()
                dataProvider.layoutForwardDelegate = layoutForwardDelegate
                expect(dataProvider.collectionViewFlowLayout.forwardDelegate).to(beIdenticalTo(layoutForwardDelegate))
            }
        }

        describe(".supplementary(with: index:)") {
            it("should return header supplementary") {
                let supplementary = dataProvider.supplementary(with: UICollectionView.elementKindSectionHeader, at: indexPath20)
                expect(supplementary).to(beIdenticalTo(header2))
            }

            it("should return footer supplementary") {
                let supplementary = dataProvider.supplementary(with: UICollectionView.elementKindSectionFooter, at: indexPath20)
                expect(supplementary).to(beIdenticalTo(footer2))
            }

            it("should return nil supplementary for wrong kind") {
                let supplementary = dataProvider.supplementary(with: "TestKind", at: indexPath20)
                expect(supplementary).to(beNil())
            }

            it("should return nil supplementary for wrong row index") {
                let supplementary = dataProvider.supplementary(with: UICollectionView.elementKindSectionHeader, at: IndexPath(row: 1, section: 2))
                expect(supplementary).to(beNil())
            }
        }
    }
}

// swiftlint:enable function_body_length

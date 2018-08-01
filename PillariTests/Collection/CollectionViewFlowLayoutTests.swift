import Quickimport Nimble
@testable import Pillari

// swiftlint:disable function_body_length

class CollectionViewFlowLayoutTests: QuickSpec {
    override func spec() {
        let layout = UICollectionViewFlowLayout()

        let сollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        let section2 = 2
        let indexPath23 = IndexPath(row: 3, section: section2)

        let defaultRow = CollectionRow().withFlowAutomaticLayout()
        let defaultSection = CollectionFlowLayoutSection()

        let rowSize23 = CGSize(width: 10, height: 43)
        let row23 = CollectionRow().withFlowLayout(sizeCalculator: rowSize23)

        let headerSize2 = CGSize(width: 130, height: 143)
        let header2 = CollectionSupplementary().withFlowLayout(sizeCalculator: headerSize2)

        let footerSize2 = CGSize(width: 230, height: 243)
        let footer2 = CollectionSupplementary().withFlowLayout(sizeCalculator: footerSize2)

        let sectionConfiguration2 = CollectionFlowLayoutSectionConfiguration(
            inset: UIEdgeInsets(top: 12, left: 40, bottom: 33, right: 53),
            minimumLineSpacing: 34,
            minimumInteritemSpacing: 54
        )

        let dataProvider = [
            defaultSection,
            defaultSection,
            [
                defaultRow,
                defaultRow,
                defaultRow,
                row23
            ]
            .asFlowLayoutSection(header: header2, footer: footer2, layoutConfiguration: sectionConfiguration2)
        ]
        .asCollectionFlowLayoutDataProvider(layout: layout)

        var flowLayoutDelegate: UICollectionViewDelegateFlowLayout!

        beforeEach {
            flowLayoutDelegate = CollectionViewFlowLayout(layout: layout, dataSource: dataProvider)
        }

        describe(".init") {
            it("should return valid value") {
                let collectionViewFlowLayout = flowLayoutDelegate as? CollectionViewFlowLayout
                expect(collectionViewFlowLayout?.layout).to(beIdenticalTo(layout))
                expect(collectionViewFlowLayout?.dataSource).to(beIdenticalTo(dataProvider))
            }
        }

        describe(".deinit") {
            it("should reset layout delegate") {
                flowLayoutDelegate = nil
                expect(layout.customDelegate).to(beNil())
            }
        }

        describe(".forwardDelegate") {
            it("should equals to expected value") {
                let collectionViewFlowLayout = flowLayoutDelegate as? CollectionViewFlowLayout
                let flowLayoutDelegateMock = UICollectionViewDelegateFlowLayoutMock()
                collectionViewFlowLayout?.forwardDelegate = flowLayoutDelegateMock
                expect(collectionViewFlowLayout?.forwardDelegate).to(beIdenticalTo(flowLayoutDelegateMock))
            }

            it("should to be nil") {
                let collectionViewFlowLayout = flowLayoutDelegate as? CollectionViewFlowLayout
                collectionViewFlowLayout?.forwardDelegate = UICollectionViewDelegateFlowLayoutMock()
                expect(collectionViewFlowLayout?.forwardDelegate).to(beNil())
            }
        }

        describe(".sizeForItemAt") {
            it("should result equals to expected value") {
                let sizeForItem = flowLayoutDelegate.collectionView?(сollectionView, layout: layout, sizeForItemAt: indexPath23)
                expect(sizeForItem).to(equal(rowSize23))
            }
        }

        describe(".insetForSectionAt") {
            it("should result equals to expected value") {
                let insetForSection = flowLayoutDelegate.collectionView?(сollectionView, layout: layout, insetForSectionAt: section2)
                expect(insetForSection).to(equal(sectionConfiguration2.inset))
            }
        }

        describe(".minimumLineSpacingForSectionAt") {
            it("should result equals to expected value") {
                let minimumLineSpacingForSection = flowLayoutDelegate.collectionView?(
                    сollectionView,
                    layout: layout,
                    minimumLineSpacingForSectionAt: section2
                )
                expect(minimumLineSpacingForSection).to(equal(sectionConfiguration2.minimumLineSpacing))
            }
        }

        describe(".minimumInteritemSpacingForSectionAt") {
            it("should result equals to expected value") {
                let minimumInteritemSpacingForSection = flowLayoutDelegate.collectionView?(
                    сollectionView,
                    layout: layout,
                    minimumInteritemSpacingForSectionAt: section2
                )
                expect(minimumInteritemSpacingForSection).to(equal(sectionConfiguration2.minimumInteritemSpacing))
            }
        }

        describe(".referenceSizeForHeaderInSection") {
            it("should result equals to expected value") {
                let referenceSizeForHeader = flowLayoutDelegate.collectionView?(
                    сollectionView,
                    layout: layout,
                    referenceSizeForHeaderInSection: section2
                )
                expect(referenceSizeForHeader).to(equal(headerSize2))
            }
        }

        describe(".referenceSizeForFooterInSection") {
            it("should result equals to expected value") {
                let referenceSizeForFooter = flowLayoutDelegate.collectionView?(
                    сollectionView,
                    layout: layout,
                    referenceSizeForFooterInSection: section2
                )
                expect(referenceSizeForFooter).to(equal(footerSize2))
            }
        }
    }
}

// swiftlint:enable function_body_length

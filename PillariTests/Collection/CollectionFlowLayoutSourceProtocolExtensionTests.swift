//  Created by Anton Popkov on 16.11.17.

import Quick
import Nimble

@testable import Pillari

// swiftlint:disable type_name

class CollectionFlowLayoutSourceProtocolExtensionTests: QuickSpec {
    override func spec() {
        let layout = UICollectionViewFlowLayout()
        let dataSource = (0...4).map { _ -> CollectionFlowLayoutSection in
            return (0...4).map { _ in
                return CollectionRow<CollectionCellMock>().withFlowAutomaticLayout()
            }
            .asFlowLayoutSection(
                header: CollectionSupplementary<CollectionSupplementaryViewMock>().withFlowAutomaticLayout(),
                footer: CollectionSupplementary<CollectionSupplementaryViewMock>().withFlowAutomaticLayout()
            )
        }
        .asCollectionFlowLayoutDataProvider(layout: layout)

        describe(".rowLayout(section, row)") {
            it("should result equals to expected value") {
                let rowLayout = dataSource.rowLayout(section: 0, row: 2)
                expect(rowLayout).to(beIdenticalTo(dataSource.sectionsLayout[0].rowsLayout[2]))
            }
        }

        describe(".rowLayout(for)") {
            it("should result equals to expected value") {
                let rowLayout = dataSource.rowLayout(for: IndexPath(row: 2, section: 0))
                expect(rowLayout).to(beIdenticalTo(dataSource.sectionsLayout[0].rowsLayout[2]))
            }
        }

        describe(".sectionLayout(for)") {
            it("should result equals to expected value") {
                let sectionLayout = dataSource.sectionLayout(for: 1)
                expect(sectionLayout).to(beIdenticalTo(dataSource.sectionsLayout[1]))
            }
        }
    }
}

// swiftlint:enable type_name

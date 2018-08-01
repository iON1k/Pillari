//  Created by Anton Popkov on 22.11.17.

import Quick
import Nimble

@testable import Pillari

// swiftlint:disable type_name

class CollectionDataSourceProtocolExtensionTests: QuickSpec {
    override func spec() {
        let dataSource: CollectionDataSourceProtocol = (0...4).map { _ -> CollectionFlowLayoutSection in
            return (0...4).map { _ in
                return CollectionRow<CollectionVoidCellMock>().withFlowAutomaticLayout()
            }.asFlowLayoutSection(
                header: CollectionSupplementary<CollectionVoidSupplementaryViewMock>().withFlowAutomaticLayout(),
                footer: CollectionSupplementary<CollectionVoidSupplementaryViewMock>().withFlowAutomaticLayout()
            )
        }
        .asCollectionFlowLayoutDataProvider(layout: UICollectionViewFlowLayout())

        describe(".row(section, row)") {
            it("should result equals to expected row") {
                let row = dataSource.row(section: 0, row: 2)
                expect(row).to(beIdenticalTo(dataSource.sections[0].rows[2]))
            }
        }

        describe(".row(for)") {
            it("should result equals to expected row") {
                let row = dataSource.row(for: IndexPath(row: 2, section: 0))
                expect(row).to(beIdenticalTo(dataSource.sections[0].rows[2]))
            }
        }

        describe(".section(for)") {
            it("should result equals to expected section") {
                let section = dataSource.section(for: 1)
                expect(section).to(beIdenticalTo(dataSource.sections[1]))
            }
        }
    }
}

// swiftlint:enable type_name

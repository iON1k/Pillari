import Quickimport Nimble
@testable import Pillari

class ArrayColectionFlowLayoutTests: QuickSpec {
    override func spec() {
        let layout = UICollectionViewFlowLayout()
        let rows = gerenateRows(count: 5)

        let sections = (0...4).map { _ in
            return self.gerenateRows(count: 5).asFlowLayoutSection()
        }

        let header = CollectionSupplementary().withFlowAutomaticLayout()
        let footer = CollectionSupplementary().withFlowAutomaticLayout()

        describe(".asSection") {
            it("should return valid value") {
                let section = rows.asFlowLayoutSection(header: header, footer: footer)
                check(section: section)
            }

            it("[CollectionFlowLayoutRowProtocol] should return valid value") {
                let section = (rows as [CollectionFlowLayoutRowProtocol]).asFlowLayoutSection(header: header, footer: footer)
                check(section: section)
            }
        }

        describe(".asSections") {
            it("should return valid value") {
                let sections = rows.asFlowLayoutSections(header: header, footer: footer)
                check(sections: sections)
            }

            it("[CollectionFlowLayoutRowProtocol] should return valid value") {
                let sections = (rows as [CollectionFlowLayoutRowProtocol]).asFlowLayoutSections(header: header, footer: footer)
                check(sections: sections)
            }
        }

        describe(".asDataSource") {
            it("should return valid value") {
                let dataSource = sections.asCollectionFlowLayoutDataProvider(layout: layout)
                expectToIdential(dataSource.sections, to: sections)
            }

            it("[CollectionFlowLayoutSectionProtocol] should return valid value") {
                let dataSource = (sections as [CollectionFlowLayoutSectionProtocol]).asCollectionFlowLayoutDataProvider(layout: layout)
                expectToIdential(dataSource.sections, to: sections)
            }
        }

        func check(section: CollectionFlowLayoutSection) {
            expectToIdential(section.flowLayoutRows, to: rows)
            expect(section.flowLayoutHeader).to(beIdenticalTo(header))
            expect(section.flowLayoutFooter).to(beIdenticalTo(footer))
        }

        func check(sections: [CollectionFlowLayoutSection]) {
            expect(sections.count).to(equal(1))
            check(section: sections[0])
        }
    }

    func gerenateRows(count: Int) -> [CollectionFlowLayoutRowProtocol] {
        return (0...count - 1).map { _ in
            return CollectionRow().withFlowAutomaticLayout()
        }
    }
}

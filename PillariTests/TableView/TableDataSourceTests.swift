import Quick
import Nimble
@testable import Pillari

class TableDataSourceTests: QuickSpec {
    override func spec() {
        describe(".sections") {
            it("should equals to expected sections") {
                let sections = (0...4).map { _ in TableSection() }
                let dataSource = TableDataSource(sections: sections)

                expectToIdential(dataSource.sections, to: sections)
            }
        }
    }
}

import Quick
import Nimble
@testable import Pillari

class TableHeaderFooterConfigurationTests: QuickSpec {
    override func spec() {
        let title = "TestTitle"
        let configuration = TableHeaderFooterConfiguration(title: title)

        describe(".init") {
            it("should return valid configuration") {
                expect(configuration.title).to(equal(title))
            }
        }
    }
}

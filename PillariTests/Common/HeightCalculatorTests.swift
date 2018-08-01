import Quick
import Nimble
@testable import Pillari

class HeightCalculatorTests: QuickSpec {
    override func spec() {
        describe("calculateEstimatedHeight") {
            it("should result equals to calculateHeight result") {
                expect(HeightCalculatorMock.calculateEstimatedHeight(for: Void(), with: 0))
                    .to(equal(HeightCalculatorMock.calculateHeight(for: Void(), with: 0)))
            }
        }
    }

    class HeightCalculatorMock: HeightCalculator {
        static func calculateHeight(for configuration: Void, with width: CGFloat) -> CGFloat {
            return 100
        }
    }
}

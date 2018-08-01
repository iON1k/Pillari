//  Created by Anton Popkov on 09.11.17.

import Quick
import Nimble

@testable import Pillari

class ArraySafeExtensionTests: QuickSpec {
    override func spec() {
        let array = [1, 2, 3, 4, 5]

        describe("[safe]") {
            it("should result equals to nil") {
                expect(array[safe: 9999]).to(beNil())
            }

            it("should result equals to expected number") {
                expect(array[safe: 2]).to(equal(array[2]))
            }
        }

        describe("[try]") {
            it("should thtow assertion") {
                expect {
                    _ = array[try: 9999]

                }
                .to(throwAssertion())
            }
        }
    }
}

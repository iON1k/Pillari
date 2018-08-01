//  Created by Anton Popkov on 23.11.17.

import Quick
import Nimble

@testable import Pillari

class CollectionRowConfigurationTests: QuickSpec {
    override func spec() {
        let shouldHighlight = false
        let shouldSelect = false
        let shouldDeselect = false
        let shouldShowMenu = true
        let shouldSpringLoad = false
        let canMove = true
        let canFocus = false

        let configuration =
            CollectionRowConfiguration(
                should: CollectionRowConfiguration.Should(
                    highlight: shouldHighlight,
                    select: shouldSelect,
                    deselect: shouldDeselect,
                    showMenu: shouldShowMenu,
                    springLoad: shouldSpringLoad
                ),
                canMove: canMove,
                canFocus: canFocus
            )

        describe(".init") {
            it("should return valid configuration") {
                expect(configuration.should.highlight).to(equal(shouldHighlight))
                expect(configuration.should.select).to(equal(shouldSelect))
                expect(configuration.should.deselect).to(equal(shouldDeselect))
                expect(configuration.should.showMenu).to(equal(shouldShowMenu))
                expect(configuration.should.springLoad).to(equal(shouldSpringLoad))
                expect(configuration.canMove).to(equal(canMove))
                expect(configuration.canFocus).to(equal(canFocus))
            }
        }
    }
}

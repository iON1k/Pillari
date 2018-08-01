//  Created by Anton Popkov on 16.11.17.

import Quick
import Nimble

@testable import Pillari

// swiftlint:disable type_name

class UICollectionViewFlowLayoutCustomDelegateTests: QuickSpec {
    override func spec() {
        var layout: UICollectionViewFlowLayout!

        beforeEach {
            layout = UICollectionViewFlowLayout()
        }

        describe(".customDelegate") {
            it("should equals to expected value") {
                let expectedLayoutDelegate = DelegateMock(layout: layout)
                layout.customDelegate = expectedLayoutDelegate
                expect(layout.customDelegate).to(beIdenticalTo(expectedLayoutDelegate))
            }

            it("should to be nil") {
                layout.customDelegate = DelegateMock(layout: layout)
                expect(layout.customDelegate).to(beNil())
            }
        }
    }

    class DelegateMock: NSObject, UICollectionViewDelegateFlowLayout {
        private weak var layout: UICollectionViewFlowLayout?

        init(layout: UICollectionViewFlowLayout?) {
            self.layout = layout
            super.init()
        }

        deinit {
            layout?.customDelegate = nil
        }
    }
}

// swiftlint:enable type_name

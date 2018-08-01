//  Created by Anton Popkov on 14.11.17.

import Quick
import Nimble

@testable import Pillari

class CollectionElementSizeCalculatorTests: QuickSpec {
    override func spec() {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        let expectedSize = CGSize(width: 100, height: 150)

        let viewSizeCalculator = CollectionElementSizeCalculator { _ in return expectedSize }

        describe(".calculateSize(collectionView:)") {
            it("should calculated size equals to expected size") {
                expect(viewSizeCalculator.calculateSize(with: collectionView)).to(equal(expectedSize))
            }
        }
    }
}

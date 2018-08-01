//  Created by Anton Popkov on 16.11.17.

import Quick
import Nimble

@testable import Pillari

// swiftlint:disable type_name

class CGSizeCollectionElementSizeCalculatorProtocolTests: QuickSpec {
    override func spec() {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        let size = CGSize(width: 34, height: 58)

        describe(".calculateSize(with:)") {
            it("should calculated height equals to self") {
                expect(size.calculateSize(with: collectionView)).to(equal(size))
            }
        }
    }
}

// swiftlint:enable type_name

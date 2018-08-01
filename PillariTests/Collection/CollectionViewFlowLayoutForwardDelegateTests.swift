//  Created by Anton Popkov on 15.11.17.

import Quick
import Nimble

@testable import Pillari

// swiftlint:disable type_name

class CollectionViewFlowLayoutForwardDelegateTests: QuickSpec {
    override func spec() {
        let layout = UICollectionViewFlowLayout()

        let collectionViewFlowLayout = CollectionViewFlowLayout(
            layout: layout,
            dataSource: CollectionFlowLayoutDataProvider(layout: layout)
        )

        let flowLayoutDelegateMock = UICollectionViewDelegateFlowLayoutMock()
        collectionViewFlowLayout.forwardDelegate = flowLayoutDelegateMock

        collectionViewDelegateFlowLayoutEventsTest(sourceDelegate: collectionViewFlowLayout,
                                                   forwardDelegateMock: flowLayoutDelegateMock,
                                                   layout: layout)
    }
}

// swiftlint:enable type_name

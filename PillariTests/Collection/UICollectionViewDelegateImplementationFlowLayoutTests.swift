//  Created by Anton Popkov on 29.11.2017.

import Quick
import Nimble

@testable import Pillari

// swiftlint:disable type_name

class UICollectionViewDelegateImplementationFlowLayoutTests: QuickSpec {
    override func spec() {
        let layout = UICollectionViewFlowLayout()
        let dataProvider =
            Array(repeating: CollectionRow<CollectionVoidCellMock>().withFlowLayout(), count: 5)
                .asFlowLayoutSections()
                .asCollectionFlowLayoutDataProvider(layout: layout)
        let delegateImplementation = UICollectionViewDelegateImplementation(dataSource: dataProvider)

        let flowLayoutDelegateMock = UICollectionViewDelegateFlowLayoutMock()
        layout.customDelegate = flowLayoutDelegateMock

        collectionViewDelegateFlowLayoutEventsTest(sourceDelegate: delegateImplementation,
                                                   forwardDelegateMock: flowLayoutDelegateMock,
                                                   layout: layout)
    }
}

// swiftlint:enable type_name

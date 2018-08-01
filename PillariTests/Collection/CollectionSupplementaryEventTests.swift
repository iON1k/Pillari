//  Created by Anton Popkov on 23.11.17.

import Quick
import Nimble

@testable import Pillari

class CollectionSupplementaryEventTests: QuickSpec {
    override func spec() {
        let indexPath = IndexPath(row: 3, section: 5)
        let kind = "TestKind"
        let collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        let view = UICollectionReusableView()
        let events = [
            CollectionSupplementaryEvent.didConfigure(context: (collection: collection, view: view, kind: kind, index: indexPath)),
            CollectionSupplementaryEvent.willDisplay(context: (collection: collection, view: view, kind: kind, index: indexPath)),
            CollectionSupplementaryEvent.didEndDisplaying(context: (collection: collection, view: view, kind: kind, index: indexPath))
        ]

        describe(".supplementaryKind") {
            it("should return expected value") {
                for event in events {
                    expect(event.supplementaryKind).to(equal(kind))
                }
            }
        }

        describe(".supplementaryIndex") {
            it("should return expected value") {
                for event in events {
                    expect(event.supplementaryIndex).to(equal(indexPath))
                }
            }
        }
    }
}

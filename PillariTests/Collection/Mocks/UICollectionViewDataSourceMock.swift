import UIKit

class UICollectionViewDataSourceMock: NSObject {
    enum Event {
        case numberOfItems(UICollectionView, Int)
        case cellForItem(UICollectionView, IndexPath)
        case numberOfSections(UICollectionView)
        case viewForSupplementaryElement(UICollectionView, String, IndexPath)
        case canMoveItem(UICollectionView, IndexPath)
        case moveItem(UICollectionView, IndexPath, IndexPath)
        case indexTitles(UICollectionView)
        case indexPathForIndexTitle(UICollectionView, String, Int)
    }

    var events: [Event] {
        return eventsHandler.events
    }

    private let eventsHandler = EventsHandlerMock<Event>()

    let numberOfSections = 10
    let viewForSupplementaryElement = UICollectionReusableView()
    let canMoveItem = true
    let indexTitles = [
        "Test1",
        "Test2",
        "Test3"
    ]

    let indexPathForIndexTitle = IndexPath(row: 5, section: 11)
}

extension UICollectionViewDataSourceMock: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        eventsHandler.onEvent(event: .numberOfItems(collectionView, section))
        return 0
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        eventsHandler.onEvent(event: .cellForItem(collectionView, indexPath))
        return UICollectionViewCell()
    }

    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        eventsHandler.onEvent(event: .numberOfSections(collectionView))
        return numberOfSections
    }

    public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String,
                               at indexPath: IndexPath) -> UICollectionReusableView {
        eventsHandler.onEvent(event: .viewForSupplementaryElement(collectionView, kind, indexPath))
        return viewForSupplementaryElement
    }

    @available(iOS 9.0, *)
    public func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        eventsHandler.onEvent(event: .canMoveItem(collectionView, indexPath))
        return canMoveItem
    }

    @available(iOS 9.0, *)
    public func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        eventsHandler.onEvent(event: .moveItem(collectionView, sourceIndexPath, destinationIndexPath))
    }

    public func indexTitles(for collectionView: UICollectionView) -> [String]? {
        eventsHandler.onEvent(event: .indexTitles(collectionView))
        return indexTitles
    }

    public func collectionView(_ collectionView: UICollectionView, indexPathForIndexTitle title: String, at index: Int) -> IndexPath {
        eventsHandler.onEvent(event: .indexPathForIndexTitle(collectionView, title, index))
        return indexPathForIndexTitle
    }
}

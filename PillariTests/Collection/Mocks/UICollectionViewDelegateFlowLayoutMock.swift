//  Created by Anton Popkov on 13.11.17.

import UIKit

class UICollectionViewDelegateFlowLayoutMock: NSObject {
    enum Event {
        case sizeForItem(UICollectionView, UICollectionViewLayout, IndexPath)
        case insetForSection(UICollectionView, UICollectionViewLayout, Int)
        case minimumLineSpacingForSection(UICollectionView, UICollectionViewLayout, Int)
        case minimumInteritemSpacingForSection(UICollectionView, UICollectionViewLayout, Int)
        case referenceSizeForHeader(UICollectionView, UICollectionViewLayout, Int)
        case referenceSizeForFooter(UICollectionView, UICollectionViewLayout, Int)
    }

    var events: [Event] {
        return eventsHandler.events
    }

    private let eventsHandler = EventsHandlerMock<Event>()

    let referenceSizeForHeader = CGSize(width: 200, height: 150)
    let referenceSizeForFooter = CGSize(width: 100, height: 50)
    let sizeForItem = CGSize(width: 20, height: 30)
    let insetForSection = UIEdgeInsets(top: 20, left: 30, bottom: 80, right: 120)
    let minimumLineSpacingForSection: CGFloat = 67
    let minimumInteritemSpacingForSection: CGFloat = 26
}

extension UICollectionViewDelegateFlowLayoutMock: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        eventsHandler.onEvent(event: .sizeForItem(collectionView, layout, indexPath))
        return sizeForItem
    }

    public func collectionView(_ collectionView: UICollectionView,
                               layout: UICollectionViewLayout, insetForSectionAt sectionIndex: Int) -> UIEdgeInsets {
        eventsHandler.onEvent(event: .insetForSection(collectionView, layout, sectionIndex))
        return insetForSection
    }

    public func collectionView(_ collectionView: UICollectionView,
                               layout: UICollectionViewLayout, minimumLineSpacingForSectionAt sectionIndex: Int) -> CGFloat {
        eventsHandler.onEvent(event: .minimumLineSpacingForSection(collectionView, layout, sectionIndex))
        return minimumLineSpacingForSection
    }

    public func collectionView(_ collectionView: UICollectionView,
                               layout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt sectionIndex: Int) -> CGFloat {
        eventsHandler.onEvent(event: .minimumInteritemSpacingForSection(collectionView, layout, sectionIndex))
        return minimumInteritemSpacingForSection
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        eventsHandler.onEvent(event: .referenceSizeForHeader(collectionView, collectionViewLayout, section))
        return referenceSizeForHeader
    }

    public func collectionView(_ collectionView: UICollectionView,
                               layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        eventsHandler.onEvent(event: .referenceSizeForFooter(collectionView, collectionViewLayout, section))
        return referenceSizeForFooter
    }

    func resetEvents() {
        eventsHandler.resetEvents()
    }
}

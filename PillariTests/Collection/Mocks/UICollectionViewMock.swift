import UIKit

class UICollectionViewMock: UICollectionView {
    enum Event {
        case registerCell(AnyClass?, String)
        case registerCellNib(UINib?, String)
        case registerSupplementary(AnyClass?, String, String)
        case registerSupplementaryNib(UINib?, String, String)
        case dequeueReusableCell(String, IndexPath)
        case dequeueReusableSupplementary(String, String, IndexPath)
    }

    let elementsFactory = UICollectionElementsFactory()

    var events: [Event] {
        return eventsHandler.events
    }

    var shouldRegisterCellsAndSupplementaries = true

    private var eventsHandler = EventsHandlerMock<Event>()

    override func register(_ cellClass: AnyClass?, forCellWithReuseIdentifier identifier: String) {
        guard shouldRegisterCellsAndSupplementaries else { return }

        eventsHandler.onEvent(event: .registerCell(cellClass, identifier))
        elementsFactory.registerCell(reuseId: identifier) {
            let cell = (cellClass as? UICollectionViewCell.Type)?.init()

            if let cellMock = cell as? UICollectionViewCellMock {
                cellMock.customReuseId = identifier
            }

            return cell ?? UICollectionViewCell()
        }
    }

    override func register(_ nib: UINib?, forCellWithReuseIdentifier identifier: String) {
        guard shouldRegisterCellsAndSupplementaries else { return }

        eventsHandler.onEvent(event: .registerCellNib(nib, identifier))
    }

    override func register(_ viewClass: AnyClass?, forSupplementaryViewOfKind elementKind: String,
                           withReuseIdentifier identifier: String) {
        guard shouldRegisterCellsAndSupplementaries else { return }

        eventsHandler.onEvent(event: .registerSupplementary(viewClass, elementKind, identifier))
        elementsFactory.registerSupplementary(kind: elementKind, reuseId: identifier) {
            let view = (viewClass as? UICollectionReusableView.Type)?.init()

            if let viewMock = view as? UICollectionReusableViewMock {
                viewMock.customReuseId = identifier
            }

            return view ?? UICollectionReusableView()
        }
    }

    override func register(_ nib: UINib?, forSupplementaryViewOfKind kind: String,
                           withReuseIdentifier identifier: String) {
        guard shouldRegisterCellsAndSupplementaries else { return }

        eventsHandler.onEvent(event: .registerSupplementaryNib(nib, kind, identifier))
    }

    override func dequeueReusableCell(withReuseIdentifier identifier: String,
                                      for indexPath: IndexPath) -> UICollectionViewCell {
        eventsHandler.onEvent(event: .dequeueReusableCell(identifier, indexPath))
        return elementsFactory.dequeueCell(reuseId: identifier)
    }

    override func dequeueReusableSupplementaryView(ofKind elementKind: String,
                                                   withReuseIdentifier identifier: String,
                                                   for indexPath: IndexPath) -> UICollectionReusableView {
        eventsHandler.onEvent(event: .dequeueReusableSupplementary(elementKind, identifier, indexPath))
        return elementsFactory.dequeueSupplementary(kind: elementKind, reuseId: identifier)
    }

    func resetEvents() {
        eventsHandler = EventsHandlerMock()
    }
}

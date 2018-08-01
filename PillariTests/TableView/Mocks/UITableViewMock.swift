import UIKit

class UITableViewMock: UITableView {
    enum Event {
        case registerCell(AnyClass?, String)
        case registerCellNib(UINib?, String)
        case registerHeaderFooter(AnyClass?, String)
        case registerHeaderFooterNib(UINib?, String)
        case dequeueReusableCell(String)
        case dequeueReusableHeaderFooterView(String)
    }

    var events: [Event] {
        return eventsHandler.events
    }

    private let eventsHandler = EventsHandlerMock<Event>()

    var shouldRegisterCellsAndViews = true

    override func register(_ cellClass: AnyClass?, forCellReuseIdentifier identifier: String) {
        guard shouldRegisterCellsAndViews else { return }

        super.register(cellClass, forCellReuseIdentifier: identifier)
        eventsHandler.onEvent(event: .registerCell(cellClass, identifier))
    }

    override func register(_ nib: UINib?, forCellReuseIdentifier identifier: String) {
        guard shouldRegisterCellsAndViews else { return }

        super.register(nib, forCellReuseIdentifier: identifier)
        eventsHandler.onEvent(event: .registerCellNib(nib, identifier))
    }

    override func register(_ aClass: AnyClass?, forHeaderFooterViewReuseIdentifier identifier: String) {
        guard shouldRegisterCellsAndViews else { return }

        super.register(aClass, forHeaderFooterViewReuseIdentifier: identifier)
        eventsHandler.onEvent(event: .registerHeaderFooter(aClass, identifier))
    }

    override func register(_ nib: UINib?, forHeaderFooterViewReuseIdentifier identifier: String) {
        guard shouldRegisterCellsAndViews else { return }

        super.register(nib, forHeaderFooterViewReuseIdentifier: identifier)
        eventsHandler.onEvent(event: .registerHeaderFooterNib(nib, identifier))
    }

    override func dequeueReusableCell(withIdentifier identifier: String) -> UITableViewCell? {
        eventsHandler.onEvent(event: .dequeueReusableCell(identifier))
        return super.dequeueReusableCell(withIdentifier: identifier)
    }

    override func dequeueReusableHeaderFooterView(withIdentifier identifier: String) -> UITableViewHeaderFooterView? {
        eventsHandler.onEvent(event: .dequeueReusableHeaderFooterView(identifier))
        return super.dequeueReusableHeaderFooterView(withIdentifier: identifier)
    }
}

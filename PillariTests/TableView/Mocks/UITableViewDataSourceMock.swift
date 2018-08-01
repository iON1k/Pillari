import UIKit

class UITableViewDataSourceMock: NSObject {
    enum Event {
        case numberOfRows(UITableView, Int)
        case cellForRow(UITableView, IndexPath)
        case numberOfSections(UITableView)
        case titleForHeader(UITableView, Int)
        case titleForFooter(UITableView, Int)
        case canEditRow(UITableView, IndexPath)
        case canMoveRow(UITableView, IndexPath)
        case sectionIndexTitles(UITableView)
        case sectionForSectionIndexTitle(UITableView, String, Int)
        case commitEditingStyle(UITableView, UITableViewCellEditingStyle, IndexPath)
        case moveRow(UITableView, IndexPath, IndexPath)
    }

    var events: [Event] {
        return eventsHandler.events
    }

    private let eventsHandler = EventsHandlerMock<Event>()

    let numberOfSections = 10
    let titleForHeader = "TestTitleForHeader"
    let titleForFooter = "TestTitleForFooter"
    let canEditRow = true
    let canMoveRow = true
    let sectionIndexTitles = ["Test1", "Test2", "Test3"]
    let sectionForSectionIndexTitle = 13
}

extension UITableViewDataSourceMock: UITableViewDataSource {

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        eventsHandler.onEvent(event: .numberOfRows(tableView, section))
        return 0
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        eventsHandler.onEvent(event: .cellForRow(tableView, indexPath))
        return UITableViewCell()
    }

    public func numberOfSections(in tableView: UITableView) -> Int {
        eventsHandler.onEvent(event: .numberOfSections(tableView))
        return numberOfSections
    }

    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        eventsHandler.onEvent(event: .titleForHeader(tableView, section))
        return titleForHeader
    }

    public func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        eventsHandler.onEvent(event: .titleForFooter(tableView, section))
        return titleForFooter
    }

    public func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        eventsHandler.onEvent(event: .canEditRow(tableView, indexPath))
        return canEditRow
    }

    public func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        eventsHandler.onEvent(event: .canMoveRow(tableView, indexPath))
        return canMoveRow
    }

    public func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        eventsHandler.onEvent(event: .sectionIndexTitles(tableView))
        return sectionIndexTitles
    }

    public func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        eventsHandler.onEvent(event: .sectionForSectionIndexTitle(tableView, title, index))
        return sectionForSectionIndexTitle
    }

    public func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle,
                          forRowAt indexPath: IndexPath) {
        eventsHandler.onEvent(event: .commitEditingStyle(tableView, editingStyle, indexPath))
    }

    public func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath,
                          to destinationIndexPath: IndexPath) {
        eventsHandler.onEvent(event: .moveRow(tableView, sourceIndexPath, destinationIndexPath))
    }
}

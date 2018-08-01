//  Created by Anton Popkov on 12.09.17.

public enum TableRowEvent {
    case didConfigure(context: (table: UITableView, cell: UITableViewCell, index: IndexPath))
    case willSelect(context: (table: UITableView, index: IndexPath))
    case willDeselect(context: (table: UITableView, index: IndexPath))
    case didSelect(context: (table: UITableView, index: IndexPath))
    case didDeselect(context: (table: UITableView, index: IndexPath))
    case didHighlight(context: (table: UITableView, index: IndexPath))
    case didUnhighlight(context: (table: UITableView, index: IndexPath))
    case willDisplay(context: (table: UITableView, cell: UITableViewCell, index: IndexPath))
    case didEndDisplaying(context: (table: UITableView, cell: UITableViewCell, index: IndexPath))
    case commitEditing(context: (table: UITableView, editingStyle: UITableViewCellEditingStyle, index: IndexPath))
    case move(context: (table: UITableView, sourceIndex: IndexPath, destinationIndex: IndexPath))
    case accessoryButtonTapped(context: (table: UITableView, index: IndexPath))
    case willBeginEditing(context: (table: UITableView, index: IndexPath))
    case didEndEditing(context: (table: UITableView, index: IndexPath))
    case performAction(context: (table: UITableView, action: Selector, index: IndexPath, sender: Any?))
}

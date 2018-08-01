public enum TableHeaderFooterEvent {
    case didConfigure(context: (table: UITableView, view: UIView, section: Int))
    case willDisplay(context: (table: UITableView, view: UIView, section: Int))
    case didEndDisplaying(context: (table: UITableView, view: UIView, section: Int))
}

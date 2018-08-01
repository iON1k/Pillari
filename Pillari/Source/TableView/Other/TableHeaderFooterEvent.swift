public enum TableHeaderFooterEvent {
    public typealias Context = (table: UITableView, view: UIView, section: Int)

    case didConfigure(context: Context)
    case willDisplay(context: Context)
    case didEndDisplaying(context: Context)
}

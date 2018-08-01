public protocol TableHeaderFooterFactoryProtocol {
    func createView(for tableView: UITableView, with section: Int) -> UIView
}

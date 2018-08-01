public protocol TableCellFactoryProtocol {
    func createCell(for tableView: UITableView, with indexPath: IndexPath) -> UITableViewCell
}

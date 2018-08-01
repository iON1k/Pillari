//  Created by Anton Popkov on 26.10.17.

public protocol TableCellFactoryProtocol {
    func createCell(for tableView: UITableView, with indexPath: IndexPath) -> UITableViewCell
}

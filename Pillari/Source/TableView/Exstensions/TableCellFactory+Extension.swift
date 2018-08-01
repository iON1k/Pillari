//  Created by Anton Popkov on 26.10.17.

public extension TableCellFactory {
    convenience init<TCell: UITableViewCell>(_ cellType: TCell.Type, reuseId: String? = nil) {
        self.init { tableView, _ in
            guard let cell = tableView.dequeueReusableCellWithAutoregistration(cellType, reuseId: reuseId) else {
                return TCell()
            }

            return cell
        }
    }

    convenience init<TCell: UITableViewCell>(_ cellType: TCell.Type, item: TCell.Configuration, reuseId: String? = nil) where TCell: Configurable {
        self.init { tableView, _ in
            guard let cell = tableView.dequeueReusableCellWithAutoregistration(cellType, reuseId: reuseId) else {
                return TCell()
            }

            cell.configure(with: item)
            return cell
        }
    }
}

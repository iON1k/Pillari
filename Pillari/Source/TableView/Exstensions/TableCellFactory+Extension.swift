public extension TableCellFactory {
    convenience init<TCell: UITableViewCell>(_ cellType: TCell.Type, reuseId: String? = nil) {
        self.init { tableView, _ in
            tableView.dequeueReusableCellWithAutoregistration(cellType, reuseId: reuseId)
        }
    }

    convenience init<TCell: UITableViewCell>(_ cellType: TCell.Type, item: TCell.Configuration, reuseId: String? = nil) where TCell: Configurable {
        self.init { tableView, _ in
            let cell = tableView.dequeueReusableCellWithAutoregistration(cellType, reuseId: reuseId)
            cell.configure(with: item)
            return cell
        }
    }
}

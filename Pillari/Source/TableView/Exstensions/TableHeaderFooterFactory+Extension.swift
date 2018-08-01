public extension TableHeaderFooterFactory {
    convenience init<TView: UITableViewHeaderFooterView>(_ viewType: TView.Type, reuseId: String? = nil) {
        self.init { tableView, _ in
            tableView.dequeueReusableHeaderFooterViewWithAutoregistration(viewType, reuseId: reuseId)
        }
    }

    convenience init<TView: UITableViewHeaderFooterView>(_ viewType: TView.Type, item: TView.Configuration,
                                                         reuseId: String? = nil) where TView: Configurable {
        self.init { tableView, _ in
            let view = tableView.dequeueReusableHeaderFooterViewWithAutoregistration(viewType, reuseId: reuseId)
            view.configure(with: item)
            return view
        }
    }
}

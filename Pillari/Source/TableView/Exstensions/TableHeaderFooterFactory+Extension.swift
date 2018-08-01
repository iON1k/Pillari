//  Created by Anton Popkov on 26.10.17.

public extension TableHeaderFooterFactory {
    convenience init<TView: UITableViewHeaderFooterView>(_ viewType: TView.Type, reuseId: String? = nil) {
        self.init { tableView, _ in
            guard let view = tableView.dequeueReusableHeaderFooterViewWithAutoregistration(viewType, reuseId: reuseId) else {
                return TView()
            }

            return view
        }
    }

    convenience init<TView: UITableViewHeaderFooterView>(_ viewType: TView.Type, item: TView.Configuration,
                                                         reuseId: String? = nil) where TView: Configurable {
        self.init { tableView, _ in
            guard let view = tableView.dequeueReusableHeaderFooterViewWithAutoregistration(viewType, reuseId: reuseId) else {
                return TView()
            }

            view.configure(with: item)
            return view
        }
    }
}

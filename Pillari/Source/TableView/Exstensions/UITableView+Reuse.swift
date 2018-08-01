public extension UITableView {
    func registerCell<TCell: UITableViewCell>(_ cellType: TCell.Type, reuseId: String? = nil) {
        let normalizedReuseId = reuseId ?? UITableView.defaultReuseId(for: cellType)

        if let nibCellType = cellType as? NibViewProtocol.Type {
            register(nibCellType.nib, forCellReuseIdentifier: normalizedReuseId)
        } else {
            register(cellType, forCellReuseIdentifier: normalizedReuseId)
        }
    }

    func registerHeaderFooterView<TView: UITableViewHeaderFooterView>(_ viewType: TView.Type, reuseId: String? = nil) {
        let normalizedReuseId = reuseId ?? UITableView.defaultReuseId(for: viewType)
        if let nibViewType = viewType as? NibViewProtocol.Type {
            register(nibViewType.nib, forHeaderFooterViewReuseIdentifier: normalizedReuseId)
        } else {
            register(viewType, forHeaderFooterViewReuseIdentifier: normalizedReuseId)
        }
    }

    func dequeueReusableCell<TCell: UITableViewCell>(_ cellType: TCell.Type, reuseId: String? = nil) -> TCell? {
        let normalizedReuseId = reuseId ?? UITableView.defaultReuseId(for: cellType)
        return dequeueReusableCell(withIdentifier: normalizedReuseId) as? TCell
    }

    func dequeueReusableCellWithAutoregistration<TCell: UITableViewCell>(_ cellType: TCell.Type, reuseId: String? = nil) -> TCell {
        registerCell(cellType, reuseId: reuseId)

        guard let cell = dequeueReusableCell(cellType, reuseId: reuseId) else {
            assertionFailure("UITableView can not dequeue cell with type \(cellType) "
                + "for reuseId \(reuseId ?? UITableView.defaultReuseId(for: cellType))")
            return TCell()
        }

        return cell
    }

    func dequeueReusableHeaderFooterView<TView: UITableViewHeaderFooterView>(_ viewType: TView.Type, reuseId: String? = nil) -> TView? {
        let normalizedReuseId = reuseId ?? UITableView.defaultReuseId(for: viewType)
        return dequeueReusableHeaderFooterView(withIdentifier: normalizedReuseId) as? TView
    }

    func dequeueReusableHeaderFooterViewWithAutoregistration<TView: UITableViewHeaderFooterView>(_ viewType: TView.Type,
                                                                                                 reuseId: String? = nil) -> TView {
        registerHeaderFooterView(viewType, reuseId: reuseId)

        guard let view = dequeueReusableHeaderFooterView(viewType, reuseId: reuseId) else {
            assertionFailure("UITableView can not dequeue header/footer view with type \(viewType) "
                + "for reuseId \(reuseId ?? UITableView.defaultReuseId(for: viewType))")
            return TView()
        }

        return view
    }

    static func defaultReuseId(for viewType: UIView.Type) -> String {
        return String(describing: viewType)
    }
}

//  Created by Anton Popkov on 25.10.17.

public extension UICollectionView {
    func registerCell<TCell: UICollectionViewCell>(_ cellType: TCell.Type, reuseId: String? = nil) {
        let normalizedReuseId = reuseId ?? UICollectionView.defaultReuseId(for: cellType)

        if let nibCellType = cellType as? NibViewProtocol.Type {
            register(nibCellType.nib, forCellWithReuseIdentifier: normalizedReuseId)
        } else {
            register(cellType, forCellWithReuseIdentifier: normalizedReuseId)
        }
    }

    func registerSupplementaryView<TView: UICollectionReusableView>(_ viewType: TView.Type, kind: String, reuseId: String? = nil) {
        let normalizedReuseId = reuseId ?? UICollectionView.defaultReuseId(for: viewType)
        if let nibViewType = viewType as? NibViewProtocol.Type {
            register(nibViewType.nib, forSupplementaryViewOfKind: kind, withReuseIdentifier: normalizedReuseId)
        } else {
            register(viewType, forSupplementaryViewOfKind: kind, withReuseIdentifier: normalizedReuseId)
        }
    }

    func dequeueReusableCell<TCell: UICollectionViewCell>(_ cellType: TCell.Type, indexPath: IndexPath,
                                                          reuseId: String? = nil) -> TCell? {
        let normalizedReuseId = reuseId ?? UICollectionView.defaultReuseId(for: cellType)
        return dequeueReusableCell(withReuseIdentifier: normalizedReuseId, for: indexPath) as? TCell
    }

    func dequeueReusableCellWithAutoregistration<TCell: UICollectionViewCell>(_ cellType: TCell.Type,
                                                                              indexPath: IndexPath, reuseId: String? = nil) -> TCell? {
        registerCell(cellType, reuseId: reuseId)

        let cell = dequeueReusableCell(cellType, indexPath: indexPath, reuseId: reuseId)
        assert(cell != nil, "UICollectionView can not dequeue cell with type \(cellType) "
            + "for reuseId \(reuseId ?? UICollectionView.defaultReuseId(for: cellType))")

        return cell
    }

    func dequeueReusableSupplementaryView<TView: UICollectionReusableView>(
        _ viewType: TView.Type, kind: String, indexPath: IndexPath, reuseId: String? = nil) -> TView? {
        let normalizedReuseId = reuseId ?? UICollectionView.defaultReuseId(for: viewType)
        return dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: normalizedReuseId, for: indexPath) as? TView
    }

    func dequeueReusableSupplementaryViewWithAutoregistration<TView: UICollectionReusableView>(
        _ viewType: TView.Type, kind: String, indexPath: IndexPath, reuseId: String? = nil) -> TView? {
        registerSupplementaryView(viewType, kind: kind, reuseId: reuseId)

        let view = dequeueReusableSupplementaryView(viewType, kind: kind, indexPath: indexPath, reuseId: reuseId)
        assert(view != nil, "UICollectionView can not dequeue supplementary view with type \(viewType) "
            + "for reuseId \(reuseId ?? UICollectionView.defaultReuseId(for: viewType))")

        return view
    }

    static func defaultReuseId(for viewType: UICollectionReusableView.Type) -> String {
        return String(describing: viewType)
    }
}

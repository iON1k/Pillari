public extension CollectionCellFactory {
    convenience init<TCell: UICollectionViewCell>(_ cellType: TCell.Type, reuseId: String? = nil) {
        self.init { collectionView, indexPath in
            collectionView.dequeueReusableCellWithAutoregistration(cellType, indexPath: indexPath, reuseId: reuseId)
        }
    }

    convenience init<TCell: UICollectionViewCell>(_ cellType: TCell.Type,
                                                  item: TCell.Configuration, reuseId: String? = nil) where TCell: Configurable {
        self.init { collectionView, indexPath in
            let cell = collectionView.dequeueReusableCellWithAutoregistration(cellType, indexPath: indexPath, reuseId: reuseId)
            cell.configure(with: item)
            return cell
        }
    }
}

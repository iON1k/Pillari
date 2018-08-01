//  Created by Anton Popkov on 27.10.17.

public extension CollectionCellFactory {
    convenience init<TCell: UICollectionViewCell>(_ cellType: TCell.Type, reuseId: String? = nil) {
        self.init { collectionView, indexPath in
            guard let cell = collectionView.dequeueReusableCellWithAutoregistration(cellType, indexPath: indexPath, reuseId: reuseId) else {
                return TCell()
            }

            return cell
        }
    }

    convenience init<TCell: UICollectionViewCell>(_ cellType: TCell.Type,
                                                  item: TCell.Configuration, reuseId: String? = nil) where TCell: Configurable {
        self.init { collectionView, indexPath in
            guard let cell = collectionView.dequeueReusableCellWithAutoregistration(cellType, indexPath: indexPath, reuseId: reuseId) else {
                return TCell()
            }

            cell.configure(with: item)
            return cell
        }
    }
}

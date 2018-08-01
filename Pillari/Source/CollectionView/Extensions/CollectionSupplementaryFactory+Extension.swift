public extension CollectionSupplementaryFactory {
    convenience init<TView: UICollectionReusableView>(_ viewType: TView.Type, reuseId: String? = nil) {
        self.init { collectionView, kind, indexPath in
            collectionView.dequeueReusableSupplementaryViewWithAutoregistration(viewType, kind: kind, indexPath: indexPath, reuseId: reuseId)
        }
    }

    convenience init<TView: UICollectionReusableView>(_ viewType: TView.Type,
                                                      item: TView.Configuration, reuseId: String? = nil) where TView: Configurable {
        self.init { collectionView, kind, indexPath in
            let view = collectionView.dequeueReusableSupplementaryViewWithAutoregistration(
                viewType,
                kind: kind,
                indexPath: indexPath,
                reuseId: reuseId
            )

            view.configure(with: item)
            return view
        }
    }
}

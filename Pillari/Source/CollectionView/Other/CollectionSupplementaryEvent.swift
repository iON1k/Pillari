//  Created by Anton Popkov on 23.10.17.

public enum CollectionSupplementaryEvent {
    case didConfigure(context: (collection: UICollectionView, view: UICollectionReusableView, kind: String, index: IndexPath))
    case willDisplay(context: (collection: UICollectionView, view: UICollectionReusableView, kind: String, index: IndexPath))
    case didEndDisplaying(context: (collection: UICollectionView, view: UICollectionReusableView, kind: String, index: IndexPath))
}

public extension CollectionSupplementaryEvent {
    var supplementaryKind: String {
        switch self {
        case .willDisplay(let context):
            return context.kind
        case .didEndDisplaying(let context):
            return context.kind
        case .didConfigure(let context):
            return context.kind
        }
    }

    var supplementaryIndex: IndexPath {
        switch self {
        case .willDisplay(let context):
            return context.index
        case .didEndDisplaying(let context):
            return context.index
        case .didConfigure(let context):
            return context.index
        }
    }
}

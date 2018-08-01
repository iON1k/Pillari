public enum CollectionSupplementaryEvent {
    public typealias Context = (collection: UICollectionView, view: UICollectionReusableView, kind: String, index: IndexPath)

    case didConfigure(context: Context)
    case willDisplay(context: Context)
    case didEndDisplaying(context: Context)
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

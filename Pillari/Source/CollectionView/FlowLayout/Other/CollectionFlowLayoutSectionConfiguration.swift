//  Created by Anton Popkov on 24.10.17.

public struct CollectionFlowLayoutSectionConfiguration {
    public var inset: UIEdgeInsets
    public var minimumLineSpacing: CGFloat
    public var minimumInteritemSpacing: CGFloat

    public init(inset: UIEdgeInsets = .zero, minimumLineSpacing: CGFloat = 0, minimumInteritemSpacing: CGFloat = 0) {
        self.inset = inset
        self.minimumLineSpacing = minimumLineSpacing
        self.minimumInteritemSpacing = minimumInteritemSpacing
    }

    public static let `default` = CollectionFlowLayoutSectionConfiguration()
}

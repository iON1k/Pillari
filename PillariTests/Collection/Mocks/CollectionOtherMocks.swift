@testable import Pillari

class UICollectionViewCellMock: UICollectionViewCell {
    override var reuseIdentifier: String? {
        return customReuseId ?? super.reuseIdentifier
    }

    var customReuseId: String?
}

class CollectionNibCellMock: UICollectionViewCellMock, NibViewProtocol {
    static let nib = UINib()
}

class CollectionVoidCellMock: UICollectionViewCellMock, HeightCalculator {
    static let defaultHeight: CGFloat = 30

    static func calculateHeight(for item: Void, with width: CGFloat) -> CGFloat {
        return defaultHeight
    }
}

class CollectionCellMock: UICollectionViewCellMock, Configurable, HeightCalculator {
    static let defaultHeight: CGFloat = 50

    var viewModel: ViewModelMock?

    static func calculateHeight(for item: ViewModelMock, with width: CGFloat) -> CGFloat {
        return defaultHeight
    }

    func configure(with viewModel: ViewModelMock) {
        self.viewModel = viewModel
    }
}

class UICollectionReusableViewMock: UICollectionReusableView {
    override var reuseIdentifier: String? {
        return customReuseId ?? super.reuseIdentifier
    }

    var customReuseId: String?
}

class CollectionNibSupplementaryViewMock: UICollectionReusableViewMock, NibViewProtocol {
    static let nib = UINib()
}

class CollectionVoidSupplementaryViewMock: UICollectionReusableViewMock, HeightCalculator {
    static let defaultHeight: CGFloat = 67

    static func calculateHeight(for item: Void, with width: CGFloat) -> CGFloat {
        return defaultHeight
    }
}

class CollectionSupplementaryViewMock: UICollectionReusableViewMock, Configurable, HeightCalculator {
    static let defaultHeight: CGFloat = 120

    var viewModel: ViewModelMock?

    static func calculateHeight(for item: ViewModelMock, with width: CGFloat) -> CGFloat {
        return defaultHeight
    }

    func configure(with viewModel: ViewModelMock) {
        self.viewModel = viewModel
    }
}

@testable import Pillari

class TableNibCellMock: UITableViewCell, NibViewProtocol {
    static let nib = UINib()
}

class TableVoidCellMock: UITableViewCell, HeightCalculator {
    static let defaultHeight: CGFloat = 77
    static let defaultEstimatedHeight: CGFloat = 177

    static func calculateHeight(for item: Void, with width: CGFloat) -> CGFloat {
        return defaultHeight
    }

    static func calculateEstimatedHeight(for item: Void, with width: CGFloat) -> CGFloat {
        return defaultEstimatedHeight
    }
}

class TableCellMock: UITableViewCell, TableElementViewProtocol {
    static let defaultHeight: CGFloat = 10
    static let defaultEstimatedHeight: CGFloat = 40

    var viewModel: ViewModelMock?

    static func calculateHeight(for item: ViewModelMock, with width: CGFloat) -> CGFloat {
        return defaultHeight
    }

    static func calculateEstimatedHeight(for item: ViewModelMock, with width: CGFloat) -> CGFloat {
        return defaultEstimatedHeight
    }

    func configure(with viewModel: ViewModelMock) {
        self.viewModel = viewModel
    }
}

class TableNibHeaderFooterViewMock: UITableViewHeaderFooterView, NibViewProtocol {
    static let nib = UINib()
}

class TableVoidHeaderFooterViewMock: UITableViewHeaderFooterView, HeightCalculator {
    static let defaultHeight: CGFloat = 56
    static let defaultEstimatedHeight: CGFloat = 156

    static func calculateHeight(for item: Void, with width: CGFloat) -> CGFloat {
        return defaultHeight
    }

    static func calculateEstimatedHeight(for item: Void, with width: CGFloat) -> CGFloat {
        return defaultEstimatedHeight
    }
}

class TableHeaderFooterViewMock: UITableViewHeaderFooterView, TableElementViewProtocol {
    static let defaultHeight: CGFloat = 20
    static let defaultEstimatedHeight: CGFloat = 50

    var viewModel: ViewModelMock?

    static func calculateHeight(for item: ViewModelMock, with width: CGFloat) -> CGFloat {
        return defaultHeight
    }

    static func calculateEstimatedHeight(for item: ViewModelMock, with width: CGFloat) -> CGFloat {
        return defaultEstimatedHeight
    }

    func configure(with viewModel: ViewModelMock) {
        self.viewModel = viewModel
    }
}

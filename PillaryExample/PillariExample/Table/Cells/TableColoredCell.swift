import Pillari

final class TableColoredCell: UITableViewCell, TableElementViewProtocol {
    static func calculateHeight(for configuration: UIColor, with width: CGFloat) -> CGFloat {
        return 50
    }

    func configure(with configuration: UIColor) {
        backgroundColor = configuration
    }
}

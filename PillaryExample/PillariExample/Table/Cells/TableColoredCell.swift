//  Created by Anton Popkov on 01.11.17.

import Pillari

final class TableColoredCell: UITableViewCell, TableElementViewProtocol {
    static func calculateHeight(for configuration: UIColor, with width: CGFloat) -> CGFloat {
        return 50
    }

    func configure(with configuration: UIColor) {
        backgroundColor = configuration
    }
}

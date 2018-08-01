//  Created by Anton Popkov on 25.10.17.

public protocol TableElementHeightCalculatorProtocol {
    func calculateHeight(with tableView: UITableView) -> CGFloat

    func calculateEstimatedHeight(with tableView: UITableView) -> CGFloat
}

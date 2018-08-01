public protocol TableElementHeightCalculatorProtocol {
    func calculateHeight(with tableView: UITableView) -> CGFloat

    func calculateEstimatedHeight(with tableView: UITableView) -> CGFloat
}

public final class TableElementHeightCalculator: TableElementHeightCalculatorProtocol {
    public typealias HeightCalculationHandler = (UITableView) -> CGFloat

    private let heightCalculationHandler: HeightCalculationHandler
    private let estimatedHeightCalculationHandler: HeightCalculationHandler

    public init(heightCalculationHandler: @escaping HeightCalculationHandler,
                estimatedHeightCalculationHandler: @escaping HeightCalculationHandler) {
        self.heightCalculationHandler = heightCalculationHandler
        self.estimatedHeightCalculationHandler = estimatedHeightCalculationHandler
    }

    public convenience init(heightCalculationHandler: @escaping HeightCalculationHandler) {
        self.init(heightCalculationHandler: heightCalculationHandler,
                  estimatedHeightCalculationHandler: heightCalculationHandler)
    }

    public func calculateHeight(with tableView: UITableView) -> CGFloat {
        return heightCalculationHandler(tableView)
    }

    public func calculateEstimatedHeight(with tableView: UITableView) -> CGFloat {
        return estimatedHeightCalculationHandler(tableView)
    }
}

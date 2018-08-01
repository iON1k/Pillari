public final class TableCellFactory: TableCellFactoryProtocol {
    public typealias FactoryHandler = (UITableView, IndexPath) -> UITableViewCell

    private let factoryHandler: FactoryHandler

    public init(factoryHandler: @escaping FactoryHandler) {
        self.factoryHandler = factoryHandler
    }

    public func createCell(for tableView: UITableView, with indexPath: IndexPath) -> UITableViewCell {
        return factoryHandler(tableView, indexPath)
    }
}

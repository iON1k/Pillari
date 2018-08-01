//  Created by Anton Popkov on 26.10.17.

public final class TableHeaderFooterFactory: TableHeaderFooterFactoryProtocol {
    public typealias FactoryHandler = (UITableView, Int) -> UIView

    private let factoryHandler: FactoryHandler

    public init(factoryHandler: @escaping FactoryHandler) {
        self.factoryHandler = factoryHandler
    }

    public func createView(for tableView: UITableView, with section: Int) -> UIView {
        return factoryHandler(tableView, section)
    }
}

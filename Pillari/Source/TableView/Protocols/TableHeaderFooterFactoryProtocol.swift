//  Created by Anton Popkov on 26.10.17.

public protocol TableHeaderFooterFactoryProtocol {
    func createView(for tableView: UITableView, with section: Int) -> UIView
}

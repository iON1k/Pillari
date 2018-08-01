//  Created by Anton Popkov on 29.09.17.

public protocol TableSectionProtocol {
    var rows: [TableRowProtocol] { get }
    var header: TableHeaderFooterProtocol? { get }
    var footer: TableHeaderFooterProtocol? { get }
}

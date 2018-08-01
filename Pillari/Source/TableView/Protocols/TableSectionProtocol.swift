public protocol TableSectionProtocol {
    var rows: [TableRowProtocol] { get }
    var header: TableHeaderFooterProtocol? { get }
    var footer: TableHeaderFooterProtocol? { get }
}

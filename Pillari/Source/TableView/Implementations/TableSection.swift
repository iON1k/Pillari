public final class TableSection: TableSectionProtocol {
    public let rows: [TableRowProtocol]
    public let header: TableHeaderFooterProtocol?
    public let footer: TableHeaderFooterProtocol?

    public init(rows: [TableRowProtocol] = [],
                header: TableHeaderFooterProtocol? = nil,
                footer: TableHeaderFooterProtocol? = nil) {
        self.rows = rows
        self.header = header
        self.footer = footer
    }
}

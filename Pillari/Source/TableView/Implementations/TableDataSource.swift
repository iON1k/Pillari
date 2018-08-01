public final class TableDataSource: TableDataSourceProtocol {
    public let sections: [TableSectionProtocol]

    public init(sections: [TableSectionProtocol] = []) {
        self.sections = sections
    }
}

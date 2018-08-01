public extension Array where Element: TableSectionProtocol {
    func asDataSource() -> TableDataSource {
        return (self as [TableSectionProtocol]).asDataSource()
    }
}

public extension Array where Element == TableSectionProtocol {
    func asDataSource() -> TableDataSource {
        return TableDataSource(sections: self)
    }
}

public extension Array where Element: TableRowProtocol {
    func asSection(header: TableHeaderFooterProtocol? = nil,
                   footer: TableHeaderFooterProtocol? = nil) -> TableSection {
        return (self as [TableRowProtocol]).asSection(header: header, footer: footer)
    }

    func asSections(header: TableHeaderFooterProtocol? = nil,
                    footer: TableHeaderFooterProtocol? = nil) -> [TableSection] {
        return (self as [TableRowProtocol]).asSections(header: header, footer: footer)
    }
}

public extension Array where Element == TableRowProtocol {
    func asSection(header: TableHeaderFooterProtocol? = nil,
                   footer: TableHeaderFooterProtocol? = nil) -> TableSection {
        return TableSection(rows: self, header: header, footer: footer)
    }

    func asSections(header: TableHeaderFooterProtocol? = nil,
                    footer: TableHeaderFooterProtocol? = nil) -> [TableSection] {
        return [
            asSection(header: header, footer: footer)
        ]
    }
}

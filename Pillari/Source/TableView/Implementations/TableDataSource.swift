//  Created by Anton Popkov on 25.08.17.

public final class TableDataSource: TableDataSourceProtocol {
    public let sections: [TableSectionProtocol]

    public init(sections: [TableSectionProtocol] = []) {
        self.sections = sections
    }
}

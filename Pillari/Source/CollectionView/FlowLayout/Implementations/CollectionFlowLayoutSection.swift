//  Created by Anton Popkov on 24.10.17.

public final class CollectionFlowLayoutSection: CollectionFlowLayoutSectionProtocol {
    public let rows: [CollectionRowProtocol]

    public var header: CollectionSupplementaryProtocol? {
        return flowLayoutHeader?.supplementary
    }

    public var footer: CollectionSupplementaryProtocol? {
        return flowLayoutFooter?.supplementary
    }

    public var rowsLayout: [CollectionElementFlowLayoutProtocol] {
        return flowLayoutRows
    }

    public var headerLayout: CollectionElementFlowLayoutProtocol? {
        return flowLayoutHeader
    }

    public var footerLayout: CollectionElementFlowLayoutProtocol? {
        return flowLayoutFooter
    }

    public let flowLayoutRows: [CollectionFlowLayoutRowProtocol]

    public let flowLayoutHeader: CollectionFlowLayoutSupplementaryProtocol?

    public let flowLayoutFooter: CollectionFlowLayoutSupplementaryProtocol?

    public let layoutConfiguration: CollectionFlowLayoutSectionConfiguration

    public init(rows flowLayoutRows: [CollectionFlowLayoutRowProtocol] = [],
                header flowLayoutHeader: CollectionFlowLayoutSupplementaryProtocol? = nil,
                footer flowLayoutFooter: CollectionFlowLayoutSupplementaryProtocol? = nil,
                layoutConfiguration: CollectionFlowLayoutSectionConfiguration = .default) {
        self.flowLayoutRows = flowLayoutRows
        self.flowLayoutHeader = flowLayoutHeader
        self.flowLayoutFooter = flowLayoutFooter
        self.layoutConfiguration = layoutConfiguration
        rows = flowLayoutRows.map { $0.row }
    }
}

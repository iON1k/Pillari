//  Created by Anton Popkov on 23.10.17.

public protocol CollectionSectionFlowLayoutProtocol {
    var rowsLayout: [CollectionElementFlowLayoutProtocol] { get }

    var headerLayout: CollectionElementFlowLayoutProtocol? { get }

    var footerLayout: CollectionElementFlowLayoutProtocol? { get }

    var layoutConfiguration: CollectionFlowLayoutSectionConfiguration { get }
}

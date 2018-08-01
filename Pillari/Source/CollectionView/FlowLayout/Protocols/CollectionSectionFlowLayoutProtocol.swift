public protocol CollectionSectionFlowLayoutProtocol {
    var rowsLayout: [CollectionElementFlowLayoutProtocol] { get }

    var headerLayout: CollectionElementFlowLayoutProtocol? { get }

    var footerLayout: CollectionElementFlowLayoutProtocol? { get }

    var layoutConfiguration: CollectionFlowLayoutSectionConfiguration { get }
}

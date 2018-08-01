public protocol CollectionFlowLayoutSectionProtocol: CollectionSectionProtocol, CollectionSectionFlowLayoutProtocol {
    var header: CollectionSupplementaryProtocol? { get }
    var footer: CollectionSupplementaryProtocol? { get }
}

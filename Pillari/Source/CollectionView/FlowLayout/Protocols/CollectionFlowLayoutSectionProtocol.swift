//  Created by Anton Popkov on 01.11.17.

public protocol CollectionFlowLayoutSectionProtocol: CollectionSectionProtocol, CollectionSectionFlowLayoutProtocol {
    var header: CollectionSupplementaryProtocol? { get }
    var footer: CollectionSupplementaryProtocol? { get }
}

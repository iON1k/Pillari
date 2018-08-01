//  Created by Anton Popkov on 24.10.17.

public extension Array where Element: CollectionFlowLayoutSectionProtocol {
    func asCollectionFlowLayoutDataProvider(layout: UICollectionViewFlowLayout) -> CollectionFlowLayoutDataProvider {
        return (self as [CollectionFlowLayoutSectionProtocol]).asCollectionFlowLayoutDataProvider(layout: layout)
    }
}

public extension Array where Element == CollectionFlowLayoutSectionProtocol {
    func asCollectionFlowLayoutDataProvider(layout: UICollectionViewFlowLayout) -> CollectionFlowLayoutDataProvider {
        return CollectionFlowLayoutDataProvider(layout: layout, flowSections: self)
    }
}

public extension Array where Element: CollectionFlowLayoutRowProtocol {
    func asFlowLayoutSection(header flowLayoutHeader: CollectionFlowLayoutSupplementaryProtocol? = nil,
                             footer flowLayoutFooter: CollectionFlowLayoutSupplementaryProtocol? = nil,
                             layoutConfiguration: CollectionFlowLayoutSectionConfiguration = .default) -> CollectionFlowLayoutSection {
        return (self as [CollectionFlowLayoutRowProtocol]).asFlowLayoutSection(header: flowLayoutHeader, footer: flowLayoutFooter,
                                                                                   layoutConfiguration: layoutConfiguration)
    }

    func asFlowLayoutSections(header flowLayoutHeader: CollectionFlowLayoutSupplementaryProtocol? = nil,
                              footer flowLayoutFooter: CollectionFlowLayoutSupplementaryProtocol? = nil,
                              layoutConfiguration: CollectionFlowLayoutSectionConfiguration = .default) -> [CollectionFlowLayoutSection] {
        return (self as [CollectionFlowLayoutRowProtocol]).asFlowLayoutSections(header: flowLayoutHeader, footer: flowLayoutFooter,
                                                                               layoutConfiguration: layoutConfiguration)
    }
}

public extension Array where Element == CollectionFlowLayoutRowProtocol {
    func asFlowLayoutSection(header flowLayoutHeader: CollectionFlowLayoutSupplementaryProtocol? = nil,
                             footer flowLayoutFooter: CollectionFlowLayoutSupplementaryProtocol? = nil,
                             layoutConfiguration: CollectionFlowLayoutSectionConfiguration = .default) -> CollectionFlowLayoutSection {
        return CollectionFlowLayoutSection(rows: self, header: flowLayoutHeader, footer: flowLayoutFooter, layoutConfiguration: layoutConfiguration)
    }

    func asFlowLayoutSections(header flowLayoutHeader: CollectionFlowLayoutSupplementaryProtocol? = nil,
                              footer flowLayoutFooter: CollectionFlowLayoutSupplementaryProtocol? = nil,
                              layoutConfiguration: CollectionFlowLayoutSectionConfiguration = .default) -> [CollectionFlowLayoutSection] {
        return [
            asFlowLayoutSection(header: flowLayoutHeader, footer: flowLayoutFooter, layoutConfiguration: layoutConfiguration)
        ]
    }
}

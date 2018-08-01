public protocol CollectionDataProviderProtocol {
    var dataSource: CollectionDataSourceProtocol { get }

    var layout: UICollectionViewLayout { get }
}

//  Created by Anton Popkov on 24.10.17.

public protocol CollectionDataProviderProtocol {
    var dataSource: CollectionDataSourceProtocol { get }

    var layout: UICollectionViewLayout { get }
}

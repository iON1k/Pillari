//  Created by Anton Popkov on 23.10.17.

public protocol CollectionDataSourceProtocol {
    var sections: [CollectionSectionProtocol] { get }

    func supplementary(with kind: String, at index: IndexPath) -> CollectionSupplementaryProtocol?
}

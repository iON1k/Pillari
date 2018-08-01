//  Created by Anton Popkov on 21.11.17.

import UIKit

class UICollectionElementsFactory {
    typealias CellFactory = () -> UICollectionViewCell
    typealias SupplementaryFactory = () -> UICollectionReusableView

    private var cellFactories: [String: CellFactory] = [:]
    private var supplementaryFactories: [String: SupplementaryFactory] = [:]

    func registerCell(reuseId: String, cellFactory: @escaping CellFactory) {
        cellFactories[reuseId] = cellFactory
    }

    func registerSupplementary(kind: String, reuseId: String, supplementaryFactory: @escaping SupplementaryFactory) {
        supplementaryFactories[kind + reuseId] = supplementaryFactory
    }

    func dequeueCell(reuseId: String) -> UICollectionViewCell {
        guard let cellFactory = cellFactories[reuseId] else {
            return UICollectionViewCell()
        }

        return cellFactory()
    }

    func dequeueSupplementary(kind: String, reuseId: String) -> UICollectionReusableView {
        guard let supplementaryFactory = supplementaryFactories[kind + reuseId] else {
            return UICollectionReusableView()
        }

        return supplementaryFactory()
    }
}

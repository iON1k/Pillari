//  Created by Anton Popkov on 09.11.17.

extension Collection {
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }

    subscript (try index: Index) -> Element? {
        assert(indices.contains(index), "Collection does't contain element with index \(index)")
        return self[safe: index]
    }
}

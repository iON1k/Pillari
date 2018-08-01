public protocol CollectionDataSourceProtocol {
    var sections: [CollectionSectionProtocol] { get }

    func supplementary(with kind: String, at index: IndexPath) -> CollectionSupplementaryProtocol?
}

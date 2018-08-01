import Quickimport Nimble
@testable import Pillari

class CollectionRowExtensionTests: QuickSpec {
    override func spec() {
        let expectedReuseId = "Test"
        let expectedViewModel = ViewModelMock()
        let expectedCanMove = true
        let expectedRowConfiguration = CollectionRowConfiguration(canMove: expectedCanMove)
        let indexPath = IndexPath()

        var didSelectEventHandled = false
        let eventsHandler: (CollectionRowEvent) -> Void = { event in
            if case .didSelect = event {
                didSelectEventHandled = true
            }
        }

        var collectionView: UICollectionView!

        beforeEach {
            collectionView = UICollectionViewMock(frame: .zero, collectionViewLayout: UICollectionViewLayout())
            didSelectEventHandled = false
        }

        describe(".init(configuration: reuseId: eventsHadnler:)") {
            it("should return valid row") {
                let row = CollectionRow<CollectionCellMock>(configuration: expectedRowConfiguration,
                                                            reuseId: expectedReuseId, eventsHandler: eventsHandler)

                checkRow(row: row, cellType: CollectionCellMock.self)
            }
        }

        describe(".init(item: configuration: reuseId: eventsHadnler:)") {
            it("should return valid row") {
                let row = CollectionRow<CollectionCellMock>(item: expectedViewModel, configuration: expectedRowConfiguration,
                                                            reuseId: expectedReuseId, eventsHandler: eventsHandler)

                checkRow(row: row, cellType: CollectionCellMock.self)
                checkRowViewModel(row: row)
            }

            it("should return valid row with void configuration") {
                let row = CollectionRow<CollectionVoidCellMock>(configuration: expectedRowConfiguration,
                                                      reuseId: expectedReuseId, eventsHandler: eventsHandler)

                checkRow(row: row, cellType: CollectionVoidCellMock.self)
            }
        }

        func checkRowViewModel(row: CollectionRowProtocol) {
            let cell = row.cellFactory.createCell(for: collectionView, with: indexPath)
            expect((cell as? CollectionCellMock)?.viewModel).to(beIdenticalTo(expectedViewModel))
        }

        func checkRow(row: CollectionRowProtocol, cellType: UICollectionViewCell.Type) {
            let cell = row.cellFactory.createCell(for: collectionView, with: indexPath)
            expect(cell.reuseIdentifier).to(equal(expectedReuseId))
            expect(cell).to(beAKindOf(cellType))

            expect(row.configuration.canMove).to(equal(expectedCanMove))

            row.eventsHandler.onEvent(event: .didSelect(context: (collection: collectionView, index: indexPath)))
            expect(didSelectEventHandled).to(beTrue())
        }
    }
}

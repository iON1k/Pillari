import Quick
import Nimble
@testable import Pillari

class CollectionSupplementaryExtensionTests: QuickSpec {
    override func spec() {
        let expectedReuseId = "Test"
        let expectedViewModel = ViewModelMock()
        let indexPath = IndexPath()
        let kind = "TestKind"
        let reusableView = UICollectionReusableView()

        var willDisplayEventHandled = false
        let eventsHandler: (CollectionSupplementaryEvent) -> Void = { event in
            if case .willDisplay = event {
                willDisplayEventHandled = true
            }
        }

        var collectionView: UICollectionView!

        beforeEach {
            collectionView = UICollectionViewMock(frame: .zero, collectionViewLayout: UICollectionViewLayout())
            willDisplayEventHandled = false
        }

        describe(".init(reuseId: eventsHadnler:)") {
            it("should return valid supplementary") {
                let supplementary = CollectionSupplementary<CollectionSupplementaryViewMock>(reuseId: expectedReuseId, eventsHandler: eventsHandler)
                checkSupplementary(supplementary: supplementary, viewType: CollectionSupplementaryViewMock.self)
            }
        }

        describe(".init(item: reuseId: eventsHadnler:)") {
            it("should return valid supplementary") {
                let supplementary = CollectionSupplementary<CollectionSupplementaryViewMock>(item: expectedViewModel,
                                                                                             reuseId: expectedReuseId, eventsHandler: eventsHandler)
                checkSupplementary(supplementary: supplementary, viewType: CollectionSupplementaryViewMock.self)
                checkSupplementaryViewModel(supplementary: supplementary)
            }

            it("should return valid supplementary with void configuration") {
                let supplementary = CollectionSupplementary<CollectionVoidSupplementaryViewMock>(
                    reuseId: expectedReuseId,
                    eventsHandler: eventsHandler
                )
                checkSupplementary(supplementary: supplementary, viewType: CollectionVoidSupplementaryViewMock.self)
            }
        }

        func checkSupplementaryViewModel(supplementary: CollectionSupplementaryProtocol) {
            let view = supplementary.viewFactory.createView(for: collectionView, kind: kind, with: indexPath)
            expect((view as? CollectionSupplementaryViewMock)?.viewModel).to(beIdenticalTo(expectedViewModel))
        }

        func checkSupplementary(supplementary: CollectionSupplementaryProtocol, viewType: UICollectionReusableView.Type) {
            let view = supplementary.viewFactory.createView(for: collectionView, kind: kind, with: indexPath)
            expect(view.reuseIdentifier).to(equal(expectedReuseId))
            expect(view).to(beAKindOf(viewType))

            supplementary.eventsHandler.onEvent(event:
                .willDisplay(context: (collection: collectionView, view: reusableView, kind: kind, index: indexPath)))
            expect(willDisplayEventHandled).to(beTrue())
        }
    }
}

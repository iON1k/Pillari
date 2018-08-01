import Quick
import Nimble
@testable import Pillari

class CollectionSupplementaryTests: QuickSpec {
    override func spec() {
        describe(".init") {
            it("should return valid supplementary") {
                let viewFactory = CollectionSupplementaryFactory(UICollectionReusableView.self)
                let eventsHandler = CollectionSupplementary.SupplementaryEventsHandler()
                let supplementary = CollectionSupplementary(viewFactory: viewFactory, eventsHandler: eventsHandler)

                expect(supplementary.viewFactory).to(beIdenticalTo(viewFactory))
                expect(supplementary.eventsHandler).to(beIdenticalTo(eventsHandler))
            }
        }
    }
}

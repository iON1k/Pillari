//  Created by Anton Popkov on 14.11.17.

import Quick
import Nimble

@testable import Pillari

// swiftlint:disable function_body_length

class CollectionFlowLayoutSectionTests: QuickSpec {
    override func spec() {
        let expectedCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        let expectedSupplementaryView = UICollectionReusableView()
        let expectedIndexPath = IndexPath(row: 6, section: 13)

        let rows = (0...4).map { _ in CollectionRow() }
        let flowRows = rows.map { $0.withFlowAutomaticLayout() }
        let minimumLineSpacing: CGFloat = 34

        let wrongSupplementaryKind = "TestSupplementary"

        let sectionLayoutConfiguration = CollectionFlowLayoutSectionConfiguration(
            minimumLineSpacing: minimumLineSpacing
        )

        let headerView = UICollectionReusableView()
        let headerViewFactory = CollectionSupplementaryFactory {_, _, _ in
            return headerView
        }
        var headerEventsHandlerMock: EventsHandlerMock<CollectionSupplementaryEvent>!
        var header: CollectionSupplementaryProtocol!
        var flowHeader: CollectionFlowLayoutSupplementaryProtocol!

        let footerView = UICollectionReusableView()
        let footerViewFactory = CollectionSupplementaryFactory {_, _, _ in
            return footerView
        }
        var footerEventsHandlerMock: EventsHandlerMock<CollectionSupplementaryEvent>!
        var footer: CollectionSupplementaryProtocol!
        var flowFooter: CollectionFlowLayoutSupplementaryProtocol!

        var section: CollectionFlowLayoutSection!

        beforeEach {
            headerEventsHandlerMock = EventsHandlerMock()
            header = CollectionSupplementary(
                viewFactory: headerViewFactory,
                eventsHandler: EventsHandler(handler: headerEventsHandlerMock.onEvent)
            )
            flowHeader = header.withFlowAutomaticLayout()

            footerEventsHandlerMock = EventsHandlerMock()
            footer = CollectionSupplementary(
                viewFactory: footerViewFactory,
                eventsHandler: EventsHandler(handler: footerEventsHandlerMock.onEvent)
            )
            flowFooter = footer.withFlowAutomaticLayout()

            section = CollectionFlowLayoutSection(
                rows: flowRows,
                header: flowHeader,
                footer: flowFooter,
                layoutConfiguration: sectionLayoutConfiguration
            )
        }

        describe(".header") {
            it("should equals to expected value") {
                expect(section.header).to(beIdenticalTo(flowHeader.supplementary))
            }
        }

        describe(".footer") {
            it("should equals to expected value") {
                expect(section.footer).to(beIdenticalTo(flowFooter.supplementary))
            }
        }

        describe(".headerLayout") {
            it("should equals to expected value") {
                expect(section.headerLayout).to(beIdenticalTo(flowHeader))
            }
        }

        describe(".footerLayout") {
            it("should equals to expected value") {
                expect(section.footerLayout).to(beIdenticalTo(flowFooter))
            }
        }

        describe(".flowLayoutHeader") {
            it("should equals to expected value") {
                expect(section.flowLayoutHeader).to(beIdenticalTo(flowHeader))
            }
        }

        describe(".flowLayoutFooter") {
            it("should equals to expected value") {
                expect(section.flowLayoutFooter).to(beIdenticalTo(flowFooter))
            }
        }

        describe(".rows") {
            it("should equals to expected value") {
                expectToIdential(section.rows, to: rows)
            }
        }

        describe(".flowLayoutRows") {
            it("should equals to expected value") {
                expectToIdential(section.flowLayoutRows, to: flowRows)
            }
        }

        describe(".rowsLayout") {
            it("should equals to expected value") {
                expectToIdential(section.rowsLayout, to: flowRows)
            }
        }

        describe(".configuration") {
            it("should has valid value") {
                expect(section.layoutConfiguration.minimumLineSpacing).to(equal(minimumLineSpacing))
            }
        }

        func expectGeneratedEvent(event: CollectionSupplementaryEvent?, for kind: String) {
            guard case .didConfigure(let context)? = event else {
                XCTAssert(false, "Event no sends")
                return
            }

            expect(context.collection).to(beIdenticalTo(expectedCollectionView))
            expect(context.view).to(beIdenticalTo(expectedSupplementaryView))
            expect(context.kind).to(equal(kind))
            expect(context.index).to(equal(expectedIndexPath))
        }

        func generateSupplementaryEvent(for kind: String) -> CollectionSupplementaryEvent {
            return CollectionSupplementaryEvent.didConfigure(
                context: (
                    collection: expectedCollectionView,
                    view: expectedSupplementaryView,
                    kind: kind,
                    index: expectedIndexPath
                )
            )
        }
    }
}

// swiftlint:enable function_body_length

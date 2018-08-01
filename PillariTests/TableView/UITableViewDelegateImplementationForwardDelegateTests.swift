//  Created by Anton Popkov on 25.08.17.

import Quick
import Nimble

@testable import Pillari

// swiftlint:disable function_body_length
// swiftlint:disable cyclomatic_complexity
// swiftlint:disable type_name
// swiftlint:disable type_body_length
// swiftlint:disable file_length

class UITableViewDelegateImplementationForwardDelegateTests: QuickSpec {
    override func spec() {
        let expectedTableView = UITableView()
        let expectedCell = UITableViewCell()
        let expectedView = UIView()
        let expectedSection = 0
        let expectedIndexPath = IndexPath(row: 3, section: 0)
        var tableDelegate: UITableViewDelegate!
        var forwardTableDelegateMock: UITableViewDelegateMock!

        beforeEach {
            let dataSource =
                Array(repeating: TableRow<TableVoidCellMock>(), count: 5)
                    .asSections()
                    .asDataSource()

            let tableDelegateImpl = UITableViewDelegateImplementation(dataSource: dataSource)
            forwardTableDelegateMock = UITableViewDelegateMock()
            tableDelegateImpl.forwardDelegate = forwardTableDelegateMock
            tableDelegate = tableDelegateImpl
        }

        describe(".forwardDelegate") {
            it("should equals to expected value") {
                let tableDelegateImpl = UITableViewDelegateImplementation()
                let expectedForwardTableDelegate = UITableViewDelegateMock()
                tableDelegateImpl.forwardDelegate = expectedForwardTableDelegate
                expect(tableDelegateImpl.forwardDelegate).to(beIdenticalTo(expectedForwardTableDelegate))
                expect(tableDelegateImpl.forwardScrollDelegate).to(beIdenticalTo(expectedForwardTableDelegate))
            }

            it("should to be nil") {
                let tableDelegateImpl = UITableViewDelegateImplementation()
                expect(tableDelegateImpl.forwardDelegate).to(beNil())
                expect(tableDelegateImpl.forwardScrollDelegate).to(beNil())
                tableDelegateImpl.forwardDelegate = UITableViewDelegateMock()
                expect(tableDelegateImpl.forwardDelegate).to(beNil())
                expect(tableDelegateImpl.forwardScrollDelegate).to(beNil())
            }
        }

        describe(".willDisplay") {
            it("should call forward delegate method") {
                tableDelegate.tableView?(expectedTableView, willDisplay: expectedCell, forRowAt: expectedIndexPath)

                let event = expectOnlyOneEvent(forwardTableDelegateMock.events)
                guard case .willDisplayCell(let tableView, let cell, let indexPath)? = event else {
                    XCTAssert(false, "Method not called")
                    return
                }

                expect(tableView).to(beIdenticalTo(expectedTableView))
                expect(cell).to(beIdenticalTo(expectedCell))
                expect(indexPath).to(equal(expectedIndexPath))
            }
        }

        describe(".willDisplayHeaderView") {
            it("should call forward delegate method") {
                tableDelegate.tableView?(expectedTableView, willDisplayHeaderView: expectedView,
                                        forSection: expectedSection)

                let event = expectOnlyOneEvent(forwardTableDelegateMock.events)
                guard case .willDisplayHeaderView(let tableView, let view, let section)? = event else {
                    XCTAssert(false, "Method not called")
                    return
                }

                expect(tableView).to(beIdenticalTo(expectedTableView))
                expect(view).to(beIdenticalTo(expectedView))
                expect(section).to(equal(expectedSection))
            }
        }

        describe(".willDisplayFooterView") {
            it("should call forward delegate method") {
                tableDelegate.tableView?(expectedTableView, willDisplayFooterView: expectedView,
                                         forSection: expectedSection)

                let event = expectOnlyOneEvent(forwardTableDelegateMock.events)
                guard case .willDisplayFooterView(let tableView, let view, let section)? = event else {
                    XCTAssert(false, "Method not called")
                    return
                }

                expect(tableView).to(beIdenticalTo(expectedTableView))
                expect(view).to(beIdenticalTo(expectedView))
                expect(section).to(equal(expectedSection))
            }
        }

        describe(".didEndDisplaying") {
            it("should call forward delegate method") {
                tableDelegate.tableView?(expectedTableView, didEndDisplaying: expectedCell, forRowAt: expectedIndexPath)

                let event = expectOnlyOneEvent(forwardTableDelegateMock.events)
                guard case .didEndDisplayingCell(let tableView, let cell, let indexPath)? = event else {
                    XCTAssert(false, "Method not called")
                    return
                }

                expect(tableView).to(beIdenticalTo(expectedTableView))
                expect(cell).to(beIdenticalTo(expectedCell))
                expect(indexPath).to(equal(expectedIndexPath))
            }
        }

        describe(".didEndDisplayingHeaderView") {
            it("should call forward delegate method") {
                tableDelegate.tableView?(expectedTableView, didEndDisplayingHeaderView: expectedView,
                                         forSection: expectedSection)

                let event = expectOnlyOneEvent(forwardTableDelegateMock.events)
                guard case .didEndDisplayingHeaderView(let tableView, let view, let section)? = event else {
                    XCTAssert(false, "Method not called")
                    return
                }

                expect(tableView).to(beIdenticalTo(expectedTableView))
                expect(view).to(beIdenticalTo(expectedView))
                expect(section).to(equal(expectedSection))
            }
        }

        describe(".didEndDisplayingFooterView") {
            it("should call forward delegate method") {
                tableDelegate.tableView?(expectedTableView, didEndDisplayingFooterView: expectedView,
                                         forSection: expectedSection)

                let event = expectOnlyOneEvent(forwardTableDelegateMock.events)
                guard case .didEndDisplayingFooterView(let tableView, let view, let section)? = event else {
                    XCTAssert(false, "Method not called")
                    return
                }

                expect(tableView).to(beIdenticalTo(expectedTableView))
                expect(view).to(beIdenticalTo(expectedView))
                expect(section).to(equal(expectedSection))
            }
        }

        describe(".heightForRowAt") {
            it("should call forward delegate method") {
                let height = tableDelegate.tableView?(expectedTableView, heightForRowAt: expectedIndexPath)
                expect(height).to(equal(forwardTableDelegateMock.heightForRow))

                let event = expectOnlyOneEvent(forwardTableDelegateMock.events)
                guard case .heightForRow(let tableView, let indexPath)? = event else {
                    XCTAssert(false, "Method not called")
                    return
                }

                expect(tableView).to(beIdenticalTo(expectedTableView))
                expect(indexPath).to(equal(expectedIndexPath))
            }
        }

        describe(".heightForHeaderInSection") {
            it("should call forward delegate method") {
                let height = tableDelegate.tableView?(expectedTableView, heightForHeaderInSection: expectedSection)
                expect(height).to(equal(forwardTableDelegateMock.heightForHeader))

                let event = expectOnlyOneEvent(forwardTableDelegateMock.events)
                guard case .heightForHeader(let tableView, let section)? = event else {
                    XCTAssert(false, "Method not called")
                    return
                }

                expect(tableView).to(beIdenticalTo(expectedTableView))
                expect(section).to(equal(expectedSection))
            }
        }

        describe(".heightForFooterInSection") {
            it("should call forward delegate method") {
                let height = tableDelegate.tableView?(expectedTableView, heightForFooterInSection: expectedSection)
                expect(height).to(equal(forwardTableDelegateMock.heightForFooter))

                let event = expectOnlyOneEvent(forwardTableDelegateMock.events)
                guard case .heightForFooter(let tableView, let section)? = event else {
                    XCTAssert(false, "Method not called")
                    return
                }

                expect(tableView).to(beIdenticalTo(expectedTableView))
                expect(section).to(equal(expectedSection))
            }
        }

        describe(".estimatedHeightForRowAt") {
            it("should call forward delegate method") {
                let height = tableDelegate.tableView?(expectedTableView, estimatedHeightForRowAt: expectedIndexPath)
                expect(height).to(equal(forwardTableDelegateMock.estimatedHeightForRow))

                let event = expectOnlyOneEvent(forwardTableDelegateMock.events)
                guard case .estimatedHeightForRow(let tableView, let indexPath)? = event else {
                    XCTAssert(false, "Method not called")
                    return
                }

                expect(tableView).to(beIdenticalTo(expectedTableView))
                expect(indexPath).to(equal(expectedIndexPath))
            }
        }

        describe(".estimatedHeightForHeaderInSection") {
            it("should call forward delegate method") {
                let height = tableDelegate.tableView?(expectedTableView,
                                                      estimatedHeightForHeaderInSection: expectedSection)
                expect(height).to(equal(forwardTableDelegateMock.estimatedHeightForHeader))

                let event = expectOnlyOneEvent(forwardTableDelegateMock.events)
                guard case .estimatedHeightForHeader(let tableView, let section)? = event else {
                    XCTAssert(false, "Method not called")
                    return
                }

                expect(tableView).to(beIdenticalTo(expectedTableView))
                expect(section).to(equal(expectedSection))
            }
        }

        describe(".estimatedHeightForFooterInSection") {
            it("should call forward delegate method") {
                let height = tableDelegate.tableView?(expectedTableView,
                                                      estimatedHeightForFooterInSection: expectedSection)
                expect(height).to(equal(forwardTableDelegateMock.estimatedHeightForFooter))

                let event = expectOnlyOneEvent(forwardTableDelegateMock.events)
                guard case .estimatedHeightForFooter(let tableView, let section)? = event else {
                    XCTAssert(false, "Method not called")
                    return
                }

                expect(tableView).to(beIdenticalTo(expectedTableView))
                expect(section).to(equal(expectedSection))
            }
        }

        describe(".viewForHeaderInSection") {
            it("should call forward delegate method") {
                let view = tableDelegate.tableView?(expectedTableView, viewForHeaderInSection: expectedSection)
                expect(view).to(equal(forwardTableDelegateMock.viewForHeader))

                let event = expectOnlyOneEvent(forwardTableDelegateMock.events)
                guard case .viewForHeader(let tableView, let section)? = event else {
                    XCTAssert(false, "Method not called")
                    return
                }

                expect(tableView).to(beIdenticalTo(expectedTableView))
                expect(section).to(equal(expectedSection))
            }
        }

        describe(".viewForFooterInSection") {
            it("should call forward delegate method") {
                let view = tableDelegate.tableView?(expectedTableView, viewForFooterInSection: expectedSection)
                expect(view).to(equal(forwardTableDelegateMock.viewForFooter))

                let event = expectOnlyOneEvent(forwardTableDelegateMock.events)
                guard case .viewForFooter(let tableView, let section)? = event else {
                    XCTAssert(false, "Method not called")
                    return
                }

                expect(tableView).to(beIdenticalTo(expectedTableView))
                expect(section).to(equal(expectedSection))
            }
        }

        describe(".accessoryButtonTappedForRowWith") {
            it("should call forward delegate method") {
                tableDelegate.tableView?(expectedTableView, accessoryButtonTappedForRowWith: expectedIndexPath)

                let event = expectOnlyOneEvent(forwardTableDelegateMock.events)
                guard case .accessoryButtonTappedForRow(let tableView, let indexPath)? = event else {
                    XCTAssert(false, "Method not called")
                    return
                }

                expect(tableView).to(beIdenticalTo(expectedTableView))
                expect(indexPath).to(equal(expectedIndexPath))
            }
        }

        describe(".shouldHighlightRowAt") {
            it("should call forward delegate method") {
                let shouldHighlightRow = tableDelegate.tableView?(expectedTableView,
                                                                  shouldHighlightRowAt: expectedIndexPath)
                expect(shouldHighlightRow).to(equal(forwardTableDelegateMock.shouldHighlightRow))

                let event = expectOnlyOneEvent(forwardTableDelegateMock.events)
                guard case .shouldHighlightRow(let tableView, let indexPath)? = event else {
                    XCTAssert(false, "Method not called")
                    return
                }

                expect(tableView).to(beIdenticalTo(expectedTableView))
                expect(indexPath).to(equal(expectedIndexPath))
            }
        }

        describe(".didHighlightRowAt") {
            it("should call forward delegate method") {
                tableDelegate.tableView?(expectedTableView, didHighlightRowAt: expectedIndexPath)

                let event = expectOnlyOneEvent(forwardTableDelegateMock.events)
                guard case .didHighlightRow(let tableView, let indexPath)? = event else {
                    XCTAssert(false, "Method not called")
                    return
                }

                expect(tableView).to(beIdenticalTo(expectedTableView))
                expect(indexPath).to(equal(expectedIndexPath))
            }
        }

        describe(".didUnhighlightRowAt") {
            it("should call forward delegate method") {
                tableDelegate.tableView?(expectedTableView, didUnhighlightRowAt: expectedIndexPath)

                let event = expectOnlyOneEvent(forwardTableDelegateMock.events)
                guard case .didUnhighlightRow(let tableView, let indexPath)? = event else {
                    XCTAssert(false, "Method not called")
                    return
                }

                expect(tableView).to(beIdenticalTo(expectedTableView))
                expect(indexPath).to(equal(expectedIndexPath))
            }
        }

        describe(".shouldHighlightRowAt") {
            it("should call forward delegate method") {
                let shouldHighlightRow = tableDelegate.tableView?(expectedTableView,
                                                                  shouldHighlightRowAt: expectedIndexPath)
                expect(shouldHighlightRow).to(equal(forwardTableDelegateMock.shouldHighlightRow))

                let event = expectOnlyOneEvent(forwardTableDelegateMock.events)
                guard case .shouldHighlightRow(let tableView, let indexPath)? = event else {
                    XCTAssert(false, "Method not called")
                    return
                }

                expect(tableView).to(beIdenticalTo(expectedTableView))
                expect(indexPath).to(equal(expectedIndexPath))
            }
        }

        describe(".willSelectRowAt") {
            it("should call forward delegate method") {
                let willSelectRowIndexPath = tableDelegate.tableView?(expectedTableView,
                                                                      willSelectRowAt: expectedIndexPath)
                expect(willSelectRowIndexPath).to(equal(forwardTableDelegateMock.willSelectRowIndexPath))

                let event = expectOnlyOneEvent(forwardTableDelegateMock.events)
                guard case .willSelectRow(let tableView, let indexPath)? = event else {
                    XCTAssert(false, "Method not called")
                    return
                }

                expect(tableView).to(beIdenticalTo(expectedTableView))
                expect(indexPath).to(equal(expectedIndexPath))
            }
        }

        describe(".willDeselectRowAt") {
            it("should call forward delegate method") {
                let willDeselectRowIndexPath = tableDelegate.tableView?(expectedTableView,
                                                                      willDeselectRowAt: expectedIndexPath)
                expect(willDeselectRowIndexPath).to(equal(forwardTableDelegateMock.willDeselectRowIndexPath))

                let event = expectOnlyOneEvent(forwardTableDelegateMock.events)
                guard case .willDeselectRow(let tableView, let indexPath)? = event else {
                    XCTAssert(false, "Method not called")
                    return
                }

                expect(tableView).to(beIdenticalTo(expectedTableView))
                expect(indexPath).to(equal(expectedIndexPath))
            }
        }

        describe(".didSelectRowAt") {
            it("should call forward delegate method") {
                tableDelegate.tableView?(expectedTableView, didSelectRowAt: expectedIndexPath)

                let event = expectOnlyOneEvent(forwardTableDelegateMock.events)
                guard case .didSelectRow(let tableView, let indexPath)? = event else {
                    XCTAssert(false, "Method not called")
                    return
                }

                expect(tableView).to(beIdenticalTo(expectedTableView))
                expect(indexPath).to(equal(expectedIndexPath))
            }
        }

        describe(".didDeselectRowAt") {
            it("should call forward delegate method") {
                tableDelegate.tableView?(expectedTableView, didDeselectRowAt: expectedIndexPath)

                let event = expectOnlyOneEvent(forwardTableDelegateMock.events)
                guard case .didDeselectRow(let tableView, let indexPath)? = event else {
                    XCTAssert(false, "Method not called")
                    return
                }

                expect(tableView).to(beIdenticalTo(expectedTableView))
                expect(indexPath).to(equal(expectedIndexPath))
            }
        }

        describe(".editingStyleForRowAt") {
            it("should call forward delegate method") {
                let editingStyleForRow = tableDelegate.tableView?(expectedTableView,
                                                                  editingStyleForRowAt: expectedIndexPath)
                expect(editingStyleForRow).to(equal(forwardTableDelegateMock.editingStyleForRow))

                let event = expectOnlyOneEvent(forwardTableDelegateMock.events)
                guard case .editingStyleForRow(let tableView, let indexPath)? = event else {
                    XCTAssert(false, "Method not called")
                    return
                }

                expect(tableView).to(beIdenticalTo(expectedTableView))
                expect(indexPath).to(equal(expectedIndexPath))
            }
        }

        describe(".titleForDeleteConfirmationButtonForRowAt") {
            it("should call forward delegate method") {
                let titleForDeleteConfirmationButtonForRow =
                    tableDelegate.tableView?(expectedTableView,
                                             titleForDeleteConfirmationButtonForRowAt: expectedIndexPath)
                expect(titleForDeleteConfirmationButtonForRow)
                    .to(equal(forwardTableDelegateMock.titleForDeleteConfirmationButtonForRow))

                let event = expectOnlyOneEvent(forwardTableDelegateMock.events)
                guard case .titleForDeleteConfirmationButtonForRow(let tableView, let indexPath)? = event else {
                    XCTAssert(false, "Method not called")
                    return
                }

                expect(tableView).to(beIdenticalTo(expectedTableView))
                expect(indexPath).to(equal(expectedIndexPath))
            }
        }

        describe(".editActionsForRowAt") {
            it("should call forward delegate method") {
                let editActionsForRow = tableDelegate.tableView?(expectedTableView,
                                                                 editActionsForRowAt: expectedIndexPath)
                expect(editActionsForRow).to(equal(forwardTableDelegateMock.editActionsForRow))

                let event = expectOnlyOneEvent(forwardTableDelegateMock.events)
                guard case .editActionsForRow(let tableView, let indexPath)? = event else {
                    XCTAssert(false, "Method not called")
                    return
                }

                expect(tableView).to(beIdenticalTo(expectedTableView))
                expect(indexPath).to(equal(expectedIndexPath))
            }
        }

        describe(".shouldIndentWhileEditingRowAt") {
            it("should call forward delegate method") {
                let shouldIndentWhileEditingRow = tableDelegate.tableView?(expectedTableView,
                                                                           shouldIndentWhileEditingRowAt: expectedIndexPath)
                expect(shouldIndentWhileEditingRow).to(equal(forwardTableDelegateMock.shouldIndentWhileEditingRow))

                let event = expectOnlyOneEvent(forwardTableDelegateMock.events)
                guard case .shouldIndentWhileEditingRow(let tableView, let indexPath)? = event else {
                    XCTAssert(false, "Method not called")
                    return
                }

                expect(tableView).to(beIdenticalTo(expectedTableView))
                expect(indexPath).to(equal(expectedIndexPath))
            }
        }

        describe(".willBeginEditingRowAt") {
            it("should call forward delegate method") {
                tableDelegate.tableView?(expectedTableView, willBeginEditingRowAt: expectedIndexPath)

                let event = expectOnlyOneEvent(forwardTableDelegateMock.events)
                guard case .willBeginEditingRow(let tableView, let indexPath)? = event else {
                    XCTAssert(false, "Method not called")
                    return
                }

                expect(tableView).to(beIdenticalTo(expectedTableView))
                expect(indexPath).to(equal(expectedIndexPath))
            }
        }

        describe(".didEndEditingRowAt") {
            it("should call forward delegate method") {
                tableDelegate.tableView?(expectedTableView,
                                         didEndEditingRowAt: expectedIndexPath)

                let event = expectOnlyOneEvent(forwardTableDelegateMock.events)
                guard case .didEndEditingRow(let tableView, let indexPath)? = event else {
                    XCTAssert(false, "Method not called")
                    return
                }

                expect(tableView).to(beIdenticalTo(expectedTableView))
                expect(indexPath).to(equal(expectedIndexPath))
            }
        }

        describe(".targetIndexPathForMoveFromRowAt") {
            it("should call forward delegate method") {
                let expectedProposedIndexPath = IndexPath(row: 10, section: 14)
                let targetIndexPathForMoveFromRow =
                    tableDelegate.tableView?(expectedTableView, targetIndexPathForMoveFromRowAt: expectedIndexPath,
                                             toProposedIndexPath: expectedProposedIndexPath)
                expect(targetIndexPathForMoveFromRow).to(equal(forwardTableDelegateMock.targetIndexPathForMoveFromRow))

                let event = expectOnlyOneEvent(forwardTableDelegateMock.events)
                guard case .targetIndexPathForMoveFromRow(let tableView, let indexPath, let proposedIndexPath)? = event else {
                    XCTAssert(false, "Method not called")
                    return
                }

                expect(tableView).to(beIdenticalTo(expectedTableView))
                expect(indexPath).to(equal(expectedIndexPath))
                expect(proposedIndexPath).to(equal(expectedProposedIndexPath))
            }
        }

        describe(".indentationLevelForRowAt") {
            it("should call forward delegate method") {
                let indentationLevelForRow = tableDelegate.tableView?(expectedTableView,
                                                                      indentationLevelForRowAt: expectedIndexPath)
                expect(indentationLevelForRow).to(equal(forwardTableDelegateMock.indentationLevelForRow))

                let event = expectOnlyOneEvent(forwardTableDelegateMock.events)
                guard case .indentationLevelForRow(let tableView, let indexPath)? = event else {
                    XCTAssert(false, "Method not called")
                    return
                }

                expect(tableView).to(beIdenticalTo(expectedTableView))
                expect(indexPath).to(equal(expectedIndexPath))
            }
        }

        describe(".shouldShowMenuForRowAt") {
            it("should call forward delegate method") {
                let shouldShowMenuForRow = tableDelegate.tableView?(expectedTableView,
                                                                    shouldShowMenuForRowAt: expectedIndexPath)
                expect(shouldShowMenuForRow).to(equal(forwardTableDelegateMock.shouldShowMenuForRow))

                let event = expectOnlyOneEvent(forwardTableDelegateMock.events)
                guard case .shouldShowMenuForRow(let tableView, let indexPath)? = event else {
                    XCTAssert(false, "Method not called")
                    return
                }

                expect(tableView).to(beIdenticalTo(expectedTableView))
                expect(indexPath).to(equal(expectedIndexPath))
            }
        }

        describe(".canPerformAction") {
            it("should call forward delegate method") {
                let expectedAction = #selector(UITableView.reloadData)
                let canPerformAction =
                    tableDelegate.tableView?(expectedTableView,
                                             canPerformAction: expectedAction, forRowAt: expectedIndexPath, withSender: self)
                expect(canPerformAction).to(equal(forwardTableDelegateMock.canPerformAction))

                let event = expectOnlyOneEvent(forwardTableDelegateMock.events)
                guard case .canPerformAction(let tableView, let action, let indexPath, let sender)? = event else {
                    XCTAssert(false, "Method not called")
                    return
                }

                expect(tableView).to(beIdenticalTo(expectedTableView))
                expect(action).to(equal(expectedAction))
                expect(indexPath).to(equal(expectedIndexPath))
                expect(sender).to(beIdenticalTo(self))
            }
        }

        describe(".performAction") {
            it("should call forward delegate method") {
                let expectedAction = #selector(UITableView.reloadData)
                tableDelegate.tableView?(expectedTableView,
                                         performAction: expectedAction, forRowAt: expectedIndexPath, withSender: self)

                let event = expectOnlyOneEvent(forwardTableDelegateMock.events)
                guard case .performAction(let tableView, let action, let indexPath, let sender)? = event else {
                    XCTAssert(false, "Method not called")
                    return
                }

                expect(tableView).to(beIdenticalTo(expectedTableView))
                expect(action).to(equal(expectedAction))
                expect(indexPath).to(equal(expectedIndexPath))
                expect(sender).to(beIdenticalTo(self))
            }
        }

        describe(".canFocusRowAt") {
            it("should call forward delegate method") {
                let canFocusRow = tableDelegate.tableView?(expectedTableView,
                                                           canFocusRowAt: expectedIndexPath)
                expect(canFocusRow).to(equal(forwardTableDelegateMock.canFocusRow))

                let event = expectOnlyOneEvent(forwardTableDelegateMock.events)
                guard case .canFocusRow(let tableView, let indexPath)? = event else {
                    XCTAssert(false, "Method not called")
                    return
                }

                expect(tableView).to(beIdenticalTo(expectedTableView))
                expect(indexPath).to(equal(expectedIndexPath))
            }
        }

        describe(".indexPathForPreferredFocusedView") {
            it("should call forward delegate method") {
                let indexPathForPreferredFocusedView = tableDelegate.indexPathForPreferredFocusedView?(in: expectedTableView)
                expect(indexPathForPreferredFocusedView).to(equal(forwardTableDelegateMock.indexPathForPreferredFocusedView))

                let event = expectOnlyOneEvent(forwardTableDelegateMock.events)
                guard case .indexPathForPreferredFocusedView(let tableView)? = event else {
                    XCTAssert(false, "Method not called")
                    return
                }

                expect(tableView).to(beIdenticalTo(expectedTableView))
            }
        }
    }
}

// swiftlint:enable function_body_length
// swiftlint:enable cyclomatic_complexity
// swiftlint:enable type_name
// swiftlint:enable type_body_length
// swiftlint:enable file_length

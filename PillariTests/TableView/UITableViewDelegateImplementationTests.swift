//  Created by Anton Popkov on 10.11.17.

import Quick
import Nimble

@testable import Pillari

// swiftlint:disable function_body_length

class UITableViewDelegateImplementationTests: QuickSpec {
    override func spec() {
        let tableView = UITableView()
        let sectionIndex2 = 2
        let rowIndex4 = 4
        let indexPath24 = IndexPath(row: rowIndex4, section: sectionIndex2)

        let configuration24 =
            TableRowConfiguration(
                selection: .init(
                    shouldHighlight: false
                ),
                editing: .init(
                    style: .delete,
                    titleForDeleteConfirmationButton: "TestDelete",
                    actions: [
                        UITableViewRowAction(),
                        UITableViewRowAction(),
                        UITableViewRowAction()
                    ],
                    shouldIndent: false
                ),
                shouldShowMenu: true,
                indentationLevel: 10,
                canFocus: false
        )

        let cellHeight24 = CGFloat(50)
        let cellEstimatedHeight24 = CGFloat(60)
        let cellHeightCalculator24 = TableElementHeightCalculator(
            height: cellHeight24,
            estimatedHeight: cellEstimatedHeight24
        )

        let row24 = TableRow<TableCellMock>(
            item: ViewModelMock(),
            heightCalculator: cellHeightCalculator24,
            configuration: configuration24
        )

        let headerView2 = UIView()
        let headerViewFactory24 = TableHeaderFooterFactory { _, _ in
            return headerView2
        }

        let headerHeight2 = CGFloat(150)
        let headerEstimatedHeight2 = CGFloat(160)
        let headerHeightCalculator2 = TableElementHeightCalculator(
            height: headerHeight2,
            estimatedHeight: headerEstimatedHeight2
        )

        let header2 = TableHeaderFooter(
            viewFactory: headerViewFactory24,
            heightCalculator: headerHeightCalculator2
        )

        let footerView2 = UIView()
        let footerViewFactory24 = TableHeaderFooterFactory { _, _ in
            return footerView2
        }

        let footerHeight2 = CGFloat(250)
        let footerEstimatedHeight2 = CGFloat(260)
        let footerHeightCalculator2 = TableElementHeightCalculator(
            height: footerHeight2,
            estimatedHeight: footerEstimatedHeight2
        )

        let footer2 = TableHeaderFooter(
            viewFactory: footerViewFactory24,
            heightCalculator: footerHeightCalculator2
        )

        let defaultRow = TableRow<TableVoidCellMock>()
        let defaultSection = Array(repeating: defaultRow, count: 5).asSection()

        let section2 = [
            defaultRow,
            defaultRow,
            defaultRow,
            defaultRow,
            row24
        ]
        .asSection(header: header2, footer: footer2)

        let dataSource = [
            defaultSection,
            defaultSection,
            section2
        ]
        .asDataSource()

        let tableDelegate: UITableViewDelegate = UITableViewDelegateImplementation(dataSource: dataSource)

        describe(".init(dataSource:)") {
            it("should return valid value") {
                expect((tableDelegate as? UITableViewDelegateImplementation)?.dataSource).to(beIdenticalTo(dataSource))
            }
        }

        describe(".heightForRowAt") {
            it("should result equals to expected value") {
                let heightForRow = tableDelegate.tableView?(tableView, heightForRowAt: indexPath24)
                expect(heightForRow).to(equal(cellHeight24))
            }
        }

        describe(".heightForHeaderInSection") {
            it("should result equals to expected value") {
                let heightForHeader = tableDelegate.tableView?(tableView, heightForHeaderInSection: sectionIndex2)
                expect(heightForHeader).to(equal(headerHeight2))
            }
        }

        describe(".heightForFooterInSection") {
            it("should result equals to expected value") {
                let heightForFooter = tableDelegate.tableView?(tableView, heightForFooterInSection: sectionIndex2)
                expect(heightForFooter).to(equal(footerHeight2))
            }
        }

        describe(".estimatedHeightForRowAt") {
            it("should result equals to expected value") {
                let estimatedHeightForRow = tableDelegate.tableView?(tableView, estimatedHeightForRowAt: indexPath24)
                expect(estimatedHeightForRow).to(equal(cellEstimatedHeight24))
            }
        }

        describe(".estimatedHeightForHeaderInSection") {
            it("should result equals to expected value") {
                let estimatedHeightForHeader =
                    tableDelegate.tableView?(tableView, estimatedHeightForHeaderInSection: sectionIndex2)
                expect(estimatedHeightForHeader).to(equal(headerEstimatedHeight2))
            }
        }

        describe(".estimatedHeightForFooterInSection") {
            it("should result equals to expected value") {
                let estimatedHeightForFooter =
                    tableDelegate.tableView?(tableView, estimatedHeightForFooterInSection: sectionIndex2)
                expect(estimatedHeightForFooter).to(equal(footerEstimatedHeight2))
            }
        }

        describe(".viewForHeaderInSection") {
            it("should result equals to expected value") {
                let viewForHeader = tableDelegate.tableView?(tableView, viewForHeaderInSection: sectionIndex2)
                expect(viewForHeader).to(beIdenticalTo(headerView2))
            }
        }

        describe(".viewForFooterInSection") {
            it("should result equals to expected value") {
                let viewForFooter = tableDelegate.tableView?(tableView, viewForFooterInSection: sectionIndex2)
                expect(viewForFooter).to(beIdenticalTo(footerView2))
            }
        }

        describe(".shouldHighlightRowAt") {
            it("should result equals to expected value") {
                let shouldHighlightRow = tableDelegate.tableView?(tableView, shouldHighlightRowAt: indexPath24)
                expect(shouldHighlightRow).to(equal(configuration24.selection.shouldHighlight))
            }
        }

        describe(".editingStyleForRowAt") {
            it("should result equals to expected value") {
                let editingStyleForRow = tableDelegate.tableView?(tableView, editingStyleForRowAt: indexPath24)
                expect(editingStyleForRow).to(equal(configuration24.editing.style))
            }
        }

        describe(".titleForDeleteConfirmationButtonForRowAt") {
            it("should result equals to expected value") {
                let titleForDeleteConfirmationButtonForRow =
                    tableDelegate.tableView?(tableView, titleForDeleteConfirmationButtonForRowAt: indexPath24)
                expect(titleForDeleteConfirmationButtonForRow)
                    .to(equal(configuration24.editing.titleForDeleteConfirmationButton))
            }
        }

        describe(".editActionsForRowAt") {
            it("should result equals to expected value") {
                let editActionsForRow = tableDelegate.tableView?(tableView, editActionsForRowAt: indexPath24)
                expect(editActionsForRow).to(equal(configuration24.editing.actions))
            }
        }

        describe(".shouldIndentWhileEditingRowAt") {
            it("should result equals to expected value") {
                let shouldIndentWhileEditingRow =
                    tableDelegate.tableView?(tableView, shouldIndentWhileEditingRowAt: indexPath24)
                expect(shouldIndentWhileEditingRow).to(equal(configuration24.editing.shouldIndent))
            }
        }

        describe(".indentationLevelForRowAt") {
            it("should result equals to expected value") {
                let indentationLevelForRow =
                    tableDelegate.tableView?(tableView, indentationLevelForRowAt: indexPath24)
                expect(indentationLevelForRow).to(equal(configuration24.indentationLevel))
            }
        }

        describe(".shouldShowMenuForRowAt") {
            it("should result equals to expected value") {
                let shouldShowMenuForRow = tableDelegate.tableView?(tableView, shouldShowMenuForRowAt: indexPath24)
                expect(shouldShowMenuForRow).to(equal(configuration24.shouldShowMenu))
            }
        }

        describe(".canFocusRowAt") {
            it("should result equals to expected value") {
                let canFocusRow = tableDelegate.tableView?(tableView, canFocusRowAt: indexPath24)
                expect(canFocusRow).to(equal(configuration24.canFocus))
            }
        }
    }
}

// swiftlint:enable function_body_length

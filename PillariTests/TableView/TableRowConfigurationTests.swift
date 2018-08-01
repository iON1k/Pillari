import Quickimport Nimble
@testable import Pillari

class TableRowConfigurationTests: QuickSpec {
    override func spec() {
        let shouldHighlight = false
        let shouldResetSelection = false
        let shouldShowMenu = true
        let canEdit = true
        let canMove = true
        let editingStyle = UITableViewCellEditingStyle.delete
        let titleForDeleteConfirmationButton = "TestDelete"
        let editingActions = (0...4).map {_ in UITableViewRowAction() }
        let shouldIndent = false
        let indentationLevel = 10
        let canFocus = false

        let configuration =
            TableRowConfiguration(
                selection: .init(
                    shouldHighlight: shouldHighlight,
                    shouldReset: shouldResetSelection
                ),
                editing: .init(
                    canEdit: canEdit,
                    canMove: canMove,
                    style: editingStyle,
                    titleForDeleteConfirmationButton: titleForDeleteConfirmationButton,
                    actions: editingActions,
                    shouldIndent: false
                ),
                shouldShowMenu: shouldShowMenu,
                indentationLevel: indentationLevel,
                canFocus: canFocus
        )

        describe(".init") {
            it("should return valid configuration") {
                expect(configuration.selection.shouldHighlight).to(equal(shouldHighlight))
                expect(configuration.selection.shouldReset).to(equal(shouldResetSelection))
                expect(configuration.shouldShowMenu).to(equal(shouldShowMenu))
                expect(configuration.editing.canEdit).to(equal(canEdit))
                expect(configuration.editing.canMove).to(equal(canMove))
                expect(configuration.editing.style).to(equal(editingStyle))
                expect(configuration.editing.titleForDeleteConfirmationButton).to(equal(titleForDeleteConfirmationButton))
                expectToIdential(configuration.editing.actions, to: editingActions)
                expect(configuration.editing.shouldIndent).to(equal(shouldIndent))
                expect(configuration.indentationLevel).to(equal(indentationLevel))
                expect(configuration.canFocus).to(equal(canFocus))
            }
        }
    }
}

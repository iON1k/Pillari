public struct TableRowConfiguration {
    public struct Selection {
        public var shouldHighlight: Bool
        public var shouldReset: Bool

        public init(shouldHighlight: Bool = true,
                    shouldReset: Bool = true) {
            self.shouldHighlight = shouldHighlight
            self.shouldReset = shouldReset
        }

        public static let `default` = Selection()
    }

    public struct Editing {
        public var canEdit: Bool
        public var canMove: Bool
        public var style: UITableViewCellEditingStyle
        public var titleForDeleteConfirmationButton: String?
        public var actions: [UITableViewRowAction]?
        public var shouldIndent: Bool

        public init(canEdit: Bool = false,
                    canMove: Bool = false,
                    style: UITableViewCellEditingStyle = .none,
                    titleForDeleteConfirmationButton: String? = nil,
                    actions: [UITableViewRowAction]? = nil,
                    shouldIndent: Bool = true) {

            self.canEdit = canEdit
            self.canMove = canMove
            self.style = style
            self.titleForDeleteConfirmationButton = titleForDeleteConfirmationButton
            self.actions = actions
            self.shouldIndent = shouldIndent
        }

        public static let `default` = Editing()
    }

    public var indentationLevel: Int
    public var shouldShowMenu: Bool
    public var canFocus: Bool
    public var selection: Selection
    public var editing: Editing

    public init(selection: Selection = .default,
                editing: Editing = .default,
                shouldShowMenu: Bool = false,
                indentationLevel: Int = 0,
                canFocus: Bool = true) {

        self.selection = selection
        self.editing = editing
        self.shouldShowMenu = shouldShowMenu
        self.indentationLevel = indentationLevel
        self.canFocus = canFocus
    }

    public static let `default` = TableRowConfiguration()
}

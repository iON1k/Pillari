public struct CollectionRowConfiguration {
    public struct Should {
        public var highlight: Bool
        public var select: Bool
        public var deselect: Bool
        public var showMenu: Bool
        public var springLoad: Bool

        public init(highlight: Bool = true,
                    select: Bool = true,
                    deselect: Bool = true,
                    showMenu: Bool = false,
                    springLoad: Bool = true) {

            self.highlight = highlight
            self.select = select
            self.deselect = deselect
            self.showMenu = showMenu
            self.springLoad = springLoad
        }

        public static let `default` = Should()
    }

    public var canMove: Bool
    public var canFocus: Bool
    public var should: Should

    public init(should: Should = .default,
                canMove: Bool = false,
                canFocus: Bool = true) {

        self.should = should
        self.canMove = canMove
        self.canFocus = canFocus
    }

    public static let `default` = CollectionRowConfiguration()
}

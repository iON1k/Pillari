public struct TableHeaderFooterConfiguration {
    public var title: String?

    public init(title: String? = nil) {
        self.title = title
    }

    public static let `default` = TableHeaderFooterConfiguration()
}

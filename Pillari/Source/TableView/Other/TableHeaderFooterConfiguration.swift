//  Created by Anton Popkov on 29.09.17.

public struct TableHeaderFooterConfiguration {
    public var title: String?

    public init(title: String? = nil) {
        self.title = title
    }

    public static let `default` = TableHeaderFooterConfiguration()
}

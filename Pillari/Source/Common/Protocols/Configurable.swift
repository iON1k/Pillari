public protocol Configurable {
    associatedtype Configuration

    func configure(with _: Configuration)
}

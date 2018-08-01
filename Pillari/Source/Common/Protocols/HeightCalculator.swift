public protocol HeightCalculator {
    associatedtype Configuration

    static func calculateHeight(for configuration: Configuration, with width: CGFloat) -> CGFloat

    static func calculateEstimatedHeight(for configuration: Configuration, with width: CGFloat) -> CGFloat
}

public extension HeightCalculator {
    static func calculateEstimatedHeight(for configuration: Configuration, with width: CGFloat) -> CGFloat {
        return calculateHeight(for: configuration, with: width)
    }
}

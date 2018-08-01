public extension CollectionElementSizeCalculator {
    convenience init<TCalculator: HeightCalculator>(_ calculatorType: TCalculator.Type, item: TCalculator.Configuration, width: CGFloat) {
        self.init { _ in
            let height = TCalculator.calculateHeight(for: item, with: width)
            return CGSize(width: width, height: height)
        }
    }

    convenience init<TCalculator: HeightCalculator>(_ calculatorType: TCalculator.Type, item: TCalculator.Configuration) {
        self.init { collectionView in
            let width = collectionView.bounds.width
            let height = TCalculator.calculateHeight(for: item, with: width)
            return CGSize(width: width, height: height)
        }
    }
}

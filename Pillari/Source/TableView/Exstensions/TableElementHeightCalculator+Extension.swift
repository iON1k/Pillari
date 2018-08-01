//  Created by Anton Popkov on 03.10.17.

public extension TableElementHeightCalculator {
    convenience init<TCalculator: HeightCalculator>(_ calculatorType: TCalculator.Type, item: TCalculator.Configuration) {
        self.init(heightCalculationHandler: { tableView -> CGFloat in
            return TCalculator.calculateHeight(for: item, with: tableView.bounds.width)
        }, estimatedHeightCalculationHandler: { tableView -> CGFloat in
            TCalculator.calculateEstimatedHeight(for: item, with: tableView.bounds.width)
        })
    }

    convenience init(height: CGFloat, estimatedHeight: CGFloat) {
        self.init(heightCalculationHandler: { _ -> CGFloat in
            return height
        }, estimatedHeightCalculationHandler: { _ -> CGFloat in
            estimatedHeight
        })
    }
}

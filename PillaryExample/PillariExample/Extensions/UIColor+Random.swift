//  Created by Anton Popkov on 31.10.17.

import UIKit

extension UIColor {
    static func random() -> UIColor {
        return UIColor(red: CGFloat(drand48()), green: CGFloat(drand48()), blue: CGFloat(drand48()), alpha: 1)
    }

    static func randomColors(count: Int) -> [UIColor] {
        return Array(repeating: random, count: count)
            .map({ (colorGenerator) -> UIColor in
                return colorGenerator()
            })
    }
}

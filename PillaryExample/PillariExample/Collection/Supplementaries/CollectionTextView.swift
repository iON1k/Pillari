//  Created by Anton Popkov on 01.11.17.

import Pillari

final class CollectionTextView: UICollectionReusableView, Configurable, HeightCalculator {
    private let textLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center

        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    static func calculateHeight(for configuration: String, with width: CGFloat) -> CGFloat {
        return 100
    }

    func configure(with configuration: String) {
        textLabel.text = configuration
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        textLabel.frame = bounds
    }

    private func setup() {
        backgroundColor = .white
        addSubview(textLabel)
    }
}

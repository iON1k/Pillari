import Pillari

class TableTextView: UITableViewHeaderFooterView, Configurable {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center

        return label
    }()

    struct Appearance {
        let textColor: UIColor

        init(textColor: UIColor = .black) {
            self.textColor = textColor
        }

        static let `default` = Appearance()
    }

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)

        addSubview(titleLabel)
        configure(appearance: .default)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    struct Configuration {
        let text: String
        let appearance: Appearance

        init(text: String, appearance: Appearance = .default) {
            self.text = text
            self.appearance = appearance
        }
    }

    func configure(with configuration: Configuration) {
        titleLabel.text = configuration.text
        configure(appearance: configuration.appearance)
    }

    func configure(appearance: Appearance) {
        titleLabel.textColor = appearance.textColor
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        titleLabel.frame = bounds
    }
}

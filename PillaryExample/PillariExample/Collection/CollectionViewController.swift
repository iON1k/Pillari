//  Created by Anton Popkov on 31.10.17.

import Pillari

final class CollectionViewController: UICollectionViewController {
    private let colectionLayout = UICollectionViewFlowLayout()
    private var colors = UIColor.randomColors(count: 102)
    private var collectionPillar: CollectionPillar?

    init(colors: [UIColor] = UIColor.randomColors(count: 102)) {
        self.colors = colors
        super.init(collectionViewLayout: colectionLayout)

        title = "Collection"
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionPillar = createCollectionSections(from: colors)
            .asCollectionFlowLayoutDataProvider(layout: colectionLayout)
            .asCollectionPillar(collectionView: collectionView)
    }

    private func createColoredRow(with color: UIColor) -> CollectionFlowLayoutRowProtocol {
        return CollectionRow<CollectionColoredCell>(
            item: color,
            configuration: CollectionRowConfiguration(canMove: true)) { [weak self] event in
                guard let strongSelf = self else { return }

                switch event {
                case .didSelect:
                    strongSelf.onColoredCellPressed(with: color)
                case .move(let context):
                    strongSelf.onColoredCellMoved(from: context.sourceIndex, to: context.destinationIndex)
                default:
                    break
                }
            }
            .withFlowLayout(sizeCalculator: CGSize(width: 100, height: 100))
    }

    private func createCollectionSections(from colors: [UIColor]) -> [CollectionFlowLayoutSectionProtocol] {
        return colors
            .map { createColoredRow(with: $0) }
            .asFlowLayoutSections(header: createTextSupplementary(with: "Header"),
                                  footer: createTextSupplementary(with: "Footer"),
                                  layoutConfiguration: CollectionFlowLayoutSectionConfiguration(minimumLineSpacing: 10))
    }

    private func onColoredCellMoved(from startIndex: IndexPath, to endIndex: IndexPath) {
        let movedColor = colors.remove(at: startIndex.row)
        colors.insert(movedColor, at: endIndex.row)
        collectionPillar?.dataProvider = createCollectionSections(from: colors)
            .asCollectionFlowLayoutDataProvider(layout: colectionLayout)
    }

    private func onColoredCellPressed(with color: UIColor) {
        navigationController?.pushViewController(UIViewController.create(with: color), animated: true)
    }

    private func createTextSupplementary(with text: String) -> CollectionFlowLayoutSupplementary {
        return CollectionSupplementary<CollectionTextView>(item: text)
            .withFlowLayout(item: text)
    }
}

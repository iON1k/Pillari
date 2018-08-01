//  Created by Anton Popkov on 02.11.17.

import Pillari

final class MainViewController: UIViewController {
    private lazy var tableView = UITableView()
    private var tablePillar: TablePillar?

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Main"

        tablePillar = [
            createTableViewRow(),
            createCollectionViewRow()
            ]
            .asSections()
            .asDataSource()
            .asTablePillar(tableView: tableView)

        view.addSubview(tableView)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }

    private func createTableViewRow() -> TableRowProtocol {
        return createRow(with: "Table", action: onTableRowPressed)
    }

    private func createCollectionViewRow() -> TableRowProtocol {
        return createRow(with: "Collection", action: onCollectionRowPressed)
    }

    private func createRow(with title: String, action: @escaping () -> Void) -> TableRowProtocol {
        return TableRow<UITableViewCell>(heightCalculator: CGFloat(50)) { event in
            switch event {
            case .didSelect(let context):
                context.table .deselectRow(at: context.index, animated: true)
                action()
            case .didConfigure(let context):
                let cell = context.cell
                cell.textLabel?.text = title
            default:
                break
            }
        }
    }

    private func onTableRowPressed() {
        navigationController?.pushViewController(TableViewController(), animated: true)
    }

    private func onCollectionRowPressed() {
        navigationController?.pushViewController(CollectionViewController(), animated: true)
    }
}

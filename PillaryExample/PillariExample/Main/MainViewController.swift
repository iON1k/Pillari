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
        return TableRow<UITableViewCell>(heightCalculator: CGFloat(50))
            .withDidSelect { _ in action() }
            .withDidConfigure { $0.cell.textLabel?.text = title }
    }

    private func onTableRowPressed() {
        navigationController?.pushViewController(TableViewController(), animated: true)
    }

    private func onCollectionRowPressed() {
        navigationController?.pushViewController(CollectionViewController(), animated: true)
    }
}

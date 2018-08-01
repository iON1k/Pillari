import Pillari

final class TableViewController: UIViewController {
    private var colors: [UIColor]
    private var tablePillar: TablePillar?

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none

        return tableView
    } ()

    init(colors: [UIColor] = UIColor.randomColors(count: 50)) {
        self.colors = colors
        super.init(nibName: nil, bundle: nil)

        title = "Table"
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tablePillar = createTableSections(from: colors)
            .asDataSource()
            .asTablePillar(tableView: tableView)

        view.addSubview(tableView)

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: nil, style: .plain, target: self, action: #selector(onSwitchEditMode))
        updateEditButtonState()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func createTableSections(from colors: [UIColor]) -> [TableSectionProtocol] {
        return colors
            .map { return createColoredRow(from: $0) }
            .asSections(
                header: TableHeaderFooter<TableTextView>(
                    item: TableTextView.Configuration(text: "Header", appearance: TableTextView.Appearance(textColor: .red)),
                    heightCalculator: CGFloat(30)
                ),
                footer: TableHeaderFooter<TableTextView>(
                    item: TableTextView.Configuration(text: "Footer", appearance: TableTextView.Appearance(textColor: .blue)),
                    heightCalculator: CGFloat(50)
                )
            )
    }

    private func createColoredRow(from color: UIColor) -> TableRowProtocol {
        let configuration = TableRowConfiguration(editing: TableRowConfiguration.Editing(canEdit: true, canMove: true))
        return TableRow<TableColoredCell>(item: color, configuration: configuration)
            .withDidSelect { [weak self] _ in
                self?.onColoredCellPressed(with: color)
            }
            .withMove { [weak self] context in
                self?.onColoredCellMoved(from: context.sourceIndex, to: context.destinationIndex)
            }
    }

    private func onColoredCellPressed(with color: UIColor) {
        navigationController?.pushViewController(UIViewController.create(with: color), animated: true)
    }

    private func onColoredCellMoved(from startIndex: IndexPath, to endIndex: IndexPath) {
        let movedColor = colors.remove(at: startIndex.row)
        colors.insert(movedColor, at: endIndex.row)
        tablePillar?.dataSource = createTableSections(from: colors).asDataSource()
    }

    @objc private func onSwitchEditMode() {
        tableView.isEditing = !tableView.isEditing
        updateEditButtonState()
    }

    private func updateEditButtonState() {
        navigationItem.rightBarButtonItem?.title = tableView.isEditing ? "Done" : "Edit"
    }
}

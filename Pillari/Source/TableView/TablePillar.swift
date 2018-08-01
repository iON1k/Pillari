public final class TablePillar {
    let tableViewDataSourceImpl = UITableViewDataSourceImplementation()
    let tableViewDelegateImpl = UITableViewDelegateImplementation()

    public weak var tableView: UITableView? {
        willSet {
            resetTableView()
        }

        didSet {
            setupTableView()
        }
    }

    public var dataSource: TableDataSourceProtocol {
        didSet {
            didUpdatedDataSource()
        }
    }

    public var forwardDelegate: UITableViewDelegate? {
        get {
            return tableViewDelegateImpl.forwardDelegate
        }

        set {
            tableViewDelegateImpl.forwardDelegate = newValue
        }
    }

    public var forwardDataSource: UITableViewDataSource? {
        get {
            return tableViewDataSourceImpl.forwardDataSource
        }

        set {
            tableViewDataSourceImpl.forwardDataSource = newValue
        }
    }

    public init(tableView: UITableView? = nil,
                dataSource: TableDataSourceProtocol = TableDataSource()) {
        self.tableView = tableView
        self.dataSource = dataSource

        didUpdatedDataSource()
        setupTableView()
    }

    private func didUpdatedDataSource() {
        tableViewDataSourceImpl.dataSource = dataSource
        tableViewDelegateImpl.dataSource = dataSource
    }

    private func setupTableView() {
        tableView?.dataSource = tableViewDataSourceImpl
        tableView?.delegate = tableViewDelegateImpl
    }

    private func resetTableView() {
        if tableView?.delegate === tableViewDelegateImpl {
            tableView?.delegate = nil
        }

        if tableView?.dataSource === tableViewDataSourceImpl {
            tableView?.dataSource = nil
        }
    }

    deinit {
        resetTableView()
    }
}

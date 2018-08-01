public final class CollectionPillar {
    let collectionViewDataSourceImpl: UICollectionViewDataSourceImplementation
    let collectionViewDelegateImpl: UICollectionViewDelegateImplementation

    public weak var collectionView: UICollectionView? {
        willSet {
            resetCollectionView()
        }

        didSet {
            setupCollectionView()
        }
    }

    public var dataProvider: CollectionDataProviderProtocol {
        didSet {
            didUpdatedDataSource()
        }
    }

    public var forwardDelegate: UICollectionViewDelegate? {
        get {
            return collectionViewDelegateImpl.forwardDelegate
        }

        set {
            collectionViewDelegateImpl.forwardDelegate = newValue
        }
    }

    public var forwardDataSource: UICollectionViewDataSource? {
        get {
            return collectionViewDataSourceImpl.forwardDataSource
        }

        set {
            collectionViewDataSourceImpl.forwardDataSource = newValue
        }
    }

    public init(collectionView: UICollectionView? = nil,
                dataProvider: CollectionDataProviderProtocol) {
        self.collectionView = collectionView
        self.dataProvider = dataProvider
        collectionViewDataSourceImpl = UICollectionViewDataSourceImplementation(dataSource: dataProvider.dataSource)
        collectionViewDelegateImpl = UICollectionViewDelegateImplementation(dataSource: dataProvider.dataSource)

        didUpdatedDataSource()
        setupCollectionView()
    }

    private func didUpdatedDataSource() {
        collectionViewDelegateImpl.dataSource = dataProvider.dataSource
        collectionViewDataSourceImpl.dataSource = dataProvider.dataSource
        updateCollectionLayout()
    }

    private func updateCollectionLayout() {
        guard collectionView?.collectionViewLayout != dataProvider.layout else {
            return
        }

        collectionView?.collectionViewLayout = dataProvider.layout
    }

    private func setupCollectionView() {
        collectionView?.delegate = collectionViewDelegateImpl
        collectionView?.dataSource = collectionViewDataSourceImpl
        updateCollectionLayout()
    }

    private func resetCollectionView() {
        if collectionView?.delegate === collectionViewDelegateImpl {
            collectionView?.delegate = nil
        }

        if collectionView?.dataSource === collectionViewDataSourceImpl {
            collectionView?.dataSource = nil
        }
    }

    deinit {
        resetCollectionView()
    }
}

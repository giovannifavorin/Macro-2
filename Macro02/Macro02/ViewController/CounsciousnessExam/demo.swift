//import UIKit
//
//class ConsciousnessExamViewController: UIViewController {
//    private var viewModel: SinViewModel = SinViewModel()
//    
//    private var collectionView: UICollectionView!
//    private var dataSource: UICollectionViewDiffableDataSource<Section, Sin>!
//    
//    enum Section {
//        case available
//        case marked
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        viewModel.delegate = self
//        viewModel.fetchAllSins()
//        
//        setupCollectionView()
//        configureDataSource()
//        setupUI()
//    }
//    
//    private func setupUI() {
//        view.backgroundColor = .white
//    }
//
//    private func setupCollectionView() {
//        let layout = UICollectionViewFlowLayout()
//        layout.itemSize = CGSize(width: view.frame.width - 20, height: 50)
//        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 20, right: 10)
//        
//        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
//        collectionView.backgroundColor = .white
//        collectionView.register(SinCell.self, forCellWithReuseIdentifier: SinCell.reuseIdentifier)
//        view.addSubview(collectionView)
//    }
//    
//    private func configureDataSource() {
//        dataSource = UICollectionViewDiffableDataSource<Section, Sin>(collectionView: collectionView) { collectionView, indexPath, sin in
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SinCell.reuseIdentifier, for: indexPath) as! SinCell
//            cell.configure(with: sin)
//            cell.backgroundColor = sin.isMarked ? .systemPink : .systemGray4
//            return cell
//        }
//        collectionView.dataSource = dataSource
//        updateDataSource()
//    }
//    
//    private func updateDataSource() {
//        var snapshot = NSDiffableDataSourceSnapshot<Section, Sin>()
//        
//        let availableSins = viewModel.savedSins.filter { !$0.isMarked }
//        let markedSins = viewModel.savedSins.filter { $0.isMarked }
//        
//        snapshot.appendSections([.available, .marked])
//        snapshot.appendItems(availableSins, toSection: .available)
//        snapshot.appendItems(markedSins, toSection: .marked)
//        
//        dataSource.apply(snapshot, animatingDifferences: true)
//    }
//}
//
//// MARK: - SinViewModelDelegate
//
//extension ConsciousnessExamViewController: SinViewModelDelegate {
//    func didUpdateSavedSins(_ savedSins: [Sin]) {
//        updateDataSource()
//    }
//}
//
//// MARK: - SinCell
//
//class SinCell: UICollectionViewCell {
//    static let reuseIdentifier = "SinCell"
//    
//    private let sinLabel = UILabel()
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupUI()
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    private func setupUI() {
//        sinLabel.translatesAutoresizingMaskIntoConstraints = false
//        contentView.addSubview(sinLabel)
//        
//        NSLayoutConstraint.activate([
//            sinLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
//            sinLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
//            sinLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
//        ])
//    }
//    
//    func configure(with sin: Sin) {
//        sinLabel.text = sin.sinDescription
//        sinLabel.textColor = sin.isMarked ? .white : .black
//    }
//}

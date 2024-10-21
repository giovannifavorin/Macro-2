import UIKit

class DailyLiturgyViewController: UIViewController {
    
    // MARK: - UI Elements
    let titleLabel = TextComponent("Liturgia Diária")
    let textSizeButton = ButtonComponent("Aa")
    let liturgyCardView = LiturgyCardView() /// cartão que conterá informações importantes como, semana da liturgia, data, dia, dia da semana
    let segmentedControl = UISegmentedControl(items: ["1 Leitura", "Salmos", "Evangelho"])
    let liturgyTextView = TextComponent()
    let scrollView = UIScrollView()
    
    let model = LiturgyCardView() /// Model com a configuração de dynamic types
    var viewModel: DailyLiturgyViewModel?
    let apiManager = APIManager()

    var currentLiturgia: Liturgia?
    
    var coordinator: DailyLiturgyCoordinator?
    
    // MARK: - Initializer
    init() {
        super.init(nibName: nil, bundle: nil)
        self.setupView()
        fetchLiturgyData()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup Views
    func setupView() {
        view.backgroundColor = .systemBackground
        
        // Title Label Setup
        titleLabel.font = UIFont.setCustomFont(.titulo1)
        titleLabel.textColor = .label
        view.addSubview(titleLabel)
        
        // Button for changing text size
        textSizeButton.setText("Aa", for: .normal)
        textSizeButton.setTitleColor(.black, for: .normal)
        textSizeButton.act = didTapTextSizeButton
        view.addSubview(textSizeButton)
        
        // Liturgy Card View
        liturgyCardView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(liturgyCardView)
        
        // Segment Control
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(didChangeSegment), for: .valueChanged)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(segmentedControl)
        
        // Scroll View Setup
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        // Liturgy Text View Setup
        liturgyTextView.textAlignment = .left // Alinha o texto à esquerda
        liturgyTextView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(liturgyTextView)
        
        scrollView.contentSize = CGSize(width: scrollView.frame.width, height: liturgyTextView.frame.height)
        
        // Set up Modal View (initially hidden)
        setupModalView()
        
        // Set up constraints
        setupConstraints()
    }
    
    // MARK: - Setup Modal View
    func setupModalView() {
        model.backgroundColor = .lightGray
        model.layer.cornerRadius = 16
        model.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(model)
        
        // Initially hide modal
        model.isHidden = true
        
        NSLayoutConstraint.activate([
            model.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            model.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            model.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16),
            model.heightAnchor.constraint(equalToConstant: 200)
        ])
    }

    // MARK: - Fetch Liturgy Data
    func fetchLiturgyData() {
        apiManager.fetchData(from: "https://liturgiadiaria.site", responseType: Liturgia.self) { [weak self] result in
            switch result {
            case .success(let liturgia):
                DispatchQueue.main.async {
                    self?.currentLiturgia = liturgia
                    self?.updateLiturgyText(for: self?.segmentedControl.selectedSegmentIndex ?? 0)
                    self?.liturgyCardView.update(with: liturgia) // Atualiza a LiturgyCardView com os dados da liturgia
                }
            case .failure(let error):
                print("Erro ao buscar a liturgia: \(error)")
            }
        }
    }
    
    // MARK: - Update Liturgy Text
    func updateLiturgyText(for segmentIndex: Int) {
        guard let liturgia = currentLiturgia else { return }
        
        switch segmentIndex {
        case 0: // 1 Leitura
            liturgyTextView.text = liturgia.primeiraLeitura?.texto ?? "Texto da primeira leitura não disponível."
        case 1: // Salmos
            liturgyTextView.text = liturgia.salmo?.texto ?? "Texto do salmo não disponível."
        case 2: // Evangelho
            liturgyTextView.text = liturgia.evangelho?.texto ?? "Texto do evangelho não disponível."
        default:
            break
        }
    }
    // MARK: - Actions
    @objc func didTapTextSizeButton() {
        // Logic to change text size
        print("Change text size")
        model.isHidden.toggle()

    }
    
    @objc func didChangeSegment() {
        // Atualizar texto da liturgia de acordo com o segmento selecionado
        updateLiturgyText(for: segmentedControl.selectedSegmentIndex)
    }
}

///Extenção com apenas as constrains
extension DailyLiturgyViewController {
    // MARK: - Setup Constraints
    func setupConstraints() {
        NSLayoutConstraint.activate([
            // Title label constraints
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            // Text size button constraints
            textSizeButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            textSizeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            // Liturgy Card View constraints
            liturgyCardView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            liturgyCardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            liturgyCardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            liturgyCardView.heightAnchor.constraint(equalToConstant: 100),
            
            // Segment Control constraints
            segmentedControl.topAnchor.constraint(equalTo: liturgyCardView.bottomAnchor, constant: 16),
            segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            // ScrollView constraints
            scrollView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 16),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100),
            
            // Liturgy Text View constraints
            liturgyTextView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            liturgyTextView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            liturgyTextView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            liturgyTextView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            liturgyTextView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
        ])
    }

}


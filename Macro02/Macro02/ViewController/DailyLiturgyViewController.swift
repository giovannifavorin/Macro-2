import UIKit

class DailyLiturgyViewController: UIViewController {
    
    // MARK: - UI Elements
    let titleLabel = TextComponent("Liturgia Diária")
    let textSizeButton = ButtonComponent("Aa")
    let liturgyCardView = UIView()
    let segmentedControl = UISegmentedControl(items: ["1 Leitura", "Salmos", "Evangelho"])
    let liturgyTextView = UITextView()
    let settingsButton = ButtonComponent("⚙️")
    
    let modalView = UIView()
    let viewModel: DailyLiturgyViewModel!
    let apiManager = LiturgiaDiariaAPI()

    var currentLiturgia: Liturgia? // Armazena os dados atuais da liturgia
    
    // MARK: - Initializer
    init(viewModel: DailyLiturgyViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.setupView()
        fetchLiturgyData()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup Views
    func setupView() {
        view.backgroundColor = .white
        
        // Title Label Setup
        titleLabel.font = UIFont.setCustomFont(.titulo1)
        titleLabel.textColor = .black
        view.addSubview(titleLabel)
        
        // Button for changing text size
        textSizeButton.setText("Aa", for: .normal)
        textSizeButton.setTitleColor(.black, for: .normal)
        textSizeButton.act = didTapTextSizeButton
        view.addSubview(textSizeButton)
        
        // Liturgy Card View
        liturgyCardView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        liturgyCardView.layer.cornerRadius = 8
        liturgyCardView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(liturgyCardView)
        
        // Segment Control
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(didChangeSegment), for: .valueChanged)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(segmentedControl)
        
        // Liturgy Text View
        liturgyTextView.isEditable = false
        liturgyTextView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(liturgyTextView)
        
        // Button to open settings modal
        settingsButton.act = didTapSettingsButton
        view.addSubview(settingsButton)
        
        // Set up Modal View (initially hidden)
        setupModalView()
        
        // Set up constraints
        setupConstraints()
    }
    
    // MARK: - Setup Modal View
    func setupModalView() {
        modalView.backgroundColor = .lightGray
        modalView.layer.cornerRadius = 16
        modalView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(modalView)
        
        // Initially hide modal
        modalView.isHidden = true
        
        NSLayoutConstraint.activate([
            modalView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            modalView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            modalView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16),
            modalView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
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
            
            // Liturgy Text View constraints
            liturgyTextView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 16),
            liturgyTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            liturgyTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            liturgyTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            
            // Settings button constraints
            settingsButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            settingsButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])
    }

    // MARK: - Fetch Liturgy Data
    func fetchLiturgyData() {
        apiManager.fetchLiturgia { [weak self] result in
            switch result {
            case .success(let liturgia):
                DispatchQueue.main.async {
                    self?.currentLiturgia = liturgia
                    self?.updateLiturgyText(for: self?.segmentedControl.selectedSegmentIndex ?? 0)
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
    }
    
    @objc func didChangeSegment() {
        // Atualizar texto da liturgia de acordo com o segmento selecionado
        updateLiturgyText(for: segmentedControl.selectedSegmentIndex)
    }
    
    @objc func didTapSettingsButton() {
        // Toggle modal view visibility
        modalView.isHidden.toggle()
    }
}

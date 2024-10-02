import UIKit

class DailyLiturgyViewController: UIViewController {
    
    // MARK: - UI Elements
    let titleLabel = TextComponent("Liturgia Diária")
    let textSizeButton = ButtonComponent("Aa")
    let liturgyCardView = LiturgyCardView() // Custom View for the liturgy card
    let segmentedControl = UISegmentedControl(items: ["1 Leitura", "Salmos", "Evangelho"])
    let liturgyTextView = TextComponent()
    let scrollView = UIScrollView()
    
    let modalView = LiturgyCardView()
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
        
        // Liturgy Card View Setup
        liturgyCardView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(liturgyCardView) // Adiciona LiturgyCardView à hierarquia de views
        
        // Segment Control
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(didChangeSegment), for: .valueChanged)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(segmentedControl)
        
        // Scroll View Setup
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        // Liturgy Text View Setup
        liturgyTextView.textAlignment = .left
        liturgyTextView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(liturgyTextView)
        
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
            liturgyCardView.heightAnchor.constraint(equalToConstant: 150), // Ajuste a altura do card como necessário
            
            // Segment Control constraints
            segmentedControl.topAnchor.constraint(equalTo: liturgyCardView.bottomAnchor, constant: 16),
            segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            // ScrollView constraints
            scrollView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 16),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            
            // Liturgy Text View constraints
            liturgyTextView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            liturgyTextView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            liturgyTextView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            liturgyTextView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            liturgyTextView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
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
        modalView.isHidden.toggle()
    }
    
    @objc func didChangeSegment() {
        updateLiturgyText(for: segmentedControl.selectedSegmentIndex)
    }
}

// MARK: - LiturgyCardView
class LiturgyCardView: UIView {

    private let weekLabel = UILabel()
    private let dayNameLabel = UILabel()
    private let dayNumberLabel = UILabel()
    private let monthYearLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = .white
        layer.cornerRadius = 8
        layer.borderWidth = 1
        layer.borderColor = UIColor.black.cgColor
        
        weekLabel.translatesAutoresizingMaskIntoConstraints = false
        dayNameLabel.translatesAutoresizingMaskIntoConstraints = false
        dayNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        monthYearLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(weekLabel)
        addSubview(dayNameLabel)
        addSubview(dayNumberLabel)
        addSubview(monthYearLabel)
        
        // Define constraints
        NSLayoutConstraint.activate([
            weekLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            weekLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            
            dayNameLabel.topAnchor.constraint(equalTo: weekLabel.bottomAnchor, constant: 8),
            dayNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            
            dayNumberLabel.topAnchor.constraint(equalTo: dayNameLabel.bottomAnchor, constant: 8),
            dayNumberLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            
            monthYearLabel.topAnchor.constraint(equalTo: dayNumberLabel.bottomAnchor, constant: 8),
            monthYearLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            monthYearLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
    }
    
    func update(with liturgia: Liturgia) {
        weekLabel.text = liturgia.data ?? "Sem dados"
        dayNameLabel.text = liturgia.dia ?? "Dia não disponível"
        
        if let date = liturgia.data {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            
            if let dateObject = dateFormatter.date(from: date) {
                let dayFormatter = DateFormatter()
                dayFormatter.dateFormat = "d"
                
                let monthYearFormatter = DateFormatter()
                monthYearFormatter.dateFormat = "MMMM yyyy"
                
                dayNumberLabel.text = dayFormatter.string(from: dateObject)
                monthYearLabel.text = monthYearFormatter.string(from: dateObject)
            }
        } else {
            dayNumberLabel.text = "Dia não disponível"
            monthYearLabel.text = "Mês/Ano não disponível"
        }
    }
}

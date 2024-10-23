import UIKit
import CoreData

class TestViewController: UIViewController {
    
    // MARK: - UI Elements
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let confessionLabel = UILabel()
    private let sinLabel = UILabel()
    private let sinsInExamLabel = UILabel()
    private let conscienceExamLabel = UILabel()
    private let allSinsLabel = UILabel()
    
    private let penanceTextField = UITextField()
    private let commandmentTextField = UITextField()
    private let sinDescriptionTextField = UITextField()
    
    private let createConfessionButton = UIButton()
    private let createSinButton = UIButton()
    private let createSinsInExaminationButton = UIButton()
    private let createConscienceExamButton = UIButton()
    private let fetchConfessionsButton = UIButton()
    private let fetchExamsButton = UIButton()
    private let fetchAllSinsButton = UIButton()
    
    // ViewModel
    private var viewModel: SinViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModel = SinViewModel() // Inicializa o ViewModel
        viewModel.fetchCommittedSins() // Busca os pecados cometidos inicialmente
        
        // Adicionar gesto para fechar o teclado ao tocar fora dos campos de texto
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        // Configurar scroll view e content view
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        // Constraints para scroll view e content view
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        // Configurar labels e text fields
        confessionLabel.numberOfLines = 0
        sinLabel.numberOfLines = 0
        sinsInExamLabel.numberOfLines = 0
        conscienceExamLabel.numberOfLines = 0
        allSinsLabel.numberOfLines = 0
        
        penanceTextField.placeholder = "Enter penance"
        penanceTextField.borderStyle = .roundedRect
        
        commandmentTextField.placeholder = "Enter commandment"
        commandmentTextField.borderStyle = .roundedRect
        
        sinDescriptionTextField.placeholder = "Enter sin description"
        sinDescriptionTextField.borderStyle = .roundedRect
        
        // Configurar botões
        setupButton(createConfessionButton, title: "Create Confession", color: .blue, action: #selector(createConfession))
        setupButton(createSinButton, title: "Create Sin", color: .green, action: #selector(createSins))
        setupButton(createSinsInExaminationButton, title: "Create SinsInExamination", color: .orange, action: #selector(createSinsInExamination))
        setupButton(createConscienceExamButton, title: "Create Conscience Exam", color: .purple, action: #selector(createConscienceExam))
        setupButton(fetchConfessionsButton, title: "Fetch Confessions", color: .cyan, action: #selector(fetchConfessions))
        setupButton(fetchExamsButton, title: "Fetch Exams", color: .magenta, action: #selector(fetchExams))
        setupButton(fetchAllSinsButton, title: "Fetch All Sins", color: .yellow, action: #selector(fetchAllSins))
        
        // Configurar stack view
        let stackView = UIStackView(arrangedSubviews: [
            penanceTextField,
            commandmentTextField,
            sinDescriptionTextField,
            createConfessionButton,
            createSinButton,
            createSinsInExaminationButton,
            createConscienceExamButton,
            fetchConfessionsButton,
            fetchExamsButton,
            fetchAllSinsButton,
            confessionLabel,
            sinLabel,
            sinsInExamLabel,
            conscienceExamLabel,
            allSinsLabel
        ])
        
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(stackView)
        
        // Constraints para stack view
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }
    
    // Método auxiliar para configurar botões
    private func setupButton(_ button: UIButton, title: String, color: UIColor, action: Selector) {
        button.setTitle(title, for: .normal)
        button.backgroundColor = color
        button.layer.cornerRadius = 5
        button.addTarget(self, action: action, for: .touchUpInside)
    }
    
    // MARK: - Button Actions
    @objc private func createConfession() {
        guard let penance = penanceTextField.text, !penance.isEmpty else {
            confessionLabel.text = "Please enter a penance."
            return
        }
        
        if let confession = DataManager.shared.createConfession(date: Date(), penance: penance, exams: []) {
            confessionLabel.text = "Confession created: Penitence - \(confession.penance ?? "")"
            viewModel.fetchCommittedSins() // Atualiza os pecados cometidos
        } else {
            confessionLabel.text = "Error creating confession."
        }
    }
    
    @objc private func createSins() {
        guard let commandment = commandmentTextField.text, !commandment.isEmpty,
              let sinDescription = sinDescriptionTextField.text, !sinDescription.isEmpty else {
            sinLabel.text = "Please enter commandment and sin description."
            return
        }
        
        let sin = DataManager.shared.createSin(commandments: commandment, commandmentDescription: "", sinDescription: sinDescription)
        sinLabel.text = "Sin created: \(sin?.commandments ?? "") - \(sin?.sinDescription ?? "")"
        viewModel.fetchCommittedSins() // Atualiza os pecados cometidos
    }
    
    @objc private func createSinsInExamination() {
        // Aqui você pode implementar a lógica de criação de SinsInExamination
        // Exemplo:
        // if let sin1 = DataManager.shared.createSin(...), let sin2 = DataManager.shared.createSin(...) {
        //     if let sinsInExam = DataManager.shared.createSinsInExamination(...) {
        //         // Atualize a label correspondente
        //     }
        // }
    }
    
    @objc private func createConscienceExam() {
        // Aqui você pode implementar a lógica de criação de ConscienceExam
    }
    
    @objc private func fetchConfessions() {
        let confessions = DataManager.shared.fetchAllConfessions() // Assume que este método retorna [Confession]
        if confessions.isEmpty {
            confessionLabel.text = "No confessions found."
        } else {
            confessionLabel.text = "Confessions fetched: \n" + confessions.map { "Penance - \($0.penance ?? ""), Date - \($0.confessionDate ?? Date())" }.joined(separator: "\n")
        }
    }
    
    @objc private func fetchExams() {
        let confessions = DataManager.shared.fetchAllConfessions()
        if let firstConfession = confessions.first {
            let exams = DataManager.shared.fetchAllExams(for: firstConfession) // Assume que este método retorna [ConscienceExam]
            if exams.isEmpty {
                sinsInExamLabel.text = "No exams found for the first confession."
            } else {
                sinsInExamLabel.text = "Exams fetched for the first confession: \n" + exams.map { "Date - \($0.examDate ?? Date())" }.joined(separator: "\n")
            }
        } else {
            sinsInExamLabel.text = "No confessions found."
        }
    }
    
    @objc private func fetchAllSins() {
        let sins = DataManager.shared.fetchAllSins() // Assume que este método retorna [Sin]
        if sins.isEmpty {
            allSinsLabel.text = "No sins found."
        } else {
            allSinsLabel.text = "All Sins fetched: \n" + sins.map { "\($0.commandments ?? "") - \($0.sinDescription ?? "")" }.joined(separator: "\n")
        }
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}

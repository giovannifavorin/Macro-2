import UIKit
import CoreData

class TestViewController: UIViewController {
    
    // MARK: - UI Elements
    private let confessionLabel = UILabel()
    private let sinLabel = UILabel()
    private let sinsInExamLabel = UILabel()
    private let conscienceExamLabel = UILabel()
    
    private let createConfessionButton = UIButton()
    private let createSinButton = UIButton()
    private let createSinsInExaminationButton = UIButton()
    private let createConscienceExamButton = UIButton()
    private let fetchConfessionsButton = UIButton()
    private let fetchExamsButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        // Configurar labels
        confessionLabel.numberOfLines = 0
        sinLabel.numberOfLines = 0
        sinsInExamLabel.numberOfLines = 0
        conscienceExamLabel.numberOfLines = 0
        
        // Configurar botões
        createConfessionButton.setTitle("Create Confession", for: .normal)
        createConfessionButton.backgroundColor = .blue
        createConfessionButton.addTarget(self, action: #selector(createConfession), for: .touchUpInside)
        
        createSinButton.setTitle("Create Sins", for: .normal)
        createSinButton.backgroundColor = .green
        createSinButton.addTarget(self, action: #selector(createSins), for: .touchUpInside)
        
        createSinsInExaminationButton.setTitle("Create SinsInExamination", for: .normal)
        createSinsInExaminationButton.backgroundColor = .orange
        createSinsInExaminationButton.addTarget(self, action: #selector(createSinsInExamination), for: .touchUpInside)
        
        createConscienceExamButton.setTitle("Create Conscience Exam", for: .normal)
        createConscienceExamButton.backgroundColor = .purple
        createConscienceExamButton.addTarget(self, action: #selector(createConscienceExam), for: .touchUpInside)
        
        fetchConfessionsButton.setTitle("Fetch Confessions", for: .normal)
        fetchConfessionsButton.backgroundColor = .cyan
        fetchConfessionsButton.addTarget(self, action: #selector(fetchConfessions), for: .touchUpInside)
        
        fetchExamsButton.setTitle("Fetch Exams", for: .normal)
        fetchExamsButton.backgroundColor = .magenta
        fetchExamsButton.addTarget(self, action: #selector(fetchExams), for: .touchUpInside)
        
        // Configurar Stack View
        let stackView = UIStackView(arrangedSubviews: [
            createConfessionButton,
            createSinButton,
            createSinsInExaminationButton,
            createConscienceExamButton,
            fetchConfessionsButton,
            fetchExamsButton,
            confessionLabel,
            sinLabel,
            sinsInExamLabel,
            conscienceExamLabel
        ])
        
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)
        
        // Constraints
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    // MARK: - Button Actions
    @objc private func createConfession() {
        let confession = DataManager.shared.createConfession(date: Date(), penance: "Penance Example", exams: [])
        confessionLabel.text = "Confession created: \(String(describing: confession))"
    }
    
    @objc private func createSins() {
        let sin1 = DataManager.shared.createSin(commandments: "Thou shalt not steal", sinDescription: "Stole something.")
        let sin2 = DataManager.shared.createSin(commandments: "Thou shalt not lie", sinDescription: "Lied about something.")
        sinLabel.text = "Sins created: \(String(describing: sin1)), \(String(describing: sin2))"
    }
    
    @objc private func createSinsInExamination() {
        if let sin1 = DataManager.shared.createSin(commandments: "Thou shalt not steal", sinDescription: "Stole something."),
           let sin2 = DataManager.shared.createSin(commandments: "Thou shalt not lie", sinDescription: "Lied about something.") {
            let sinsInExam = DataManager.shared.createSinsInExamination(isConfessed: true, recurrence: 1, sins: [sin1, sin2])
            sinsInExamLabel.text = "SinsInExamination created: \(String(describing: sinsInExam))"
        }
    }
    
    @objc private func createConscienceExam() {
        // Testando a criação de pecados primeiro
        guard let sin1 = DataManager.shared.createSin(commandments: "Thou shalt not steal", sinDescription: "Stole something."),
              let sin2 = DataManager.shared.createSin(commandments: "Thou shalt not lie", sinDescription: "Lied about something.") else {
            conscienceExamLabel.text = "Error creating sins."
            return
        }
        
        // Criando SinsInExamination
        if let sinsInExam = DataManager.shared.createSinsInExamination(isConfessed: true, recurrence: 1, sins: [sin1, sin2]) {
            // Agora criamos o ConscienceExam
            if let conscienceExam = DataManager.shared.createConscienceExam(date: Date(), sinsInExamination: [sinsInExam]) {
                conscienceExamLabel.text = "ConscienceExam created: \(String(describing: conscienceExam))"
            } else {
                conscienceExamLabel.text = "Error creating ConscienceExam."
            }
        } else {
            conscienceExamLabel.text = "Error creating SinsInExamination."
        }
    }

    
    @objc private func fetchConfessions() {
        if let confessions = DataManager.shared.fetchAllConfessions() {
            confessionLabel.text = "Confessions fetched: \(confessions)"
        }
    }
    
    @objc private func fetchExams() {
        if let confessions = DataManager.shared.fetchAllConfessions(), let firstConfession = confessions.first {
            if let exams = DataManager.shared.fetchAllExams(for: firstConfession) {
                sinsInExamLabel.text = "Exams fetched for the first confession: \(exams)"
            }
        }
    }
}

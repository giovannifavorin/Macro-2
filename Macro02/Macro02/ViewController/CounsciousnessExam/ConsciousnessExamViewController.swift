import UIKit

class ConsciousnessExamViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    private let tableView = UITableView()
    private let saveButton = UIButton(type: .system)
    
    var viewModel: SinViewModel?
    private var currentExam: ConscienceExam?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Exame de Consciência"
        
        setupTableView()
        setupSaveButton()
        
        createNewExam()
        viewModel?.fetchSavedSins()
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "QuestionCell")
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: saveButton.topAnchor, constant: -10),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func setupSaveButton() {
        saveButton.setTitle("Salvar Exame", for: .normal)
        saveButton.addTarget(self, action: #selector(saveExam), for: .touchUpInside)
        view.addSubview(saveButton)
        
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            saveButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func createNewExam() {
        currentExam = viewModel?.createNewConscienceExam() // Método para criar e atribuir um novo exame
    }
    
    @objc private func saveExam() {
        guard let exam = currentExam else { return }
        viewModel?.saveExamToConfession(exam: exam)
        showAlert(title: "Sucesso", message: "Exame de Consciência salvo com sucesso!")
        createNewExam() // Cria um novo exame após salvar o atual
        tableView.reloadData() // Atualiza a interface
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.savedSins.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionCell", for: indexPath)
        let sin = viewModel?.savedSins[indexPath.row]
        
        cell.textLabel?.text = sin?.sinDescription
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let sin = viewModel?.savedSins[indexPath.row],
              let exam = currentExam else { return }
        
        if viewModel?.isQuestionMarkedAsSin(question: sin.sinDescription ?? "") == true {
            viewModel?.unmarkAsSin(question: sin.sinDescription ?? "", for: exam)
        } else {
            viewModel?.markAsSin(commandments: sin.commandments, commandmentDescription: sin.commandmentDescription, question: sin.sinDescription ?? "", for: exam)
        }
        
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

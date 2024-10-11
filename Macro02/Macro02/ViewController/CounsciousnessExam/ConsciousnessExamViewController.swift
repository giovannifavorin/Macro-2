import UIKit

class ConsciousnessExamViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private let tableView = UITableView()
    
    var viewModel: SinViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Exame de Consciência"
        
        setupTableView()
        
        viewModel?.fetchSavedSins() // Busca os pecados salvos
        viewModel?.fetchAllExams() // Busca todos os exames
    }

    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "QuestionCell")
        view.addSubview(tableView)
        
        // Configurar constraints (auto layout)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    // MARK: - UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1 // Apenas uma seção para todos os pecados
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.savedSins.count ?? 0 // Conta os pecados salvos
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionCell", for: indexPath)
        let sin = viewModel?.savedSins[indexPath.row] // Obtém o pecado
        
        cell.textLabel?.text = sin?.sinDescription // Define a descrição do pecado
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sin = viewModel?.savedSins[indexPath.row] // Obtém o pecado selecionado
        
        // Você pode iterar por todos os exames e aplicar a lógica desejada
        for exam in viewModel?.exams ?? [] {
            // Alterna o estado do pecado para cada exame
            if viewModel?.isQuestionMarkedAsSin(question: sin?.sinDescription ?? "") == true {
                viewModel?.unmarkAsSin(question: sin?.sinDescription ?? "", for: exam) // Passa cada exame
                showAlert(title: "Pecado Desmarcado", message: "Você desmarcou: \(sin?.sinDescription ?? "") em um exame.")
            } else {
                viewModel?.markAsSin(commandments: "", commandmentDescription: "", question: sin?.sinDescription ?? "", for: exam) // Passa cada exame
                showAlert(title: "Pecado Marcado", message: "Você marcou: \(sin?.sinDescription ?? "") em um exame.")
            }
        }
        
        // Atualiza a célula para refletir a mudança
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

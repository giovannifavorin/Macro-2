import UIKit
//tenho q aplicar o mark e o unmark nesse projeto, e colocar o keyboard de volta
class ConsciousnessExamViewController: UIViewController, SinViewModelDelegate {

    private var viewModel: SinViewModel = SinViewModel()
    
    // Tabelas para exibir os pecados
    private let savedSinsTableView = UITableView()
    private let committedSinsTableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configura o delegate
        viewModel.delegate = self
        
        // Carrega os dados iniciais
        viewModel.fetchAllSins()
        
        // Configura a interface
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .white // Definindo a cor de fundo do controlador de visualização
        
        // Configura as tabelas
        setupTableView(savedSinsTableView)
        setupTableView(committedSinsTableView)

        // Altera a cor de fundo das tabelas
        savedSinsTableView.backgroundColor = .white
        committedSinsTableView.backgroundColor = .white

        // Adiciona as tabelas à view
        view.addSubview(savedSinsTableView)
        view.addSubview(committedSinsTableView)

        // Configura Auto Layout
        setupConstraints()
    }
    
    private func setupTableView(_ tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "SinCell")
    }
    
    private func setupConstraints() {
        savedSinsTableView.translatesAutoresizingMaskIntoConstraints = false
        committedSinsTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            savedSinsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            savedSinsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            savedSinsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            savedSinsTableView.heightAnchor.constraint(greaterThanOrEqualToConstant: 200), // Altura mínima
            
            committedSinsTableView.topAnchor.constraint(equalTo: savedSinsTableView.bottomAnchor, constant: 20),
            committedSinsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            committedSinsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            committedSinsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor) // Preenche o restante da tela
        ])
    }
    
    // MARK: - SinViewModelDelegate
    
    func didUpdateSavedSins(_ savedSins: [Sin]) {
        // Atualiza a tabela de pecados salvos
        savedSinsTableView.reloadData()
    }
    
    func didUpdateCommittedSins(_ committedSins: [SinsInExamination]) {
        // Atualiza a tabela de pecados confessados
        committedSinsTableView.reloadData()
    }
    
    func didFailToAddSin(with message: String) {
        // Exibe uma mensagem de erro
        showAlert(with: message)
    }

    // Exibe um alerta com uma mensagem
    private func showAlert(with message: String) {
        let alert = UIAlertController(title: "Erro", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true, completion: nil)
    }

    // MARK: - Ações
    
    @objc func markSin(_ sender: UIButton) {
        let sinIndex = sender.tag
        let sin = viewModel.savedSins[sinIndex] // Obtém o pecado correspondente ao índice do botão
        viewModel.markSin(sin)
    }

    @objc func unmarkSin(_ sender: UIButton) {
        let sinIndex = sender.tag
        let committedSin = viewModel.committedSins[sinIndex] // Obtém o SinsInExamination correspondente ao índice do botão
        
        // Acessa o pecado a partir do SinsInExamination
        if let sinsArray = committedSin.sins?.allObjects as? [Sin], let firstSin = sinsArray.first {
            viewModel.unmarkSin(firstSin) // Passa o primeiro pecado para o método unmarkSin
        }
    }
    
    @IBAction func saveExam(_ sender: UIButton) {
        viewModel.saveExamToConfession()
    }
    
    @IBAction func addSin(_ sender: UIButton) {
        let sinDescription = "Descrição do pecado" // Substitua pelo valor obtido do input do usuário
        viewModel.addSin(with: sinDescription)
    }
}

// MARK: - UITableViewDataSource e UITableViewDelegate

extension ConsciousnessExamViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == savedSinsTableView {
            return viewModel.savedSins.count // Acesso à propriedade pública
        } else {
            return viewModel.committedSins.count // Acesso à propriedade pública
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SinCell", for: indexPath)
        
        if tableView == savedSinsTableView {
            let sin = viewModel.savedSins[indexPath.row]
            cell.textLabel?.text = sin.sinDescription
            
            // Adiciona botão de marcar
            let markButton = UIButton(type: .system)
            markButton.setTitle("Marcar", for: .normal)
            markButton.tag = indexPath.row
            markButton.addTarget(self, action: #selector(markSin(_:)), for: .touchUpInside)
            cell.accessoryView = markButton
        } else {
            let committedSin = viewModel.committedSins[indexPath.row]
            if let sinsArray = committedSin.sins?.allObjects as? [Sin], let firstSin = sinsArray.first {
                cell.textLabel?.text = firstSin.sinDescription // Acesso correto à descrição
                
                // Adiciona botão de desmarcar
                let unmarkButton = UIButton(type: .system)
                unmarkButton.setTitle("Desmarcar", for: .normal)
                unmarkButton.tag = indexPath.row
                unmarkButton.addTarget(self, action: #selector(unmarkSin(_:)), for: .touchUpInside)
                cell.accessoryView = unmarkButton
            } else {
                cell.textLabel?.text = "Pecado desconhecido"
            }
        }
        
        return cell
    }
}

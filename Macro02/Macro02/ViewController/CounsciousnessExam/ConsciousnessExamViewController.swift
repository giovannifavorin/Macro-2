//import UIKit
//
//class ConsciousnessExamViewController: UIViewController, SinViewModelDelegate {
//    var viewModel: SinViewModel
//    
//    // Tabelas para exibir os pecados
//    var coordinator: ConsciousnessExamCoordinator?
//    private let savedSinsTableView = UITableView()
//    private let committedSinsTableView = UITableView()
//    private let sinDescriptionTextField = UITextField()
//    
//    private var groupedSins: [String: [Sin]] = [:] // Dicionário para agrupar pecados por mandamento
//    private var mandaments: [String] = [] // Array para armazenar os mandamentos
//    
//    init(viewModel: SinViewModel) {
//        self.viewModel = viewModel
//        super.init(nibName: nil, bundle: nil)
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        // Configura o delegate
//        viewModel.delegate = self
//        
//        // Carrega os dados iniciais
//        viewModel.fetchAllSins()
//        
//        // Configura a interface
//        setupUI()
//    }
//    
//    private func setupUI() {
//        view.backgroundColor = .systemBackground // Usar a cor de fundo do sistema para modo claro/escuro
//        
//        // Configurar o título
//        setupTitleLabel()
//        
//        // Configura o campo de texto para entrada da descrição do pecado
//        setupSinDescriptionTextField()
//        
//        // Configura as tabelas
//        setupTableView(savedSinsTableView)
//        setupTableView(committedSinsTableView)
//        
//        // Altera a cor de fundo das tabelas
//        savedSinsTableView.backgroundColor = .systemBackground
//        committedSinsTableView.backgroundColor = .systemPink
//        
//        // Adiciona as tabelas à view
//        view.addSubview(savedSinsTableView)
//        view.addSubview(committedSinsTableView)
//        
//        // Configura Auto Layout
//        setupConstraints()
//    }
//    
//    private func setupTitleLabel() {
//        let titleLabel = UILabel()
//        titleLabel.text = "Exame de Consciência"
//        titleLabel.font = UIFont.boldSystemFont(ofSize: 24) // Tamanho maior e negrito
//        titleLabel.translatesAutoresizingMaskIntoConstraints = false
//        titleLabel.textColor = .label // Cor que se adapta ao modo claro/escuro
//        titleLabel.textAlignment = .center // Centralizar o texto
//        view.addSubview(titleLabel)
//        
//        // Configura a posição do título
//        NSLayoutConstraint.activate([
//            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
//            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
//            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
//        ])
//    }
//    
//    private func setupSinDescriptionTextField() {
//        sinDescriptionTextField.placeholder = "Digite a descrição do pecado"
//        sinDescriptionTextField.borderStyle = .roundedRect
//        sinDescriptionTextField.translatesAutoresizingMaskIntoConstraints = false
//        sinDescriptionTextField.textColor = .label // Cor do texto que se adapta ao modo claro/escuro
//        sinDescriptionTextField.backgroundColor = .secondarySystemBackground // Fundo que se adapta ao modo claro/escuro
//        view.addSubview(sinDescriptionTextField)
//        
//        // Configura a posição do campo de texto
//        NSLayoutConstraint.activate([
//            sinDescriptionTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
//            sinDescriptionTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
//            sinDescriptionTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
//        ])
//        
//        // Botão para adicionar pecado
//        let addButton = UIButton(type: .system)
//        addButton.setTitle("Adicionar Pecado", for: .normal)
//        addButton.addTarget(self, action: #selector(addSin(_:)), for: .touchUpInside)
//        addButton.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(addButton)
//        
//        // Configura a posição do botão
//        NSLayoutConstraint.activate([
//            addButton.topAnchor.constraint(equalTo: sinDescriptionTextField.bottomAnchor, constant: 10),
//            addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
//        ])
//    }
//    
//    private func setupTableView(_ tableView: UITableView) {
//        tableView.delegate = self
//        tableView.dataSource = self
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "SinCell")
//    }
//    
//    private func setupConstraints() {
//        savedSinsTableView.translatesAutoresizingMaskIntoConstraints = false
//        committedSinsTableView.translatesAutoresizingMaskIntoConstraints = false
//        
//        NSLayoutConstraint.activate([
//            savedSinsTableView.topAnchor.constraint(equalTo: sinDescriptionTextField.bottomAnchor, constant: 40),
//            savedSinsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            savedSinsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            savedSinsTableView.heightAnchor.constraint(greaterThanOrEqualToConstant: 200), // Altura mínima
//            
//            committedSinsTableView.topAnchor.constraint(equalTo: savedSinsTableView.bottomAnchor, constant: 20),
//            committedSinsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            committedSinsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            committedSinsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor) // Preenche o restante da tela
//        ])
//    }
//    
//    // MARK: - SinViewModelDelegate
//    
//    func didUpdateSavedSins(_ savedSins: [Sin]) {
//        // Agrupar os pecados por mandamento
//        groupedSins = Dictionary(grouping: savedSins, by: { $0.commandments ?? "" }) // Substitua `commandments` pelo nome correto do atributo no modelo `Sin`
//        
//        // Lista dos mandamentos em ordem específica
//        let orderedMandaments = [
//            "Primeiro Mandamento",
//            "Segundo Mandamento",
//            "Terceiro Mandamento",
//            "Quarto Mandamento",
//            "Quinto Mandamento",
//            "Sexto Mandamento",
//            "Sétimo Mandamento",
//            "Oitavo Mandamento",
//            "Nono Mandamento",
//            "Décimo Mandamento"
//        ]
//        
//        // Ordena os mandamentos de acordo com a lista acima
//        mandaments = orderedMandaments.filter { groupedSins.keys.contains($0) } // Filtra apenas os mandamentos que existem
//        savedSinsTableView.reloadData() // Atualiza a tabela de pecados salvos
//    }
//    
//    func didUpdateCommittedSins(_ committedSins: [SinsInExamination]) {
//        // Atualiza a tabela de pecados confessados
//        committedSinsTableView.reloadData()
//    }
//    
//    func didFailToAddSin(with message: String) {
//        // Exibe uma mensagem de erro
//        showAlert(with: message)
//    }
//    
//    // Exibe um alerta com uma mensagem
//    private func showAlert(with message: String) {
//        let alert = UIAlertController(title: "Erro", message: message, preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "OK", style: .default))
//        present(alert, animated: true, completion: nil)
//    }
//    
//    // MARK: - Ações
//    
//    @objc func markSin(_ sender: UIButton) {
//        let sinIndex = sender.tag
//        let sin = viewModel.savedSins[sinIndex] // Obtém o pecado correspondente ao índice do botão
//        viewModel.markSin(sin)
//    }
//    
//    @objc func unmarkSin(_ sender: UIButton) {
//        let sinIndex = sender.tag
//        let committedSin = viewModel.committedSins[sinIndex] // Obtém o SinsInExamination correspondente ao índice do botão
//        
//        // Acessa o pecado a partir do SinsInExamination
//        if let sinsArray = committedSin.sins?.allObjects as? [Sin], let firstSin = sinsArray.first {
//            viewModel.unmarkSin(firstSin) // Passa o primeiro pecado para o método unmarkSin
//        }
//    }
//    
//    @objc func addSin(_ sender: UIButton) {
//        guard let sinDescription = sinDescriptionTextField.text, !sinDescription.isEmpty else {
//            showAlert(with: "Por favor, digite uma descrição.")
//            return
//        }
//        viewModel.addSin(with: sinDescription, commandment: "commandment", comDescription: "comDescription")
//        sinDescriptionTextField.text = "" // Limpa o campo de texto
//        viewModel.saveExamToConfession()
//    }
//}
//
//// MARK: - UITableViewDataSource e UITableViewDelegate
//
//extension ConsciousnessExamViewController: UITableViewDataSource, UITableViewDelegate {
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return tableView == savedSinsTableView ? mandaments.count : 1 // Apenas uma seção para pecados confessados
//    }
//    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        // Desmarca a célula após a seleção para remover a marcação visual
//        tableView.deselectRow(at: indexPath, animated: true)
//        
//        if tableView == savedSinsTableView {
//            let mandament = mandaments[indexPath.section]
//            if let sin = groupedSins[mandament]?[indexPath.row] {
//                if viewModel.isSinMarked(sin) {
//                    // Se o pecado já está marcado, desmarque-o
//                    viewModel.unmarkSin(sin)
//                    print("\(sin.sinDescription ?? "") foi desmarcado.")
//                } else {
//                    // Se o pecado não está marcado, marque-o
//                    viewModel.markSin(sin)
//                    print("\(sin.sinDescription ?? "") foi marcado.")
//                }
//            }
//        } else {
//            let committedSin = viewModel.committedSins[indexPath.row]
//            if let sinsArray = committedSin.sins?.allObjects as? [Sin], let firstSin = sinsArray.first {
//                if viewModel.isSinMarked(firstSin) {
//                    viewModel.unmarkSin(firstSin)
//                    print("\(firstSin.sinDescription ?? "") foi desmarcado.")
//                } else {
//                    viewModel.markSin(firstSin)
//                    print("\(firstSin.sinDescription ?? "") foi marcado.")
//                }
//            }
//        }
//        tableView.reloadData()
//    }
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if tableView == savedSinsTableView {
//            let mandament = mandaments[section]
//            return groupedSins[mandament]?.count ?? 0 // Número de pecados para o mandamento específico
//        } else {
//            return viewModel.committedSins.count // Acesso à propriedade pública
//        }
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "SinCell", for: indexPath)
//
//        if tableView == savedSinsTableView {
//            let mandament = mandaments[indexPath.section]
//            if let sin = groupedSins[mandament]?[indexPath.row] {
//                cell.textLabel?.text = sin.sinDescription // Acesso à descrição do pecado
//                
//                // Verifica se o pecado está marcado
//                if viewModel.isSinMarked(sin) {
//                    cell.textLabel?.textColor = .red // Se o pecado estiver marcado, mude a cor para vermelho
//                } else {
//                    cell.textLabel?.textColor = .label // Caso contrário, use a cor padrão
//                }
//
//                // Adiciona botão de marcar
//                let markButton = UIButton(type: .system)
//                markButton.setTitle("Marcar", for: .normal)
//                markButton.tag = indexPath.row
//                markButton.addTarget(self, action: #selector(markSin(_:)), for: .touchUpInside)
//                cell.accessoryView = markButton
//            }
//        } else {
//            let committedSin = viewModel.committedSins[indexPath.row]
//            if let sinsArray = committedSin.sins?.allObjects as? [Sin], let firstSin = sinsArray.first {
//                cell.textLabel?.text = firstSin.sinDescription // Exibe a descrição do pecado confessado
//                cell.textLabel?.textColor = .label // Cor padrão para pecados confessados
//            }
//
//            // Adiciona botão de desmarcar
//            let unmarkButton = UIButton(type: .system)
//            unmarkButton.setTitle("Desmarcar", for: .normal)
//            unmarkButton.tag = indexPath.row
//            unmarkButton.addTarget(self, action: #selector(unmarkSin(_:)), for: .touchUpInside)
//            cell.accessoryView = unmarkButton
//        }
//
//        return cell
//    }
//
//    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        if tableView == savedSinsTableView {
//            return mandaments[section] // Retorna o mandamento como título da seção
//        } else {
//            return "Pecados Confessados"
//        }
//    }
//}

//
//  ConsciousnessExamFourthViewController.swift
//  Macro02
//
//  Created by Victor Dantas on 21/10/24.
//

//import UIKit
//
//class ConsciousnessExamFourthViewController: UIViewController, UITextFieldDelegate {
//    
//    // MARK: - Propriedades
//    
//    weak var coordinator: ConsciousnessExamCoordinator?
//    var viewModel: SinViewModel
//    
//    // Componentes principais de UI
//    private let titleLabel = UILabel()
//    private let descriptionLabel = UILabel()
//    private let backBt = UIButton()
//    private let nextBt = UIButton()
//    private var progressBar: UIView!
//    private let closeButton = UIButton()
//    
//    //Text Input para adicionar Pecado
//    private let sinTextField: UITextField = {
//        let textInput = UITextField()
//        textInput.placeholder = "Anote seus pecados aqui."
//        textInput.borderStyle = .roundedRect
//        return textInput
//    }()
//    
//    //Botão para Submeter o Texto
//    private let sinSubmitButton: UIButton = {
//        let button = UIButton()
//        button.setTitle("+", for: .normal)
//        button.setTitleColor(.white, for: .normal)
//        button.backgroundColor = .blue
//        button.layer.cornerRadius = 10
//        return button
//    }()
//    
//    // Tabela para exibir os mandamentos e pecados
//    private let tableView = UITableView()
//    
//    // Array de mandamentos e um array para controlar o estado expandido de cada mandamento
//    private var commandments: [Commandment] = []
//    private var expandedStates: [Bool] = []
//    
//    // MARK: - Inicializador
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
//    //Remove the observers from Keyboard
//    deinit {
//        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
//        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
//    }
//    
//    // MARK: - Ciclo de Vida
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        configureView()
//        setupUIComponents()
//        loadCommandmentsAndStates()
//        setupKeyboard()
//        setupConstraints()
//    }
//    
//    // MARK: - Configurações
//    
//    // Configura a View
//    private func configureView() {
//        self.view.backgroundColor = .white
//        self.navigationItem.hidesBackButton = true
//    }
//    
//    // Carrega mandamentos e define os estados de expansão
//    private func loadCommandmentsAndStates() {
//        commandments = viewModel.loadCommandments(3)  // Carrega os mandamentos
//        expandedStates = Array(repeating: false, count: commandments.count)  // Inicializa como "não-expandidos"
//    }
//    
//    // MARK: - Configurações de UI
//    
//    // Configura os componentes da interface
//    private func setupUIComponents() {
//        setupProgressBar()
//        setupTitleLabel()
//        setupDescriptionLabel()
//        setupTableView()
//        setupCloseButton()
//        setupButtons()
//        setupTableFooterView()
//    }
//    
//    // Configura a barra de progresso
//    private func setupProgressBar() {
//        self.progressBar = ProgressBarUI(index: 2)
//        progressBar.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(progressBar)
//    }
//    
//    // Configura o título
//    private func setupTitleLabel() {
//        titleLabel.text = "Exame de Consciência"
//        titleLabel.font = UIFont.boldSystemFont(ofSize: 32)
//        titleLabel.numberOfLines = 2
//        titleLabel.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(titleLabel)
//    }
//    
//    // Configura o botão de fechar (X)
//    private func setupCloseButton() {
//        let largeConfig = UIImage.SymbolConfiguration(pointSize: 24, weight: .bold, scale: .large)
//        let largeImage = UIImage(systemName: "xmark", withConfiguration: largeConfig)
//        closeButton.setImage(largeImage, for: .normal)
//        closeButton.tintColor = .gray
//        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
//        closeButton.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(closeButton)
//    }
//    
//    // Configura o texto descritivo
//    private func setupDescriptionLabel() {
//        let paragraphStyle = NSMutableParagraphStyle()
//        paragraphStyle.lineSpacing = 10
//        let attributedText = NSAttributedString(string: """
//        Selecione o que faz sentido para você
//        """, attributes: [
//            .paragraphStyle: paragraphStyle,
//            .font: UIFont.systemFont(ofSize: 18)
//        ])
//        
//        descriptionLabel.attributedText = attributedText
//        descriptionLabel.textColor = .gray
//        descriptionLabel.numberOfLines = 0
//        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(descriptionLabel)
//    }
//    
//    // Configura a TableView
//    private func setupTableView() {
//        tableView.delegate = self
//        tableView.dataSource = self
//        tableView.separatorStyle = .none
//        tableView.translatesAutoresizingMaskIntoConstraints = false
//        tableView.register(CommandmentCell.self, forCellReuseIdentifier: CommandmentCell.reuseIdentifier)
//        tableView.register(SinCell.self, forCellReuseIdentifier: SinCell.reuseIdentifier)
//        view.addSubview(tableView)
//    }
//    
//    // Configura os botões "Back" e "Next"
//    private func setupButtons() {
//        setupBackButton()
//        setupNextButton()
//    }
//    
//    // Configura o botão "Back"
//    private func setupBackButton() {
//        backBt.setImage(UIImage(systemName: "arrow.left"), for: .normal)
//        backBt.backgroundColor = .black
//        backBt.tintColor = .white
//        backBt.layer.cornerRadius = view.bounds.width * 0.075
//        backBt.addTarget(self, action: #selector(goBack), for: .touchUpInside)
//        backBt.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(backBt)
//    }
//    
//    // Configura o botão "Next"
//    private func setupNextButton() {
//        nextBt.setImage(UIImage(systemName: "arrow.right"), for: .normal)
//        nextBt.backgroundColor = .black
//        nextBt.tintColor = .white
//        nextBt.layer.cornerRadius = view.bounds.width * 0.075
//        nextBt.addTarget(self, action: #selector(goForward), for: .touchUpInside)
//        nextBt.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(nextBt)
//    }
//    
//    // Configura o rodapé da tabela com o TextField e o botão de adicionar pecado
//    private func setupTableFooterView() {
//        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.bounds.height * 0.05))
//        
//        sinTextField.translatesAutoresizingMaskIntoConstraints = false
//        sinTextField.delegate = self
//        
//        sinSubmitButton.backgroundColor = .black
//        sinSubmitButton.translatesAutoresizingMaskIntoConstraints = false
//        
//        footerView.addSubview(sinTextField)
//        footerView.addSubview(sinSubmitButton)
//        
//        // Configurações de layout
//        NSLayoutConstraint.activate([
//            sinTextField.leadingAnchor.constraint(equalTo: footerView.leadingAnchor),
//            sinTextField.trailingAnchor.constraint(equalTo: footerView.trailingAnchor, constant: view.bounds.width * -0.2),
//            sinTextField.centerYAnchor.constraint(equalTo: footerView.bottomAnchor),
//            sinTextField.heightAnchor.constraint(equalTo: footerView.heightAnchor, multiplier: 0.75),
//            
//            sinSubmitButton.leadingAnchor.constraint(equalTo: sinTextField.trailingAnchor, constant: view.bounds.width * 0.05), // Espaço entre o TextField e o botão
//            sinSubmitButton.trailingAnchor.constraint(equalTo: footerView.trailingAnchor),
//            sinSubmitButton.centerYAnchor.constraint(equalTo: footerView.bottomAnchor),
//            sinSubmitButton.heightAnchor.constraint(equalTo: footerView.heightAnchor, multiplier: 0.75)
//        ])
//        
//        // Adiciona rodapé à TableView
//        tableView.tableFooterView = footerView
//        
//        // Adiciona ação ao botão
//        sinSubmitButton.addTarget(self, action: #selector(addSin), for: .touchUpInside)
//    }
//    
//    // MARK: - Ações dos botões Next, Back e X
//    
//    // Ação para fechar a view (X)
//    @objc private func closeButtonTapped() {
//        coordinator?.handleNavigation(.popToRoot)
//    }
//    
//    // Ação para voltar
//    @objc private func goBack() {
//        coordinator?.handleNavigation(.back)
//    }
//    
//    // Ação para avançar
//    @objc private func goForward() {
//        coordinator?.handleNavigation(.actOfContritionFirst)
//    }
//    
//    // Ação para adicionar pecado
//    @objc private func addSin() {
//        guard let newSin = sinTextField.text, !newSin.isEmpty else { return }
//        
//        let alertController = UIAlertController(title: "Escolha uma categoria", message: "Escolha uma categoria existente ou crie uma nova", preferredStyle: .alert)
//        
//        alertController.addAction(UIAlertAction(title: "Categoria Existente", style: .default, handler: { _ in
//            self.chooseExistingCategory(for: newSin)
//        }))
//        
//        alertController.addAction(UIAlertAction(title: "Nova Categoria", style: .default, handler: { _ in
//            self.addNewCategory(for: newSin)
//        }))
//        
//        alertController.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
//        
//        present(alertController, animated: true, completion: nil)
//        
//        // Limpar o campo de texto
//        sinTextField.text = ""
//    }
//    
//    // MARK: - Métodos Auxiliares para Adicionar Pecado
//    
//    // Método para adicionar pecado a uma categoria existente
//    private func chooseExistingCategory(for newSin: String) {
//        let alert = UIAlertController(title: "Escolha uma categoria", message: "Escolha uma categoria", preferredStyle: .alert)
//        
//        for commandment in viewModel.commandments {
//            alert.addAction(UIAlertAction(title: commandment.title, style: .default, handler: { _ in
//                self.addSinToCategory(newSin, categoryTitle: commandment.title)
//            }))
//        }
//        
//        present(alert, animated: true, completion: nil)
//    }
//    
//    // Adiciona pecado à categoria existente
//    private func addSinToCategory(_ newSin: String, categoryTitle: String) {
//        guard let index = viewModel.commandments.firstIndex(where: { $0.title == categoryTitle }) else { return }
//        
//        viewModel.commandments[index].sins.append(newSin)
//        tableView.reloadData()
//        
//        let lastIndexPath = IndexPath(row: viewModel.commandments[index].sins.count - 1, section: index)
//        tableView.scrollToRow(at: lastIndexPath, at: .bottom, animated: true)
//    }
//    
//    // Método para adicionar nova categoria
//    private func addNewCategory(for newSin: String) {
//        let alert = UIAlertController(title: "Nova Categoria", message: "Insira o título da nova categoria", preferredStyle: .alert)
//        
//        alert.addTextField { textField in
//            textField.placeholder = "Título da Categoria"
//        }
//        
//        alert.addTextField { textField in
//            textField.placeholder = "Descrição da Categoria"
//        }
//        
//        alert.addAction(UIAlertAction(title: "Criar", style: .default, handler: { [weak self] _ in
//            guard let title = alert.textFields?.first?.text,
//                  let description = alert.textFields?[1].text, !title.isEmpty, !description.isEmpty else { return }
//            
//            let newCommandment = Commandment(title: title, description: description, sins: [newSin])
//            self?.viewModel.commandments.append(newCommandment)
//            self?.tableView.reloadData()
//            
//            let lastSectionIndex = (self?.viewModel.commandments.count ?? 1) - 1
//            let lastIndexPath = IndexPath(row: 0, section: lastSectionIndex)
//            self?.tableView.scrollToRow(at: lastIndexPath, at: .bottom, animated: true)
//        }))
//        
//        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
//        present(alert, animated: true, completion: nil)
//    }
//    
//    // MARK: - Configurações de Layout
//        
//    private func setupConstraints() {
//        NSLayoutConstraint.activate([
//            // Barra de progresso no topo (altura proporcional à altura da tela)
//            progressBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            progressBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: view.bounds.width * 0.05),
//            progressBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: view.bounds.width * -0.05),
//            progressBar.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.01),  // Altura proporcional
//            
//            // Título (distância vertical proporcional ao tamanho da tela)
//            titleLabel.topAnchor.constraint(equalTo: progressBar.bottomAnchor, constant: view.bounds.height * 0.05),
//            titleLabel.leadingAnchor.constraint(equalTo: progressBar.leadingAnchor),
//            titleLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6),  // Largura proporcional à tela
//            
//            // Botão de fechar (X) (tamanho baseado na largura da tela)
//            closeButton.trailingAnchor.constraint(equalTo: progressBar.trailingAnchor),
//            closeButton.topAnchor.constraint(equalTo: titleLabel.topAnchor),
//            closeButton.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.05),  // Largura proporcional
//            closeButton.heightAnchor.constraint(equalToConstant: view.bounds.width * 0.05),  // Altura proporcional
//            
//            // Descrição (distância vertical proporcional ao tamanho da tela)
//            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: view.bounds.height * 0.035),
//            descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
//            descriptionLabel.trailingAnchor.constraint(equalTo: closeButton.trailingAnchor),
//            
//            // TableView (preenche o espaço restante entre a descrição e o botão de voltar)
//            tableView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: view.bounds.height * 0.03),
//            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.bounds.width * 0.05),
//            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: view.bounds.width * -0.05),
//            tableView.bottomAnchor.constraint(equalTo: backBt.topAnchor, constant: view.bounds.height * -0.02),
//            
//            // Botão "Back" (tamanho proporcional à largura da tela)
//            backBt.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.15),
//            backBt.heightAnchor.constraint(equalToConstant: view.bounds.width * 0.15),
//            backBt.leadingAnchor.constraint(equalTo: progressBar.leadingAnchor),
//            backBt.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: view.bounds.height * -0.01),
//            
//            // Botão "Next" (tamanho proporcional à largura da tela)
//            nextBt.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.15),
//            nextBt.heightAnchor.constraint(equalToConstant: view.bounds.width * 0.15),
//            nextBt.trailingAnchor.constraint(equalTo: tableView.trailingAnchor),
//            nextBt.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: view.bounds.height * -0.01)
//        ])
//    }
//}
//
//// MARK: - Keyboard
//extension ConsciousnessExamFourthViewController {
//    //MARK: Keyboard Functions
//    @objc func keyboardWillShow(notification: NSNotification) {
//        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
//            let keyboardHeight = keyboardSize.height
//            let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight, right: 0)
//            tableView.contentInset = contentInsets
//            tableView.scrollIndicatorInsets = contentInsets
//            
//            // Se quiser que o TextField esteja visível ao aparecer o teclado
//            if let activeField = tableView.tableFooterView {
//                let visibleRect = self.view.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight, right: 0))
//                if !visibleRect.contains(activeField.frame.origin) {
//                    tableView.scrollRectToVisible(activeField.frame, animated: true)
//                }
//            }
//        }
//    }
//    
//    @objc func keyboardWillHide(notification: NSNotification) {
//        let contentInsets = UIEdgeInsets.zero
//        tableView.contentInset = contentInsets
//        tableView.scrollIndicatorInsets = contentInsets
//    }
//    
//    //Dissmiss the keyboard
//    @objc func dismissKeyboard() {
//        view.endEditing(true)
//    }
//    
//    //Observe keyboard notifications
//    private func setupKeyboard() {
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
//    }
//    
//    
//    
//    //add gesture to Hide keyboard when touch outside
//    private func setupTapGesture() {
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
//        tapGesture.cancelsTouchesInView = false
//        view.addGestureRecognizer(tapGesture)
//    }
//    
//    //Hide Keyboard when return is pressed
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        textField.resignFirstResponder()
//        return true
//    }
//}
//
//
//// MARK: - Extensão para TableView
//extension ConsciousnessExamFourthViewController: UITableViewDelegate, UITableViewDataSource {
//
//    // Define o número de linhas considerando mandamentos e pecados
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        var count = 0
//        for (index, commandment) in commandments.enumerated() {
//            count += 1  // Conta o mandamento
//            if expandedStates[index] {  // Se estiver expandido, conta os pecados
//                count += commandment.sins.count
//            }
//        }
//        return count
//    }
//
//    // Configura cada célula da tabela
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        var currentIndex = 0
//        
//        for (index, commandment) in commandments.enumerated() {
//            // Verifica se a linha atual é um mandamento
//            if currentIndex == indexPath.row {
//                guard let cell = tableView.dequeueReusableCell(withIdentifier: CommandmentCell.reuseIdentifier, for: indexPath) as? CommandmentCell else {
//                    return UITableViewCell()
//                }
//                cell.configure(with: commandment)
//                
//                // Alterna entre os ícones chevron.right e chevron.down
//                let chevronImageName = expandedStates[index] ? "chevron.down" : "chevron.right"
//                cell.accessoryView = UIImageView(image: UIImage(systemName: chevronImageName))
//                cell.accessoryView?.tintColor = .black
//                
//                return cell
//            }
//            
//            currentIndex += 1
//            
//            // Verifica se a linha atual é um pecado
//            if expandedStates[index] {
//                for sin in commandment.sins {
//                    if currentIndex == indexPath.row {
//                        guard let cell = tableView.dequeueReusableCell(withIdentifier: SinCell.reuseIdentifier, for: indexPath) as? SinCell else {
//                            return UITableViewCell()
//                        }
//                        cell.configure(with: sin)
//                        return cell
//                    }
//                    currentIndex += 1
//                }
//            }
//        }
//        
//        return UITableViewCell()
//    }
//
//    // Ação executada ao selecionar uma célula da tabela
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        // Inicializa uma variável para acompanhar o índice da célula atual
//        var currentIndex = 0
//        
//        // Itera sobre a lista de mandamentos e seus índices
//        for (index, _) in commandments.enumerated() {
//            
//            // Verifica se a célula selecionada corresponde a um mandamento
//            if currentIndex == indexPath.row {
//                // Alterna o estado de expansão do mandamento (expande ou contrai)
//                expandedStates[index].toggle()
//                
//                // Recarrega os dados da tabela para refletir a alteração de estado (expansão ou contração)
//                tableView.reloadData()
//                
//                // Encerra o loop após encontrar a célula correspondente
//                break
//            }
//            
//            // Incrementa o índice para passar para a próxima linha
//            currentIndex += 1
//            
//            // Se o mandamento estiver expandido, conta os pecados (subcélulas) associados
//            if expandedStates[index] {
//                // Adiciona a quantidade de pecados associados ao mandamento expandido ao índice atual
//                currentIndex += commandments[index].sins.count
//            }
//        }
//    }
//
//
//    // Define a altura automática das células
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableView.automaticDimension + view.bounds.height * 0.1
//    }
//
//    // Define uma altura estimada para melhor desempenho
//    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//        return view.bounds.height * 0.2
//    }
//}

//
//  ConsciousnessExamFourthViewController.swift
//  Macro02
//
//  Created by Victor Dantas on 21/10/24.
//

import UIKit

class ConsciousnessExamFourthViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: - Propriedades
    weak var coordinator: ConsciousnessExamCoordinator?
    var viewModel: SinViewModel
    
    // Componentes principais de UI
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let backBt = UIButton()
    private let nextBt = UIButton()
    private var progressBar: UIView!
    private let closeButton = UIButton()
    
    // Text Input para adicionar Pecado
    private let sinTextField: UITextField = {
        let textInput = UITextField()
        textInput.placeholder = "Anote seus pecados aqui."
        textInput.borderStyle = .roundedRect
        return textInput
    }()
    
    // Botão para Submeter o Texto
    private let sinSubmitButton: UIButton = {
        let button = UIButton()
        button.setTitle("+", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 10
        return button
    }()
    
    // Tabela para exibir os mandamentos e pecados
    private let tableView = UITableView()
    
    // Array de mandamentos e um array para controlar o estado expandido de cada mandamento
    private var commandments: [(commandment: String, sins: [Sin])] = []
    private var expandedStates: [Bool] = []
    
    // MARK: - Inicializador
    init(viewModel: SinViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Ciclo de Vida
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        setupUIComponents()
        setupKeyboard()
        setupConstraints()
        
        viewModel.delegate = self
        viewModel.fetchAllSins()
    }
    
    // MARK: - Configurações
    private func configureView() {
        self.view.backgroundColor = .white
        self.navigationItem.hidesBackButton = true
    }
    
    // Configurações de UI
    private func setupUIComponents() {
        setupProgressBar()
        setupTitleLabel()
        setupDescriptionLabel()
        setupTableView()
        setupCloseButton()
        setupButtons()
        setupTableFooterView()
    }
    
    // Barra de progresso estilo stories
    private func setupProgressBar() {
        self.progressBar = ProgressBarUI(index: 2)
        progressBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(progressBar)
    }
    
    
    // Título
    private func setupTitleLabel() {
        titleLabel.text = "Exame de Consciência"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 32)
        titleLabel.numberOfLines = 2
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
    }
    
    // Botão X que volta pra Home
    private func setupCloseButton() {
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 24, weight: .bold, scale: .large)
        let largeImage = UIImage(systemName: "xmark", withConfiguration: largeConfig)
        closeButton.setImage(largeImage, for: .normal)
        closeButton.tintColor = .gray
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(closeButton)
    }
    
    // Texto descritivo da View
    private func setupDescriptionLabel() {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 10
        let attributedText = NSAttributedString(string: """
        Selecione o que faz sentido para você
        """, attributes: [
            .paragraphStyle: paragraphStyle,
            .font: UIFont.systemFont(ofSize: 18)
        ])
        
        descriptionLabel.attributedText = attributedText
        descriptionLabel.textColor = .gray
        descriptionLabel.numberOfLines = 0
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(descriptionLabel)
    }
    
    // TableView dos mandamentos e pecados
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(CommandmentCell.self, forCellReuseIdentifier: CommandmentCell.reuseIdentifier)
        tableView.register(SinCell.self, forCellReuseIdentifier: SinCell.reuseIdentifier)
        view.addSubview(tableView)
    }
    
    // Botões de navegação (voltar e avançar)
    // Voltar
    private func setupBackButton() {
        backBt.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        backBt.backgroundColor = .black
        backBt.tintColor = .white
        backBt.layer.cornerRadius = view.bounds.width * 0.075
        backBt.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        backBt.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backBt)
    }
    
    // Avançar
    private func setupNextButton() {
        nextBt.setImage(UIImage(systemName: "arrow.right"), for: .normal)
        nextBt.backgroundColor = .black
        nextBt.tintColor = .white
        nextBt.layer.cornerRadius = view.bounds.width * 0.075
        nextBt.addTarget(self, action: #selector(goForward), for: .touchUpInside)
        nextBt.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nextBt)
    }
    
    private func setupButtons() {
        setupBackButton()
        setupNextButton()
    }
    
    // Footer da Table View com o TextField e botão para adicionar pecados
    private func setupTableFooterView() {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.bounds.height * 0.1))
        
        sinTextField.translatesAutoresizingMaskIntoConstraints = false
        sinTextField.delegate = self
        
        sinSubmitButton.translatesAutoresizingMaskIntoConstraints = false
        sinSubmitButton.tintColor = .black
        
        footerView.addSubview(sinTextField)
        footerView.addSubview(sinSubmitButton)
        
        NSLayoutConstraint.activate([
            sinTextField.widthAnchor.constraint(equalTo: footerView.widthAnchor, multiplier: 0.75),
            sinTextField.heightAnchor.constraint(equalTo: footerView.heightAnchor, multiplier: 0.5),
            sinTextField.leadingAnchor.constraint(equalTo: footerView.leadingAnchor),
            sinTextField.centerYAnchor.constraint(equalTo: footerView.centerYAnchor),
            
            sinSubmitButton.heightAnchor.constraint(equalTo: footerView.heightAnchor, multiplier: 0.5),
            sinSubmitButton.trailingAnchor.constraint(equalTo: footerView.trailingAnchor),
            sinSubmitButton.centerYAnchor.constraint(equalTo: footerView.centerYAnchor),
            sinSubmitButton.leadingAnchor.constraint(equalTo: sinTextField.trailingAnchor, constant: view.bounds.width * 0.05),
        ])
        
        tableView.tableFooterView = footerView
        sinSubmitButton.addTarget(self, action: #selector(addSin), for: .touchUpInside)
    }

    
    // MARK: - Ações
    // Navegação
    @objc private func closeButtonTapped() {
        coordinator?.handleNavigation(.popToRoot)
    }
    
    @objc private func goBack() {
        coordinator?.handleNavigation(.back)
    }
    
    @objc private func goForward() {
        coordinator?.handleNavigation(.actOfContritionFirst)
    }
    
    // Adicionar pecado
    @objc private func addSin() {
        guard let newSin = sinTextField.text, !newSin.isEmpty else { return }
        
        let alertController = UIAlertController(title: "Escolha uma categoria", message: "Escolha uma categoria existente ou crie uma nova", preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "Categoria Existente", style: .default, handler: { _ in
            self.chooseExistingCategory(for: newSin)
        }))
        
        alertController.addAction(UIAlertAction(title: "Nova Categoria", style: .default, handler: { _ in
            self.addNewCategory(for: newSin)
        }))
        
        alertController.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
        
        present(alertController, animated: true, completion: nil)
        
        sinTextField.text = ""
    }
    
    private func chooseExistingCategory(for newSin: String) {
        let alert = UIAlertController(title: "Escolha uma categoria", message: "Escolha uma categoria", preferredStyle: .alert)
        
        for commandment in commandments {
            alert.addAction(UIAlertAction(title: commandment.commandment, style: .default, handler: { _ in
                self.addSinToCategory(newSin, categoryTitle: commandment.commandment)
            }))
        }
        
        present(alert, animated: true, completion: nil)
    }
    
    private func addSinToCategory(_ newSin: String, categoryTitle: String) {
        // Adiciona o pecado à categoria correspondente via ViewModel
        viewModel.addSin(with: newSin, commandment: categoryTitle, comDescription: "")
        tableView.reloadData()
    }
    
    private func addNewCategory(for newSin: String) {
        let alert = UIAlertController(title: "Nova Categoria", message: "Insira o título da nova categoria", preferredStyle: .alert)
        
        alert.addTextField { textField in
            textField.placeholder = "Título da Categoria"
        }
        
        alert.addTextField { textField in
            textField.placeholder = "Descrição da Categoria"
        }
        
        alert.addAction(UIAlertAction(title: "Criar", style: .default, handler: { [weak self] _ in
            guard let title = alert.textFields?.first?.text,
                  let description = alert.textFields?[1].text, !title.isEmpty, !description.isEmpty else { return }
            
            self?.viewModel.addSin(with: newSin, commandment: title, comDescription: description)
            self?.tableView.reloadData()
        }))
        
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Configurações de Layout
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            progressBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            progressBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: view.bounds.width * 0.05),
            progressBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: view.bounds.width * -0.05),
            progressBar.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.01),
            
            titleLabel.topAnchor.constraint(equalTo: progressBar.bottomAnchor, constant: view.bounds.height * 0.05),
            titleLabel.leadingAnchor.constraint(equalTo: progressBar.leadingAnchor),
            titleLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6),
            
            closeButton.trailingAnchor.constraint(equalTo: progressBar.trailingAnchor),
            closeButton.topAnchor.constraint(equalTo: titleLabel.topAnchor),
            closeButton.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.05),
            closeButton.heightAnchor.constraint(equalToConstant: view.bounds.width * 0.05),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: view.bounds.height * 0.035),
            descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: closeButton.trailingAnchor),
            
            tableView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: view.bounds.height * 0.03),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.bounds.width * 0.05),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: view.bounds.width * -0.05),
            tableView.bottomAnchor.constraint(equalTo: backBt.topAnchor, constant: view.bounds.height * -0.02),
            
            backBt.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.15),
            backBt.heightAnchor.constraint(equalToConstant: view.bounds.width * 0.15),
            backBt.leadingAnchor.constraint(equalTo: progressBar.leadingAnchor),
            backBt.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: view.bounds.height * -0.01),
            
            nextBt.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.15),
            nextBt.heightAnchor.constraint(equalToConstant: view.bounds.width * 0.15),
            nextBt.trailingAnchor.constraint(equalTo: tableView.trailingAnchor),
            nextBt.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: view.bounds.height * -0.01)
        ])
    }
}

// MARK: - ViewModel Delegate
extension ConsciousnessExamFourthViewController: SinViewModelDelegate {
    
    func didUpdateSavedSins(_ savedSins: [Sin]) {
        commandments = viewModel.getGroupedSinsForLastThreeCommandments()
        expandedStates = Array(repeating: false, count: commandments.count)  // Define todos os mandamentos como "não expandidos"
        
        // Debugging: Verifique se os mandamentos estão sendo carregados corretamente
        print("Número de mandamentos carregados: \(commandments.count)")
        
        tableView.reloadData()
    }
    
    func didUpdateCommittedSins(_ committedSins: [SinsInExamination]) {
        // Atualizar a interface para refletir os pecados confessados
    }
    
    func didFailToAddSin(with message: String) {
        let alert = UIAlertController(title: "Erro", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

// MARK: - Extensão para TableView
extension ConsciousnessExamFourthViewController: UITableViewDelegate, UITableViewDataSource {

    // Número de linhas, considerando mandamentos e pecados expandidos
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = 0
        for (index, commandment) in commandments.enumerated() {
            count += 1 // Conta o mandamento
            if expandedStates[index] {
                count += commandment.sins.count // Conta os pecados se expandido
            }
        }
        return count
    }

    // Configuração de células
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var currentIndex = 0
        
        for (index, commandment) in commandments.enumerated() {
            if currentIndex == indexPath.row {
                // Aqui configuramos a célula para o mandamento
                guard let cell = tableView.dequeueReusableCell(withIdentifier: CommandmentCell.reuseIdentifier, for: indexPath) as? CommandmentCell else {
                    return UITableViewCell()
                }
                // Configure a célula com o título do mandamento, não os pecados
                cell.configure(withTitle: commandment.commandment, description: commandment.sins.first?.commandmentDescription ?? "")
                
                let chevronImageName = expandedStates[index] ? "chevron.down" : "chevron.right"
                cell.accessoryView = UIImageView(image: UIImage(systemName: chevronImageName))
                cell.selectionStyle = .none
                
                return cell
            }
            
            currentIndex += 1
            
            if expandedStates[index] {
                for sin in commandment.sins {
                    if currentIndex == indexPath.row {
                        // Aqui configuramos a célula para os pecados
                        guard let cell = tableView.dequeueReusableCell(withIdentifier: SinCell.reuseIdentifier, for: indexPath) as? SinCell else {
                            return UITableViewCell()
                        }
                        cell.configure(with: sin.sinDescription ?? "", isSelected: sin.isSelected)
                        cell.isSinSelected = sin.isSelected  // Define a aparência com base no estado do pecado
                        cell.selectionStyle = .none
                        return cell
                    }
                    currentIndex += 1
                }
            }
        }
        
        return UITableViewCell()
    }

    // Expande ou contrai o mandamento ao tocar ou altera a aparência do pecado ao clicar nele
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var currentIndex = 0

        // Loop através dos mandamentos
        for (index, commandment) in commandments.enumerated() {
            
            // Se o índice atual for o índice do mandamento, expande ou contrai
            if currentIndex == indexPath.row {
                expandedStates[index].toggle()
                
                // Começa a animação de atualização da tabela
                tableView.beginUpdates()
                
                // Inserir ou deletar linhas de pecados associados ao mandamento
                let indexPaths = (1...commandment.sins.count).map { IndexPath(row: currentIndex + $0, section: 0) }
                if expandedStates[index] {
                    tableView.insertRows(at: indexPaths, with: .fade)
                } else {
                    tableView.deleteRows(at: indexPaths, with: .fade)
                }
                
                tableView.endUpdates()
                
                // Recarrega a célula de mandamento para garantir que o chevron seja atualizado
                if let commandmentCell = tableView.cellForRow(at: indexPath) as? CommandmentCell {
                    animateChevronRotation(for: commandmentCell, expanded: expandedStates[index])
                }
                
                return // Termina aqui se foi um mandamento que foi tocado
            }
            
            // Avança para as células de pecados associadas ao mandamento
            currentIndex += 1
            
            // Se o mandamento estiver expandido, verifique se a célula clicada é um pecado
            if expandedStates[index] {
                for (_, sin) in commandment.sins.enumerated() {
                    if currentIndex == indexPath.row {
                        // Se for um pecado, alterna o estado de seleção e aparência
                        sin.isSelected.toggle()  // Alterna o estado do pecado
                        
                        // Atualiza a aparência da célula com base no estado de seleção
                        if let sinCell = tableView.cellForRow(at: indexPath) as? SinCell {
                            sinCell.isSinSelected = sin.isSelected  // Atualiza a aparência da célula
                        }
                        
                        // Atualiza a célula para refletir a mudança
                        tableView.reloadRows(at: [indexPath], with: .none)
                        
                        return // Termina após processar o pecado clicado
                    }
                    currentIndex += 1 // Avança para o próximo pecado
                }
            }
        }
    }

    // Função para animar a rotação do chevron
    func animateChevronRotation(for cell: CommandmentCell, expanded: Bool) {
        guard let chevronView = cell.accessoryView as? UIImageView else { return }
        
        if expanded {
            chevronView.image = UIImage(systemName: "chevron.down")
        } else {
            chevronView.image = UIImage(systemName: "chevron.right")
        }
    }


    // Define a altura das células
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension + view.bounds.height * 0.1
    }

    // Define uma altura estimada para melhor desempenho
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.bounds.height * 0.2
    }
}

// MARK: - Keyboard
extension ConsciousnessExamFourthViewController {
    //MARK: Keyboard Functions
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let keyboardHeight = keyboardSize.height
            let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight, right: 0)
            tableView.contentInset = contentInsets
            tableView.scrollIndicatorInsets = contentInsets
            
            // Se quiser que o TextField esteja visível ao aparecer o teclado
            if let activeField = tableView.tableFooterView {
                let visibleRect = self.view.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight, right: 0))
                if !visibleRect.contains(activeField.frame.origin) {
                    tableView.scrollRectToVisible(activeField.frame, animated: true)
                }
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        let contentInsets = UIEdgeInsets.zero
        tableView.contentInset = contentInsets
        tableView.scrollIndicatorInsets = contentInsets
    }
    
    //Dissmiss the keyboard
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    //Observe keyboard notifications
    private func setupKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    //add gesture to Hide keyboard when touch outside
    private func setupTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    //Hide Keyboard when return is pressed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
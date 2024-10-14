import UIKit

class ConsciousnessExamViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {

    private let tableView = UITableView()
    
    var viewModel = SinViewModel()
    var coordinator: ConsciousnessExamCoordinator?
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Exame de Consciência"
        
        setupTableView()
        viewModel.fetchAllSins() // Chama a busca dos pecados
        tableView.reloadData() // Recarrega a tabela para exibir os dados buscados
        setupTableFooterView()
        
        setupKeyboard()
        setupTapGesture()
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "SinCell")
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
        return 1 // Exibindo uma única seção com todos os pecados
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.savedSins.count // Contando todos os pecados
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SinCell", for: indexPath)
        let sin = viewModel.savedSins[indexPath.row]
        
        cell.textLabel?.text = sin.sinDescription // Certifique-se de que isso está preenchido corretamente
        cell.accessoryType = viewModel.isSinMarked(sin) ? .checkmark : .none
        
        // Alterar a cor da célula baseado no estado
        cell.backgroundColor = viewModel.isSinMarked(sin) ? .red : .white
        
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sin = viewModel.savedSins[indexPath.row]
        
        // Marca ou desmarca o pecado através do ViewModel
        if viewModel.isSinMarked(sin) {
            viewModel.unmarkSin(sin)
        } else {
            viewModel.markSin(sin)
        }
        
        // Atualiza a célula com a nova cor e estado
        tableView.reloadRows(at: [indexPath], with: .automatic)
        
        // Salva as alterações no Core Data após marcar/desmarcar
        viewModel.saveExamToConfession()
    }
    
    // MARK: - Footer View
    
    private func setupTableFooterView() {
        let footerView = UIView()
        footerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 100)
        
        footerView.addSubview(sinTextField)
        footerView.addSubview(sinSubmitButton)
        
        sinTextField.delegate = self
        
        sinTextField.translatesAutoresizingMaskIntoConstraints = false
        sinSubmitButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            sinTextField.leadingAnchor.constraint(equalTo: footerView.leadingAnchor, constant: 16),
            sinTextField.trailingAnchor.constraint(equalTo: footerView.trailingAnchor, constant: -16),
            sinTextField.topAnchor.constraint(equalTo: footerView.topAnchor, constant: 8),
            sinTextField.heightAnchor.constraint(equalToConstant: 40),
            
            sinSubmitButton.topAnchor.constraint(equalTo: sinTextField.bottomAnchor, constant: 8),
            sinSubmitButton.centerXAnchor.constraint(equalTo: footerView.centerXAnchor),
            sinSubmitButton.heightAnchor.constraint(equalToConstant: 40),
            sinSubmitButton.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        tableView.tableFooterView = footerView
        sinSubmitButton.addTarget(self, action: #selector(saveSins), for: .touchUpInside)
    }
    
    @objc private func saveSins() {
        // Verifica se o texto não está vazio
        guard let sinText = sinTextField.text, !sinText.isEmpty else {
            let alert = UIAlertController(title: "Erro", message: "Por favor, digite um pecado.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default))
            present(alert, animated: true)
            return
        }
        
        // Salva o novo pecado no ViewModel
        viewModel.addSin(with: sinText)
        sinTextField.text = nil // Limpa o campo de texto
        tableView.reloadData() // Recarrega a tabela para mostrar o novo pecado
    }
    
    // MARK: - Keyboard Handling
    
    private func setupKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
            tableView.contentInset = contentInset
            tableView.scrollIndicatorInsets = contentInset
        }
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        let contentInset = UIEdgeInsets.zero
        tableView.contentInset = contentInset
        tableView.scrollIndicatorInsets = contentInset
    }
    
    private func setupTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}
